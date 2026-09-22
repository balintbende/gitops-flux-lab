# bimlens-terraform

The Terraform modules enable a cluster-as-a-service solution for the 
**bimlens** project.

## Stack

- Terraform 1.15
- Azure (AKS, VNet, Resource Group)
- Terraform Cloud (remote state, workspace: `bimlens-dev`)

## Prerequisites

- [Terraform CLI](https://developer.hashicorp.com/terraform/install) >= 1.15
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) — authenticated via `az login`
- A [Terraform Cloud](https://app.terraform.io) account in the `bimlens` organisation

## Remote backend

[Terraform Cloud][1] is configured as the backend. Its being an enhanced remote
means that `plan`, `apply` and `destroy` commands are run on the cloud and
**not** locally.

For all local testing the commands in the `makefile` should be used.

## Authentication

### Terraform Cloud

Export it as an environment variable:

```bash
export TF_TOKEN_app_terraform_io=<your-token>
```

Persist it in your shell:

```bash
echo 'export TF_TOKEN_app_terraform_io=<your-token>' >> ~/.zshrc
```

### Azure

```bash
az login
az account set --subscription <subscription-id>
```

## Usage

```bash
# Initialise workspace
make init-dev

# Plan
make plan-dev

# Apply
make apply-dev

# Destroy (stop Azure charges)
make destroy-dev
```

## Separation of environments

All environments are defined as terraform workspaces. 
See the output of the command `terraform workspace list`.

Naming convention: `bm-{application}-{environment}`. Example: `bm-bimlens-dev`

All modules are shared and distinct `tfvar` files are created for all 
environments.

**Important note:** When creating a new environment, the hosted zone in 
Azure DNS  must be manually created in advance, and its ID is to be added to
the `tfvars` file.

[1]: https://app.terraform.io/app/bimlens/workspaces