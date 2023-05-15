resource "cloudflare_access_organization" "organization" {
  account_id  = var.account_id
  name        = var.name
  auth_domain = "${var.name}.cloudflareaccess.com"

  is_ui_read_only = var.is_ui_read_only

  #TODO
  login_design {
    background_color = var.organization_login_design.background_color
    text_color       = var.organization_login_design.text_color
    logo_path        = var.organization_login_design.logo_path
    header_text      = var.organization_login_design.header_text
    footer_text      = var.organization_login_design.footer_text
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

  depends_on = [cloudflare_access_organization.organization]
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
      certificate             = lookup(include.value, "certificate", null)
      common_name             = lookup(include.value, "common_name", null)
      device_posture          = lookup(include.value, "device_posture", null)
      email_domain            = lookup(include.value, "email_domain", null)
      everyone                = lookup(include.value, "everyone", null)
      geo                     = lookup(include.value, "geo", null)
      group                   = lookup(include.value, "group", null)
      service_token           = lookup(include.value, "service_token", null)
      ip                      = lookup(include.value, "ip", null)
      ip_list                 = lookup(include.value, "ip_list", null)
      login_method            = lookup(include.value, "login_method", null)

      dynamic "azure" {
        for_each = lookup(include.value, "azure", {})
        content {
          identity_provider_id = azure.value.identity_provider_id
        }
      }

      dynamic "external_evaluation" {
        for_each = lookup(include.value, "external_evaluation", {})
        content {
          evaluate_url = external_evaluation.value.evaluate_url
          keys_url     = external_evaluation.value.keys_url
        }
      }

      dynamic "github" {
        for_each = lookup(include.value, "github", {})
        content {
          identity_provider_id = github.value.identity_provider_id
          name                 = github.value.name
          teams                = github.value.team
        }
      }

      dynamic "gsuite" {
        for_each = lookup(include.value, "gsuite", {})
        content {
          identity_provider_id = gsuite.value.identity_provider_id
          email                = gsuite.value.email
        }
      }

      dynamic "okta" {
        for_each = lookup(include.value, "okta", {})
        content {
          identity_provider_id = okta.value.identity_provider_id
          name                 = okta.value.name
        }
      }

      dynamic "saml" {
        for_each = lookup(include.value, "saml", {})
        content {
          attribute_name       = saml.value.attribute_name
          attribute_value      = saml.value.attribute_value
          identity_provider_id = saml.value.identity_provider_id
        }
      }
    }
  }

  dynamic "require" {
    for_each = var.access_group_require
    content {
      email                   = lookup(require.value, "email", null)
      any_valid_service_token = lookup(require.value, "any_valid_service_token", null)
      auth_method             = lookup(require.value, "auth_method", null)
      certificate             = lookup(require.value, "certificate", null)
      common_name             = lookup(require.value, "common_name", null)
      device_posture          = lookup(require.value, "device_posture", null)
      email_domain            = lookup(require.value, "email_domain", null)
      everyone                = lookup(require.value, "everyone", null)
      geo                     = lookup(require.value, "geo", null)
      group                   = lookup(require.value, "group", null)
      service_token           = lookup(require.value, "service_token", null)
      ip                      = lookup(require.value, "ip", null)
      ip_list                 = lookup(require.value, "ip_list", null)
      login_method            = lookup(require.value, "login_method", null)

      dynamic "azure" {
        for_each = lookup(require.value, "azure", {})
        content {
          identity_provider_id = azure.value.identity_provider_id
        }
      }

      dynamic "external_evaluation" {
        for_each = lookup(require.value, "external_evaluation", {})
        content {
          evaluate_url = external_evaluation.value.evaluate_url
          keys_url     = external_evaluation.value.keys_url
        }
      }

      dynamic "github" {
        for_each = lookup(require.value, "github", {})
        content {
          identity_provider_id = github.value.identity_provider_id
          name                 = github.value.name
          teams                = github.value.team
        }
      }

      dynamic "gsuite" {
        for_each = lookup(require.value, "gsuite", {})
        content {
          identity_provider_id = gsuite.value.identity_provider_id
          email                = gsuite.value.email
        }
      }

      dynamic "okta" {
        for_each = lookup(require.value, "okta", {})
        content {
          identity_provider_id = okta.value.identity_provider_id
          name                 = okta.value.name
        }
      }

      dynamic "saml" {
        for_each = lookup(require.value, "saml", {})
        content {
          attribute_name       = saml.value.attribute_name
          attribute_value      = saml.value.attribute_value
          identity_provider_id = saml.value.identity_provider_id
        }
      }
    }
  }

  dynamic "exclude" {
    for_each = var.access_group_exclude
    content {
      email                   = lookup(exclude.value, "email", null)
      any_valid_service_token = lookup(exclude.value, "any_valid_service_token", null)
      auth_method             = lookup(exclude.value, "auth_method", null)
      certificate             = lookup(exclude.value, "certificate", null)
      common_name             = lookup(exclude.value, "common_name", null)
      device_posture          = lookup(exclude.value, "device_posture", null)
      email_domain            = lookup(exclude.value, "email_domain", null)
      everyone                = lookup(exclude.value, "everyone", null)
      geo                     = lookup(exclude.value, "geo", null)
      group                   = lookup(exclude.value, "group", null)
      service_token           = lookup(exclude.value, "service_token", null)
      ip                      = lookup(exclude.value, "ip", null)
      ip_list                 = lookup(exclude.value, "ip_list", null)
      login_method            = lookup(exclude.value, "login_method", null)

      dynamic "azure" {
        for_each = lookup(exclude.value, "azure", {})
        content {
          identity_provider_id = azure.value.identity_provider_id
        }
      }

      dynamic "external_evaluation" {
        for_each = lookup(exclude.value, "external_evaluation", {})
        content {
          evaluate_url = external_evaluation.value.evaluate_url
          keys_url     = external_evaluation.value.keys_url
        }
      }

      dynamic "github" {
        for_each = lookup(exclude.value, "github", {})
        content {
          identity_provider_id = github.value.identity_provider_id
          name                 = github.value.name
          teams                = github.value.team
        }
      }

      dynamic "gsuite" {
        for_each = lookup(exclude.value, "gsuite", {})
        content {
          identity_provider_id = gsuite.value.identity_provider_id
          email                = gsuite.value.email
        }
      }

      dynamic "okta" {
        for_each = lookup(exclude.value, "okta", {})
        content {
          identity_provider_id = okta.value.identity_provider_id
          name                 = okta.value.name
        }
      }

      dynamic "saml" {
        for_each = lookup(exclude.value, "saml", {})
        content {
          attribute_name       = saml.value.attribute_name
          attribute_value      = saml.value.attribute_value
          identity_provider_id = saml.value.identity_provider_id
        }
      }
    }
  }

  depends_on = [cloudflare_access_organization.organization]
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