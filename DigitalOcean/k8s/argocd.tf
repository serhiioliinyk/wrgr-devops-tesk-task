locals {
  helm_releases      = yamldecode(file("${path.module}/helm-releases.yaml"))["releases"]
  argocd_domain_name = var.argocd_domain_name

  argocd = {
    name          = local.helm_releases[index(local.helm_releases.*.id, "argocd")].id
    enabled       = var.enabled_argocd
    chart         = local.helm_releases[index(local.helm_releases.*.id, "argocd")].chart
    repository    = local.helm_releases[index(local.helm_releases.*.id, "argocd")].repository
    chart_version = local.helm_releases[index(local.helm_releases.*.id, "argocd")].chart_version
  }

  argocd-app = {
    name          = local.helm_releases[index(local.helm_releases.*.id, "argocd-app")].id
    enabled       = var.enabled_argocd
    chart         = local.helm_releases[index(local.helm_releases.*.id, "argocd-app")].chart
    repository    = local.helm_releases[index(local.helm_releases.*.id, "argocd-app")].repository
    chart_version = local.helm_releases[index(local.helm_releases.*.id, "argocd-app")].chart_version
  }


  argocd-infra = {
    name          = local.helm_releases[index(local.helm_releases.*.id, "argocd-infra")].id
    enabled       = var.enabled_argocd
    chart         = local.helm_releases[index(local.helm_releases.*.id, "argocd-infra")].chart
    repository    = local.helm_releases[index(local.helm_releases.*.id, "argocd-infra")].repository
    chart_version = local.helm_releases[index(local.helm_releases.*.id, "argocd-infra")].chart_version
  }

  argocd-image-updater = {
    name          = local.helm_releases[index(local.helm_releases.*.id, "argocd-image-updater")].id
    enabled       = var.enabled_argocd
    chart         = local.helm_releases[index(local.helm_releases.*.id, "argocd-image-updater")].chart
    repository    = local.helm_releases[index(local.helm_releases.*.id, "argocd-image-updater")].repository
    chart_version = local.helm_releases[index(local.helm_releases.*.id, "argocd-image-updater")].chart_version
  }


  argocd_values = <<VALUES
global:
  nodeSelector:
    service: infrastructure
configs:
  cm:
    admin.enabled: true
    url: https://${local.argocd_domain_name}
    dex.config: |
      connectors:
      - type: github
        id: github
        name: GitHub
        config:
          clientID: ${var.github_clientID}
          clientSecret: ${var.github_clientSecret}
          orgs:
          - name: ${var.github_org_name}
            teams:
            - ${var.admin_github_team_name}
            - ${var.readonly_github_team_name}
            - ${var.readwrite_github_team_name}
  repositories:
    github-repo:
      name: "argo-devops"
      project: "default"
      username: "${var.github_username}"
      password: "${var.github_password}"
      type: "git"
      url: "${var.argocd_repo_url}"
server:
  extraArgs:
  - --insecure
  ingress:
    enabled: true
    annotations:
      kubernetes.io/ingress.class: 'nginx'
      external-dns.alpha.kubernetes.io/hostname: ${local.argocd_domain_name}
      cert-manager.io/issuer: 'argocd-issuer'
      cert-manager.io/issuer-kind: 'OriginIssuer'
      cert-manager.io/issuer-group: 'cert-manager.k8s.cloudflare.com'
      cert-manager.io/duration: '2880h'
      cert-manager.io/renewalBefore: '720h'
    hosts:
      - ${local.argocd_domain_name}
    paths:
      - /
    pathType: Prefix
    tls:
      - hosts:
          - ${local.argocd_domain_name}
        secretName: argocd-secret-tls
repoServer:
  rbac:
    - verbs:
        - get
        - list
        - watch
      apiGroups:
        - ''
      resources:
        - secrets
        - configmaps
VALUES

  argocd-app_values = <<VALUES
name: app-${var.env}
path: 'argocd-${var.env}-applications'
repoUrl: ${var.argocd_repo_url}
VALUES

  argocd-infra_values = <<VALUES
name: infra-${var.env}
path: 'argocd-${var.env}-infra'
repoUrl: ${var.argocd_repo_url}
VALUES

  argocd-image-updater_values = <<VALUES
config:
  registries:
  - name: Docker Hub
    api_url: ${var.registry_server}
    ping: yes
    prefix: docker.io
    credentials: pull-secret:argo-cd/${var.docker_creds_secret_name}
nodeSelector:
  service: infrastructure
VALUES
}

