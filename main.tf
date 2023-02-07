resource "cloudflare_access_organization" "example" {
  account_id      = var.account_id
  name            = var.name
  auth_domain     = "${var.name}.cloudflareaccess.com"
  is_ui_read_only = false

  login_design {
    background_color = "#ffffff"
    text_color       = "#000000"
    logo_path        = "https://example.com/logo.png"
    header_text      = "My header text"
    footer_text      = "My footer text"
  }
}

resource "cloudflare_access_application" "application" {
  account_id       = var.account_id
  name             = "${var.name} application"
  domain           = var.domain
  type             = var.application_type
  session_duration = var.session_duration

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

resource "cloudflare_access_group" "group" {
  account_id = var.account_id
  name       = "${var.name} group"

  dynamic "include" {
    for_each = var.access_group_include
    content {
      email = lookup(include.value, "email", null)
    }
  }

  #  require = {
  #    ip = [var.office_ip]
  #  }
}

resource "cloudflare_access_policy" "app_policy" {
  application_id = cloudflare_access_application.application.id
  account_id     = var.account_id
  name           = "${var.name} policy"
  precedence     = "1"
  decision       = "allow"

  include {
    group = [cloudflare_access_group.group.id]
  }

  #  require {
  #    email = ["test@example.com"]
  #  }
  depends_on = [cloudflare_access_group.group, cloudflare_access_application.application]
}