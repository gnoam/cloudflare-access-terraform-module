output "organization_id" {
  description = "The ID of the organization."
  value       = cloudflare_access_organization.organization.id
}

output "application_id" {
  description = "The ID of the application."
  value       = cloudflare_access_application.application.id
}

output "application_url" {
  description = "The URL of the application."
  value       = cloudflare_access_application.application.domain
}

output "group_id" {
  description = "The ID of the group."
  value       = cloudflare_access_group.group.id
}