resource "kubernetes_namespace" "argo-cd" {
  count = var.enabled_argocd ? 1 : 0
  metadata {
    annotations = {
      name = var.argocd_namespace
    }

    name = var.argocd_namespace
  }
  depends_on = [
    digitalocean_kubernetes_cluster.kubernetes_cluster,
    digitalocean_kubernetes_node_pool.services_node_pool
  ]
}

resource "helm_release" "argocd" {
  count = local.argocd.enabled ? 1 : 0

  name        = local.argocd.name
  chart       = local.argocd.chart
  repository  = local.argocd.repository
  version     = local.argocd.chart_version
  namespace   = var.argocd_namespace
  max_history = var.helm_release_history_size

  values = [
    local.argocd_values
  ]
  depends_on = [
    digitalocean_kubernetes_cluster.kubernetes_cluster,
    digitalocean_kubernetes_node_pool.services_node_pool
  ]

}

resource "helm_release" "argocd-app" {
  count       = local.argocd-app.enabled ? 1 : 0
  name        = local.argocd-app.name
  chart       = local.argocd-app.chart
  repository  = local.argocd-app.repository
  version     = local.argocd-app.chart_version
  namespace   = var.argocd_namespace
  max_history = var.helm_release_history_size

  values = [
    local.argocd-app_values
  ]
  depends_on = [
    helm_release.argocd
  ]
}

resource "helm_release" "argocd-infra" {
  count = local.argocd-app.enabled ? 1 : 0

  name        = local.argocd-infra.name
  chart       = local.argocd-infra.chart
  repository  = local.argocd-infra.repository
  version     = local.argocd-infra.chart_version
  namespace   = var.argocd_namespace
  max_history = var.helm_release_history_size

  values = [
    local.argocd-infra_values
  ]
  depends_on = [
    helm_release.argocd
  ]
}

resource "helm_release" "argocd-image-updater" {
  count = local.argocd-image-updater.enabled ? 1 : 0

  name        = local.argocd-image-updater.name
  chart       = local.argocd-image-updater.chart
  repository  = local.argocd-image-updater.repository
  version     = local.argocd-image-updater.chart_version
  namespace   = var.argocd_namespace
  max_history = var.helm_release_history_size

  values = [
    local.argocd-image-updater_values
  ]
  depends_on = [
    helm_release.argocd
  ]
}


resource "kubernetes_secret" "argocd-ca-api-key" {
  count = var.enabled_argocd ? 1 : 0
  metadata {
    name      = "argocd-ca-api-key"
    namespace = var.argocd_namespace
  }
  depends_on = [
    digitalocean_kubernetes_cluster.kubernetes_cluster,
    digitalocean_kubernetes_node_pool.services_node_pool
  ]

  data = {
    key = var.ca_api_key
  }

  type = "Opaque"
}

resource "kubernetes_secret" "dockerhub-secret" {
  count = var.enabled_argocd ? 1 : 0
  metadata {
    name      = var.docker_creds_secret_name
    namespace = var.argocd_namespace
  }
  depends_on = [
    digitalocean_kubernetes_cluster.kubernetes_cluster,
    digitalocean_kubernetes_node_pool.services_node_pool
  ]

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${var.registry_server}" = {
          "username" = var.registry_username
          "password" = var.registry_password
          "email"    = var.registry_email
          "auth"     = base64encode("${var.registry_username}:${var.registry_password}")
        }
      }
    })
  }
}

