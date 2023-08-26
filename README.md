<!-- BEGIN_TF_DOCS -->
# WRGR DEVOPS TEST TASK

## Task Description

You are tasked with setting up an infrastructure environment on Amazon Web Services (AWS) or DigitalOcean (DO) using Terraform. The goal is to create a cluster and deploy several services commonly used in the organization's stack. You will also demonstrate the process of manifest deployment, resource addition, and configuration.

## Task Check List

- [x] Create an AWS infrastructure using Terraform to set up a cluster.
- [x] Deploy the following services onto the cluster:
    - [x] PostgreSQL
    - [x] Kafka
    - [x] Zookeeper
    - [x] HashiCorp Vault
    - [ ] Redis
    - [x] Nginx
    - [x] ArgoCD
- [x] Define the infrastructure setup in Terraform, including the required resources, security groups, networking, etc.
- [x] Use Terraform's state management to keep track of the deployed resources.
- [x] Create a manifest or configuration files for each service that capture the necessary settings and configurations.
- [x] Provide clear documentation or comments explaining the purpose and functionality of each component in the Terraform code.
- [x] Demonstrate an understanding of Terraform best practices and module usage where applicable.

## Implementation Notes
This test task consists of two repositories:
- a [repository](https://github.com/serhiioliinyk/wrgr-devops-tesk-task) that stores the configuration for deploying a Kubernetes cluster in the Hashicorp Configuration Language language;
- a [repository](https://github.com/serhiioliinyk/tf-argocd-infrastructure) that stores configuration files for deploying PostgreSQL, Kafka, Zookeeper, HashiCorp Vault, Nginx using the previously deployed ArgoCD.

### Kubernetes cluster
This infrastructure approach demonstrates the using of tfvars as a variable entry point. The module itself can be used for different environments by simply adding a custom file with variables.
In this implementation, the resources do not have a hardcode, the values for variables are obtained from tfwars.
This approach is quite convenient when deploying infrastructure for small projects.
### ArgoCD
The entry point for installing services is ArgoCD. ArgoCD is installed using the Helm Provider. Further, the deployed ArgoCD deploys all other services using the written configuration files. A repository with written configuration files for deploying PostgreSQL, Kafka, Zookeeper, HashiCorp Vault, Nginx.

## Resources Description
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | ~> 2.25.2 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | ~> 2.25.2 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [digitalocean_kubernetes_cluster.kubernetes_cluster](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster) | resource |
| [digitalocean_kubernetes_node_pool.services_node_pool](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_node_pool) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ha"></a> [ha](#input\_ha) | High availability control plane for a cluster | `bool` | `"true"` | no |
| <a name="input_name"></a> [name](#input\_name) | Cluster k8s name | `string` | `""` | no |
| <a name="input_node_pool"></a> [node\_pool](#input\_node\_pool) | k8s node pool configuration | `map(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Digitalocean region | `string` | n/a | yes |
| <a name="input_services_node_pool"></a> [services\_node\_pool](#input\_services\_node\_pool) | Services noode pool variables | <pre>map(object({<br>    size       = string<br>    auto_scale = string<br>    min_nodes  = string<br>    max_nodes  = string<br>    tags       = string<br>    labels     = map(string)<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for all resources | `string` | n/a | yes |
| <a name="input_version_k8s"></a> [version\_k8s](#input\_version\_k8s) | Cluster k8s version | `string` | `"1.25.4-do.0"` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_edpoint"></a> [cluster\_edpoint](#output\_cluster\_edpoint) | n/a |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | n/a |
<!-- END_TF_DOCS -->
