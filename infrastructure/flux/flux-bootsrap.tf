# Install Flux into the cluster and commit the bootstrap manifests to git
# under clusters/<environment>. Flux then reconciles everything in that path.
# Git auth uses the GitHub SSH.
resource "flux_bootstrap_git" "flux" {
  depends_on = [github_repository_deploy_key.flux]

  path                 = "clusters/${var.environment}"
  delete_git_manifests = false

  # The core 4 controllers are installed by default. Image automation
  # (ImageRepository / ImagePolicy / ImageUpdateAutomation) needs these two extras.
  components_extra = [
    "image-reflector-controller",
    "image-automation-controller",
  ]
}
