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
    - [x] Redis
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

[//]: # (## How to Deploy)

[//]: # (###)

## Resources Description
[Here](DigitalOcean/k8s/README.md) is resources description sheet.
<!-- END_TF_DOCS -->
