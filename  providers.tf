terraform {
  required_version = "~> 1.3.0"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.0.0-rc1"
      #      version = "~> 3.1"
    }
  }
}

provider "cloudflare" {
  api_token = var.api_token
}