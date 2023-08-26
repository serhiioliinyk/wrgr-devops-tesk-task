region = "nyc1"

node_pool = {
  name       = "main"
  size       = "s-1vcpu-2gb"
  auto_scale = false
  node_count = "2"
}
services_node_pool = {
  infrastructure = {
    size       = "s-2vcpu-4gb"
    auto_scale = true
    min_nodes  = "2"
    max_nodes  = "10"
    tags       = "infrastructure-dev"
    labels     = {
      service = "infrastructure"
    }
  }
}

name                     = "cluster"
env                      = "dev"
version_k8s              = "1.27.4-do.0"
ha                       = false
enabled_argocd           = false
tags                     = "k8s"
argocd_repo_url          = "https://github.com/serhiioliinyk/tf-argocd-infrastructure.git"
argocd_domain_name       = "argo.dev.test.domain"
ca_api_key               = ""
github_username          = ""
github_password          = ""
registry_server          = "https://registry-1.docker.io"
registry_username        = ""
registry_password        = ""
registry_email           = ""
docker_creds_secret_name = "dockerhub-secret"
argocd_namespace         = "argocd"