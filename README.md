<!-- BEGIN_TF_DOCS -->
# WRGR DEVOPS TEST TASK

## Task Description

You are tasked with setting up an infrastructure environment on Amazon Web Services (AWS) or DigitalOcean (DO) using Terraform. The goal is to create a cluster and deploy several services commonly used in the organization's stack. You will also demonstrate the process of manifest deployment, resource addition, and configuration.

## Task Check List

- [x] Create an DO infrastructure using Terraform to set up a cluster.
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
- a [repository](https://github.com/serhiioliinyk/wrgr-devops-tesk-task) that stores the configuration for deploying a Kubernetes cluster and ArgoCD tool, written with the Hashicorp Configuration Language (HCL);
- a [repository](https://github.com/serhiioliinyk/tf-argocd-infrastructure) that stores configuration files for deploying PostgreSQL, Kafka, Zookeeper, HashiCorp Vault, Nginx using the previously deployed ArgoCD.

### Kubernetes cluster
This infrastructure approach demonstrates the using of tfvars as a variable entry point. The module itself can be used for different environments by simply adding a custom file with variables.
In this implementation, the resources do not have a hardcode, the values for variables are obtained from tfwars.
This approach is quite convenient when deploying infrastructure for small projects.
### ArgoCD
The entry point for installing services is ArgoCD. ArgoCD is installed using the Helm Provider. Further, the deployed ArgoCD deploys all other services using the written configuration files. A repository with written configuration files for deploying PostgreSQL, Kafka, Zookeeper, HashiCorp Vault, Nginx.

## How to Deploy

### Setup Terraform Backend

#### Prerequisites
- Create a `Space` via the DigitalOcean console or CLI. [How to create](https://docs.digitalocean.com/products/spaces/how-to/create/).
- A Spaces `Access Key` and `Secret`. You can generate them [here](https://cloud.digitalocean.com/account/api/spaces).
- The [`aws cli`](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) installed.

#### Setup

##### _Create your Spaces and define backend.tf_

The required keys are `endpoint`, `key`, and `bucket`.

- `endpoint`: Available in the Settings of your `Space`.
- `key`: path and name of `.tfstate` file that will be written
- `bucket`: the name of your `Space`

After you have created spaces, define its parameters in backend.tf. Specify the endpoint, region, path for the `.tfstate file`, and bucket name. Below is an example code listing for the backend.

```hcl
terraform {
  backend "s3" {
    endpoint = "nyc3.digitaloceanspaces.com" # specify the correct DO region
    region   = "nyc3"                    # not used since it's a DigitalOcean spaces bucket
    key      = "DigitalOcean/k8s/.terraform/terraform.tfstate"
    bucket   = "s3terraform-bucket2" # The name of your Spaces

    skip_region_validation = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style = true
  }
}
```
##### _Define S3 Credentials_

Terraform uses the standard `.aws/credentials` file to authenticate to the `S3` backend. This is created by the `aws cli`.

We can use [named profiles](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html) to create one to access DigitalOcean Spaces.

```bash
aws configure --profile digitalocean
```

You can tell the `aws cli` (and the `terraform` command by extension) which profile to use by setting the `AWS_PROFILE` environment variable.

```bash
export AWS_PROFILE=digitalocean
```

Verify it's set:

```
echo $AWS_PROFILE
```

##### _Initialize Backend_

Once your named profile is configured and your shell knows which profile to use, Terraform can initialize. Jump to directory with backend.tf file with `cd` and run:

```bash
terraform init
```

If all goes well you should see:

```bash
Terraform has been successfully initialized!
```
### Deploy K8S Cluster with ArgoCD

Jump to directory with `*.tf` configuration files after backend initialization. Run:

```bash
terraform plan
```

Make sure the configuration is correct and run:

```bash
terraform apply 
```

## Resources Description
[Here](DigitalOcean/k8s/README.md) is resources description sheet.
<!-- END_TF_DOCS -->
