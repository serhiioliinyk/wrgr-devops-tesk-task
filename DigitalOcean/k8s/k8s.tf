# Deploy the actual Kubernetes cluster
resource "digitalocean_kubernetes_cluster" "kubernetes_cluster" {
  name    = var.name
  region  = var.region
  version = var.version_k8s
  ha      = var.ha
  tags    = [var.tags]

  # This default node pool is mandatory
  node_pool {
    name       = var.node_pool["name"]
    size       = var.node_pool["size"]
    auto_scale = var.node_pool["auto_scale"]
    node_count = var.node_pool["node_count"]
    tags       = [var.tags]
  }

}

# node pool for services
resource "digitalocean_kubernetes_node_pool" "services_node_pool" {
  cluster_id = digitalocean_kubernetes_cluster.kubernetes_cluster.id

  for_each = var.services_node_pool
  name     = each.key
  size     = each.value.size # list available options with `doctl compute size list`
  tags     = [each.value.tags]

  #  autoscaling
  auto_scale = each.value.auto_scale
  min_nodes  = each.value.min_nodes
  max_nodes  = each.value.max_nodes
  labels     = {
    service  = each.value.labels["service"]
    priority = "high"
  }
}
