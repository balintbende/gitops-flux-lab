provider "flux" {
  kubernetes = {
    host                   = var.kube_config.host
    client_certificate     = base64decode(var.kube_config.client_certificate)
    client_key             = base64decode(var.kube_config.client_key)
    cluster_ca_certificate = base64decode(var.kube_config.cluster_ca_certificate)
  }
  git = {
    url = "https://github.com/${var.github_owner}/${var.github_repository}.git"
    http = {
      username = "git"
      password = var.github_token
    }
  }
}