terraform {
  required_version = "1.16.1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.73.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "3.1.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.1.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "3.1.1"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "bimlens"

    workspaces {
      prefix = "bimlens-"
    }
  }
}

resource "azurerm_resource_group" "resource-group" {
  name     = "rg.${var.product}.${var.environment}"
  location = var.azure_region
}

module "network" {
  source                    = "./azure-network"
  product                   = var.product
  environment               = var.environment
  azure_region              = var.azure_region
  azure_resource_group_name = azurerm_resource_group.resource-group.name
}

module "kubernetes" {
  source                          = "./azure-kubernetes"
  product                         = var.product
  environment                     = var.environment
  azure_client_id                 = var.azure_client_id
  azure_client_secret             = var.azure_client_secret
  azure_region                    = var.azure_region
  azure_tenant_id                 = var.azure_tenant_id
  azure_subscription_id           = var.azure_subscription_id
  azure_resource_group_name       = azurerm_resource_group.resource-group.name
  aks_node_pool_default           = var.aks_node_pool_default
  azure_virtual_network_subnet_id = module.network.azure_virtual_network_subnet_id
}

resource "kubernetes_namespace_v1" "namespace" {
  metadata {
    name = var.environment
  }
}

module "flux" {
  source       = "./flux"
  product      = var.product
  environment  = var.environment
  github_owner = var.github_owner
  # github_token      = var.github_token
  github_repository          = var.github_repository
  kube_config                = module.kubernetes.kube_config
  ghcr_token                 = var.ghcr_token
  github_app_id              = var.github_app_id
  github_app_installation_id = var.github_app_installation_id
  github_app_private_key     = var.github_app_private_key
}

module "application" {
  source      = "./azure-application"
  product     = var.product
  environment = var.environment
}