# GHCR pull/scan credentials
locals {
  ghcr_dockerconfigjson = jsonencode({
    auths = {
      "ghcr.io" = {
        username = var.github_owner
        password = var.ghcr_token
        auth     = base64encode("${var.github_owner}:${var.ghcr_token}")
      }
    }
  })
}

# Used by Flux's image-reflector-controller to scan private GHCR for new tags.
resource "kubernetes_secret_v1" "ghcr_flux_system_config" {
  metadata {
    name      = "ghcr-credentials"
    namespace = "flux-system"
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = local.ghcr_dockerconfigjson
  }

  # flux-system namespace is created by the flux bootstrap.
  depends_on = [flux_bootstrap_git.flux]
}

# Used by the kubelet to pull private GHCR images into the application namespace.
resource "kubernetes_secret_v1" "ghcr_app_config" {
  metadata {
    name      = "ghcr-credentials"
    namespace = var.environment
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = local.ghcr_dockerconfigjson
  }
}
