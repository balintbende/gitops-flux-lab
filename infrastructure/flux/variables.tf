variable "product" {
  description = "The name of the product"
  type        = string
  default     = "bimlens"
}

variable "environment" {
  description = "The name of the environment, e.g. dev, staging or prod"
  type        = string
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

variable "kube_config" {
  description = "AKS kube_config object (from the kubernetes module) used to configure the flux provider"
  type        = any
  sensitive   = true
}

variable "ghcr_token" {
  description = "GitHub classic PAT with read:packages scope"
  type        = string
  sensitive   = true
}