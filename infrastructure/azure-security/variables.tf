variable "product" {
  description = "The name of the product"
  type        = string
  default     = "bimlens"
}

variable "environment" {
  description = "The name of the environment, e.g. dev, staging or prod"
  type        = string
}

variable "azure_region" {
  description = "This is the cloud hosting region where the cluster will be deployed."
  type        = string
}

variable "azure_resource_group_name" {
  description = "The name of the resource group in which to create the virtual network."
  type        = string
}

variable "kubernetes_namespace_name" {
  description = "The name of the Kubernetes namespace the api service account lives in."
  type        = string
}

variable "kubernetes_oidc_issuer_url" {
  description = "The OIDC issuer url of the AKS cluster, used to federate the api workload identity."
  type        = string
}

variable "azure_storage_account_id" {
  description = "The id of the storage account the api gets blob data access to."
  type        = string
}

variable "azure_virtual_network_subnet_id" {
  description = "The id of the subnet the AKS cluster runs in. The cluster identity gets Network Contributor on it."
  type        = string
}
