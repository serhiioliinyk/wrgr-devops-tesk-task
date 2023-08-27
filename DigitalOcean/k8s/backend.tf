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
  # These variables need to be set for access to a bucket(in DO it is named spaces). In this bucket(spaces) we save tfstate file. This secret is general for the project

}