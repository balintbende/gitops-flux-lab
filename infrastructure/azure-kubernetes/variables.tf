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
  description = "This is the cloud hosting region where the cluster will be deployed."
  type        = string
}

variable "azure_resource_group_name" {
  description = "The name of the resource group in which to create the virtual network."
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

# High node pool variable — demonstration only, not provisioned.
# Used by the commented-out locals block in node-pool.tf.
variable "aks_node_pool_high" {
  description = "The high node group to be added to the AKS"
  type = object({
    vm_size   = string
    min_count = number
    max_count = number
  })
  default = null
}

variable "azure_virtual_network_subnet_id" {
  description = "The id of the subnet in the virtual network. Currently only a single subnet."
  type        = string
}

