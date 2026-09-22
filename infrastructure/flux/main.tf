terraform {
  required_version = "1.15.6"

  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = "1.8.8"
    }
  }
}
