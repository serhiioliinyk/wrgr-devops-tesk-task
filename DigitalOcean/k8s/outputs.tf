output "cluster_id" {
  value = digitalocean_kubernetes_cluster.kubernetes_cluster.id
}

output "cluster_edpoint" {
  value = digitalocean_kubernetes_cluster.kubernetes_cluster.endpoint
}

output "kube_token" {
  sensitive = true
  value     = digitalocean_kubernetes_cluster.kubernetes_cluster.kube_config[0].token
}

output "kube_ca" {
  sensitive = true
  value     = digitalocean_kubernetes_cluster.kubernetes_cluster.kube_config[0].cluster_ca_certificate
}
