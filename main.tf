resource "cloudflare_access_application" "application" {
  for_each         = {for k, v in var.domain : v.name => k}
  account_id       = var.account_id
  name             = each.value.name
  domain           = each.value.host
  type             = each.value.type
  session_duration = each.value.session_duration

  dynamic "cors_headers" {
    for_each = var.cors
    content {
      allowed_methods   = cors_headers.value.allowed_methods
      allowed_origins   = cors_headers.value.allowed_origins
      allow_credentials = cors_headers.value.allow_credentials
      max_age           = cors_headers.value.max_age
    }
  }
}

resource "cloudflare_access_group" "test_group" {
  account_id = "f037e56e89293a057740de681ac9abbe"
  name       = "staging group"

  include {
    email = ["test@example.com"]
  }

  require = {
    ip = [var.office_ip]
  }
}

resource "cloudflare_access_policy" "test_policy" {
  application_id = cloudflare_access_application.app.application_id
  zone_id        = var.zone_id
  name           = "${name} policy"
  precedence     = "1"
  decision       = "allow"

  include {
    email = ["test@example.com"]
  }

  require {
    email = ["test@example.com"]
  }
}

resource "cloudflare_access_identity_provider" "jumpcloud_saml" {
  account_id = "f037e56e89293a057740de681ac9abbe"
  name       = "JumpCloud SAML"
  type       = "saml"
  config {
    issuer_url      = "jumpcloud"
    sso_target_url  = "https://sso.myexample.jumpcloud.com/saml2/cloudflareaccess"
    attributes      = ["email", "username"]
    sign_request    = false
    idp_public_cert = "MIIDpDCCAoygAwIBAgIGAV2ka+55MA0GCSqGSIb3DQEBCwUAMIGSMQswCQ...GF/Q2/MHadws97cZg\nuTnQyuOqPuHbnN83d/2l1NSYKCbHt24o"
  }
}

resource "cloudflare_access_organization" "example" {
  account_id      = var.account_id
  name            = var.name
  auth_domain     = var.domain
  is_ui_read_only = var.is_ui_read_only
  user_seat_expiration_inactive_time = var.user_seat_expiration_inactive_time

  dynamic login_design {
    for_each = var.config
    content {
      background_color = 
      text_color       = "#000000"
      logo_path        = "https://example.com/logo.png"
      header_text      = "My header text"
      footer_text      = "My footer text"
    }
  }
}