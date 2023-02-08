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
      email                   = lookup(include.value, "email", null)
      any_valid_service_token = lookup(include.value, "any_valid_service_token", null)
      auth_method             = lookup(include.value, "auth_method", null)
      azure                   = lookup(include.value, "azure", null)
      certificate             = lookup(include.value, "certificate", null)
      common_name             = lookup(include.value, "common_name", null)
      device_posture          = lookup(include.value, "device_posture", null)
      email_domain            = lookup(include.value, "email_domain", null)
      everyone                = lookup(include.value, "everyone", null)
      external_evaluation     = lookup(include.value, "external_evaluation", null)
      geo                     = lookup(include.value, "geo", null)
      github                  = lookup(include.value, "github", null)
      group                   = lookup(include.value, "group", null)
      gsuite                  = lookup(include.value, "gsuite", null)
      ip                      = lookup(include.value, "ip", null)
      ip_list                 = lookup(include.value, "ip_list", null)
      login_method            = lookup(include.value, "login_method", null)
      okta                    = lookup(include.value, "okta", null)
      saml                    = lookup(include.value, "saml", null)
      service_token           = lookup(include.value, "service_token", null)
    }
  }

  dynamic "require" {
    for_each = var.access_group_require
    content {
      email                   = lookup(require.value, "email", null)
      any_valid_service_token = lookup(require.value, "any_valid_service_token", null)
      auth_method             = lookup(require.value, "auth_method", null)
      azure                   = lookup(require.value, "azure", null)
      certificate             = lookup(require.value, "certificate", null)
      common_name             = lookup(require.value, "common_name", null)
      device_posture          = lookup(require.value, "device_posture", null)
      email_domain            = lookup(require.value, "email_domain", null)
      everyone                = lookup(require.value, "everyone", null)
      external_evaluation     = lookup(require.value, "external_evaluation", null)
      geo                     = lookup(require.value, "geo", null)
      github                  = lookup(require.value, "github", null)
      group                   = lookup(require.value, "group", null)
      gsuite                  = lookup(require.value, "gsuite", null)
      ip                      = lookup(require.value, "ip", null)
      ip_list                 = lookup(require.value, "ip_list", null)
      login_method            = lookup(require.value, "login_method", null)
      okta                    = lookup(require.value, "okta", null)
      saml                    = lookup(require.value, "saml", null)
      service_token           = lookup(require.value, "service_token", null)
    }
  }

  dynamic "exclude" {
    for_each = var.access_group_exclude
    content {
      email                   = lookup(exclude.value, "email", null)
      any_valid_service_token = lookup(exclude.value, "any_valid_service_token", null)
      auth_method             = lookup(exclude.value, "auth_method", null)
      azure                   = lookup(exclude.value, "azure", null)
      certificate             = lookup(exclude.value, "certificate", null)
      common_name             = lookup(exclude.value, "common_name", null)
      device_posture          = lookup(exclude.value, "device_posture", null)
      email_domain            = lookup(exclude.value, "email_domain", null)
      everyone                = lookup(exclude.value, "everyone", null)
      external_evaluation     = lookup(exclude.value, "external_evaluation", null)
      geo                     = lookup(exclude.value, "geo", null)
      github                  = lookup(exclude.value, "github", null)
      group                   = lookup(exclude.value, "group", null)
      gsuite                  = lookup(exclude.value, "gsuite", null)
      ip                      = lookup(exclude.value, "ip", null)
      ip_list                 = lookup(exclude.value, "ip_list", null)
      login_method            = lookup(exclude.value, "login_method", null)
      okta                    = lookup(exclude.value, "okta", null)
      saml                    = lookup(exclude.value, "saml", null)
      service_token           = lookup(exclude.value, "service_token", null)
    }
  }
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

  depends_on = [cloudflare_access_group.group, cloudflare_access_application.application]
}