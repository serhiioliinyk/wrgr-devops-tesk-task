<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | ~> 2.25.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | ~> 2.25.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [digitalocean_kubernetes_cluster.kubernetes_cluster](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster) | resource |
| [digitalocean_kubernetes_node_pool.services_node_pool](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_node_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ha"></a> [ha](#input\_ha) | High availability control plane for a cluster | `bool` | `"true"` | no |
| <a name="input_name"></a> [name](#input\_name) | Cluster k8s name | `string` | `""` | no |
| <a name="input_node_pool"></a> [node\_pool](#input\_node\_pool) | k8s node pool configuration | `map(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Digitalocean region | `string` | n/a | yes |
| <a name="input_services_node_pool"></a> [services\_node\_pool](#input\_services\_node\_pool) | Services noode pool variables | <pre>map(object({<br>    size       = string<br>    auto_scale = string<br>    min_nodes  = string<br>    max_nodes  = string<br>    tags       = string<br>    labels     = map(string)<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for all resources | `string` | n/a | yes |
| <a name="input_version_k8s"></a> [version\_k8s](#input\_version\_k8s) | Cluster k8s version | `string` | `"1.25.4-do.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_edpoint"></a> [cluster\_edpoint](#output\_cluster\_edpoint) | n/a |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | n/a |
<!-- END_TF_DOCS -->