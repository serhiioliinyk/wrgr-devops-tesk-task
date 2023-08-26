# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    endpoint = "nyc3.digitaloceanspaces.com/" # specify the correct DO region
    region   = "us-west-1"                    # not used since it's a DigitalOcean spaces bucket
    key      = "do/k8s/terraform.tfstate"
    bucket   = "s3terraform-bucket" # The name of your Spaces

    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}
