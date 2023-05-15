variable "api_token" {
  description = "The API Token for operations. Alternatively, can be configured using the CLOUDFLARE_API_TOKEN environment variable"
  type        = string
  default     = null
}

variable "account_id" {
  description = "The account identifier to target for the resource"
  type        = string
}

variable "name" {
  description = "Friendly name for the created resources"
  type        = string
}

variable "domain" {
  description = "The complete URL of the asset you wish to put Cloudflare Access in front of. Can include subdomains or paths. Or both."
  type        = string
}

variable "application_type" {
  description = "The application type. Available values: app_launcher, bookmark, biso, dash_sso, saas, self_hosted, ssh, vnc, warp"
  type        = string
  default     = "self_hosted"

  validation {
    condition = contains([
      "app_launcher", "bookmark", "biso", "dash_sso", "saas", "self_hosted", "ssh", "vnc", "warp"
    ], var.application_type)
    error_message = "The application type must be one of app_launcher, bookmark, biso, dash_sso, saas, self_hosted, ssh, vnc, warp"
  }
}

variable "cors" {
  description = "A list of CORS configuration objects. Each object should contain the following keys: allowed_methods, allowed_origins, allow_credentials, max_age."
  type = set(object({
    allowed_methods   = string
    allowed_origins   = list(string)
    allow_credentials = bool
    max_age           = number
  }))
  default = []
}

variable "session_duration" {
  description = "How often a user will be forced to re-authorise. Must be in the format 48h or 2h45m"
  type        = string
  default     = "24h"
}

#variable "saas_app" {
#  description = "SaaS configuration for the Access Application. Required when application_type is set to saas"
#  type = set(object({
#    consumer_service_url = string
#    sp_entity_id         = string
#    name_id_format       = string
#  }))
#  default = []
#}

#variable "config" {
#  description = "app config"
#  type = set(object({
#    background_color = string
#    text_color       = string
#    logo_path        = string
#    header_text      = string
#    footer_text      = string
#  }))
#  default = []
#}
#
variable "is_ui_read_only" {
  type        = bool
  description = "When set to true, this will disable all editing of Access resources via the Zero Trust Dashboard"
  default     = false
}

variable "access_group_include" {
  description = "A series of access conditions"
  type        = list(any)
  default = [
    { email = ["temp@gmail.com"]
      ip    = ["0.0.0.0/0"]

    }
  ]
}

variable "access_group_require" {
  description = "A series of access conditions to require"
  type        = list(any)
  default     = [{}]
}

variable "access_group_exclude" {
  description = "A series of access conditions to exclude"
  type        = list(any)
  default     = [{}]
}

variable "organization_login_design" {
  description = "A design configuration for the organization access page"
  type = object({
    background_color = string
    text_color       = string
    logo_path        = string
    header_text      = string
    footer_text      = string
  })

  default = {
    background_color = "#000000"
    text_color       = "#ffffff"
    logo_path        = ""
    header_text      = ""
    footer_text      = ""
  }
}