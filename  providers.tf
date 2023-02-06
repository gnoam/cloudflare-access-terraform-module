terraform {
  required_version = ">= 1.0.7"
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "3.33.1"
    }
    awscc = {
      source  = "hashicorp/awscc"
      version = ">= 0.24.0"
    }
  }
}
