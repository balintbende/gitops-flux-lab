variable "product" {
  description = "The name of the product"
  type        = string
  default     = "bimlens"
}

variable "environment" {
  description = "The name of the environment, e.g. dev, staging or prod"
  type        = string
}

variable "azure_subscription_id" {
  description = "The azure subscription id"
  type        = string
  sensitive   = true
}

variable "azure_client_id" {
  description = "The azure client id"
  type        = string
  sensitive   = true
}

variable "azure_client_secret" {
  description = "The azure client secret/password"
  type        = string
  sensitive   = true
}

variable "azure_tenant_id" {
  description = "The azure tenant id"
  type        = string
  sensitive   = true
}

variable "azure_region" {
  description = "The dns_zones to be managed for this environment."
  type        = string
}

variable "aks_node_pool_default" {
  description = "The default node group to be added to the AKS"
  type = object({
    vm_size   = string
    min_count = number
    max_count = number
  })
}

variable "aks_node_pool_high" {
  description = "The high node group to be added to the AKS"
  type = object({
    vm_size   = string
    min_count = number
    max_count = number
  })
}

variable "github_owner" {
  description = "The GitHub owner/org that holds the Flux GitOps repository"
  type        = string
}

variable "github_repository" {
  description = "The GitHub repository name (without owner) that Flux reconciles from"
  type        = string
}

variable "github_token" {
  description = "GitHub PAT used to register the Flux deploy key and commit bootstrap manifests"
  type        = string
  sensitive   = true
}

variable "ghcr_token" {
  description = "GitHub classic PAT with read:packages scope (used when ghcr_credentials_enabled = true)"
  type        = string
  sensitive   = true
  default     = ""
}
