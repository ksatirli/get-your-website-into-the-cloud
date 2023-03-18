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
| domains | Project-specific Domains. | `string` | no |
| github_owner | This is the target GitHub organization or individual user account to manage. | `string` | no |
| theme_color | Theme color for the website. | `string` | no |
| twitter_user | Twitter Username. | `string` | no |

### Outputs

No outputs.
<!-- END_TF_DOCS -->

## Author Information

This module is maintained by the contributors listed on [GitHub](https://github.com/ksatirli/get-your-website-into-the-cloud/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
