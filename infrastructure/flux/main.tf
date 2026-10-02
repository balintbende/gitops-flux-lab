terraform {
  required_version = "1.16.1"

  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = "1.9.5"
    }
  }
}
