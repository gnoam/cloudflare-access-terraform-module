variable "domain" {
  type        = string
  description = "The unique subdomain assigned to your Zero Trust organization"
}

variable "domain" {
  type = set(object({
    name             = string
    host             = string
    // Available values: app_launcher, bookmark, biso, dash_sso, saas, self_hosted, ssh, vnc, warp
    type             = string
    session_duration = string
  }))
}

variable "cors" {
  type = set(object({
    allowed_methods   = string
    allowed_origins   = list(string)
    allow_credentials = bool
    max_age           = number
  }))
  default = []
}

variable "account_id" {
  type        = string
  description = "The account identifier to target for the resource"
}

variable "name" {
  type        = string
  description = "The name of your Zero Trust organization"
}

variable "config" {
  type = set(object({
    background_color = string
    text_color       = string
    logo_path        = string
    header_text      = string
    footer_text      = string
  }))
  default = []
}

variable "is_read_only" {
  type        = bool
  description = "When set to true, this will disable all editing of Access resources via the Zero Trust Dashboard"
  default     = false
}