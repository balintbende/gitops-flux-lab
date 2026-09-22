# Install Flux into the cluster and commit the bootstrap manifests to git
# under clusters/<environment>. Flux then reconciles everything in that path.
# Git auth uses the GitHub PAT over HTTPS.
resource "flux_bootstrap_git" "flux" {
  path                 = "clusters/${var.environment}"
  delete_git_manifests = false

  # The core 4 controllers are installed by default. Image automation
  # (ImageRepository / ImagePolicy / ImageUpdateAutomation) needs these two extras.
  components_extra = [
    "image-reflector-controller",
    "image-automation-controller",
  ]
}
