terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "3.1.1"
    }
  }
}

module "gateway" {
  source = "./gateway"
}

module "monitoring" {
  source      = "./monitoring"
  environment = var.environment
}