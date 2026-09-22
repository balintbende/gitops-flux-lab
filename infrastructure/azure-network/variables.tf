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

variable "azure_vn_address_space" {
  description = "The address space that is used the virtual network."
  type        = string
  default     = "10.0.0.0/16"
}

variable "azure_vn_subnet_prefix" {
  description = "The address prefix to use for the subnet."
  type        = string
  default     = "10.0.0.0/16"
}