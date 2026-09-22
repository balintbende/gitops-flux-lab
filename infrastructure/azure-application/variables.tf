variable "product" {
  description = "The name of the product"
  type        = string
  default     = "bimlens"
}

variable "environment" {
  description = "The name of the environment, e.g. dev, staging or prod"
  type        = string
}