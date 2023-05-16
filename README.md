# Cloudflare Access Terraform Module 

TODO: fill this up

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.4.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | 4.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | 4.5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_access_application.application](https://registry.terraform.io/providers/cloudflare/cloudflare/4.5.0/docs/resources/access_application) | resource |
| [cloudflare_access_group.group](https://registry.terraform.io/providers/cloudflare/cloudflare/4.5.0/docs/resources/access_group) | resource |
| [cloudflare_access_organization.organization](https://registry.terraform.io/providers/cloudflare/cloudflare/4.5.0/docs/resources/access_organization) | resource |
| [cloudflare_access_policy.app_policy](https://registry.terraform.io/providers/cloudflare/cloudflare/4.5.0/docs/resources/access_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_group_exclude"></a> [access\_group\_exclude](#input\_access\_group\_exclude) | A series of access conditions to exclude | `list(any)` | <pre>[<br>  {}<br>]</pre> | no |
| <a name="input_access_group_include"></a> [access\_group\_include](#input\_access\_group\_include) | A series of access conditions | `list(any)` | <pre>[<br>  {<br>    "email": [<br>      "temp@gmail.com"<br>    ],<br>    "ip": [<br>      "0.0.0.0/0"<br>    ]<br>  }<br>]</pre> | no |
| <a name="input_access_group_require"></a> [access\_group\_require](#input\_access\_group\_require) | A series of access conditions to require | `list(any)` | <pre>[<br>  {}<br>]</pre> | no |
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The account identifier to target for the resource | `string` | n/a | yes |
| <a name="input_api_token"></a> [api\_token](#input\_api\_token) | The API Token for operations. Alternatively, can be configured using the CLOUDFLARE\_API\_TOKEN environment variable | `string` | `null` | no |
| <a name="input_application_type"></a> [application\_type](#input\_application\_type) | The application type. Available values: app\_launcher, bookmark, biso, dash\_sso, saas, self\_hosted, ssh, vnc, warp | `string` | `"self_hosted"` | no |
| <a name="input_cors"></a> [cors](#input\_cors) | A list of CORS configuration objects. Each object should contain the following keys: allowed\_methods, allowed\_origins, allow\_credentials, max\_age. | <pre>set(object({<br>    allowed_methods   = string<br>    allowed_origins   = list(string)<br>    allow_credentials = bool<br>    max_age           = number<br>  }))</pre> | `[]` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | The complete URL of the asset you wish to put Cloudflare Access in front of. Can include subdomains or paths. Or both. | `string` | n/a | yes |
| <a name="input_is_ui_read_only"></a> [is\_ui\_read\_only](#input\_is\_ui\_read\_only) | When set to true, this will disable all editing of Access resources via the Zero Trust Dashboard | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Friendly name for the created resources | `string` | n/a | yes |
| <a name="input_organization_login_design"></a> [organization\_login\_design](#input\_organization\_login\_design) | A design configuration for the organization access page | <pre>object({<br>    background_color = string<br>    text_color       = string<br>    logo_path        = string<br>    header_text      = string<br>    footer_text      = string<br>  })</pre> | <pre>{<br>  "background_color": "#000000",<br>  "footer_text": "Sample Footer Text",<br>  "header_text": "Sample Header Text",<br>  "logo_path": "https://www.example.com/logo.png",<br>  "text_color": "#ffffff"<br>}</pre> | no |
| <a name="input_session_duration"></a> [session\_duration](#input\_session\_duration) | How often a user will be forced to re-authorise. Must be in the format 48h or 2h45m | `string` | `"24h"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_id"></a> [application\_id](#output\_application\_id) | The ID of the application. |
| <a name="output_application_url"></a> [application\_url](#output\_application\_url) | The URL of the application. |
| <a name="output_group_id"></a> [group\_id](#output\_group\_id) | The ID of the group. |
| <a name="output_organization_id"></a> [organization\_id](#output\_organization\_id) | The ID of the organization. |
<!-- END_TF_DOCS -->