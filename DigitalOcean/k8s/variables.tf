variable "do_token" {
  type = string
  description = "DO Access token"
}
# Cluster variables
variable "name" {
  type        = string
  default     = ""
  description = "Cluster k8s name"
}

variable "version_k8s" {
  type        = string
  default     = "1.25.4-do.0"
  description = "Cluster k8s version"
}

variable "ha" {
  type        = bool
  default     = "true"
  description = "High availability control plane for a cluster"
}

variable "enabled_argocd" {
  type        = bool
  default     = "true"
  description = "Enable argocd?"
}

variable "tags" {
  type        = string
  default     = ""
  description = "Tags for all resources"
}

variable "region" {
  type        = string
  default     = ""
  description = "Digitalocean region"
}

variable "node_pool" {
  type        = map(string)
  default     = {}
  description = "k8s node pool configuration"
}

# Services node pool variables
variable "services_node_pool" {
  type = map(object({
    size       = string
    auto_scale = string
    min_nodes  = string
    max_nodes  = string
    tags       = string
    labels     = map(string)
  }))
  default     = {}
  description = "Services noode pool variables"
}

variable "helm_release_history_size" {
  description = "How much helm releases to store"
  default     = 5
}

variable "argocd_repo_url" {
  type        = string
  default     = ""
  description = "url for github repo with applications helm charts"
}

variable "argocd_domain_name" {
  type        = string
  default     = ""
  description = "domain for argocd to use"
}

variable "ca_api_key" {
  type        = string
  default     = ""
  description = "api key to communicate with cloudflare"
}

variable "github_username" {
  type        = string
  default     = ""
  sensitive   = true
  description = "username to access github repo with charts"
}

variable "github_password" {
  type        = string
  default     = ""
  sensitive   = true
  description = "password to access github repo with charts"
}

variable "registry_server" {
  default     = "https://registry-1.docker.io"
  type        = string
  description = "url of docker registry to login"
}

variable "registry_username" {
  type        = string
  sensitive   = true
  default     = ""
  description = "username of docker registry account"
}

variable "registry_password" {
  type        = string
  sensitive   = true
  default     = ""
  description = "password of docker registry account"
}

variable "registry_email" {
  type        = string
  default     = ""
  description = "email of docker registry account"
}

variable "env" {
  type        = string
  default     = ""
  description = "environment"
}

variable "docker_creds_secret_name" {
  type        = string
  default     = ""
  description = "name for the secret that contains docker"
}

variable "argocd_namespace" {
  type        = string
  default     = ""
  description = "name for the namespace created for argocd"
}

variable "github_clientID" {
  type        = string
  default     = ""
  description = "github clientID value for oauth2"
}

variable "github_clientSecret" {
  type        = string
  sensitive   = true
  default     = ""
  description = "github clientSecret value for oauth2"
}

variable "admin_github_team_name" {
  type        = string
  default     = ""
  description = "name of github team with admin role"
}

variable "readonly_github_team_name" {
  type        = string
  default     = ""
  description = "name of github team with readonly role"
}

variable "readwrite_github_team_name" {
  type        = string
  default     = ""
  description = "name of github team with readwrite role"
}

variable "github_org_name" {
  type        = string
  default     = ""
  description = "name of github organisation"
}

variable "avp_version" {
  type        = string
  default     = ""
  description = "Version argocd vault plugin"
}

variable "avp_argo_version" {
  type        = string
  default     = ""
  description = "Version argocd for sidecar container"
}

variable "avp_credentials_name" {
  type        = string
  default     = ""
  description = "Credentials for connect in vault"
}

variable "vault_address" {
  type        = string
  default     = ""
  description = "Address vault"
}

variable "avp_configmap_name" {
  type        = string
  default     = ""
  description = "Config for argocd vault plugin"
}

variable "avp_role_id" {
  type        = string
  default     = ""
  description = "Role id from vault"
}

variable "avp_secret_id" {
  type        = string
  default     = ""
  description = "Secret id from vault"
}