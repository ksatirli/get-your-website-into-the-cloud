# Open Source 101: Get Your Website into the Cloud

## Table of Contents

<!-- TOC -->
* [Open Source 101: Get Your Website into the Cloud](#open-source-101--get-your-website-into-the-cloud)
  * [Table of Contents](#table-of-contents)
    * [Inputs](#inputs)
    * [Outputs](#outputs)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| fontawesome_identifier | Font Awesome Kit Identifier. | `string` | yes |
| gandi_key | This is Gandi API Access Key. | `string` | yes |
| github_token | This is the GitHub token. | `string` | yes |
| github_owner | This is the target GitHub organization or individual user account to manage. | `string` | no |
| website | Object of Website Configuration data. | <pre>object({<br>    domain       = string<br>    theme_color  = string<br>    twitter_user = string<br>  })</pre> | no |

### Outputs

No outputs.
| Name | Description |
|------|-------------|
| aws_route53_zone | Exported Attributes of the `aws_route53_zone.main` Resource. |
| gandi_domain | Exported Attributes of the `gandi_domain.main` Data Source. |
| gandi_nameservers | Exported Attributes of the `gandi_nameservers.main` Resource. |
| workshop_urls | Convenience Output with URLs for the workshop. |
<!-- END_TF_DOCS -->

## Author Information

This module is maintained by the contributors listed on [GitHub](https://github.com/ksatirli/get-your-website-into-the-cloud/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
