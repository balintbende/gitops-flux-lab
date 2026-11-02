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
  description = "This is the cloud hosting region where the storage account will be deployed."
  type        = string
}

variable "azure_resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
  type        = string
}