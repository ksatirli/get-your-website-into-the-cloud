# Open Source 101 - Get Your Website into the Cloud

> This repository contains code for the [Open Source 101](https://opensource101.com) workshop _"Get Your Website into the Cloud"_.

## Table of Contents

<!-- TOC -->
* [Open Source 101 - Get Your Website into the Cloud](#open-source-101---get-your-website-into-the-cloud)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Inputs](#inputs)
    * [Outputs](#outputs)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

* Amazon Web Services (AWS) [Account](https://aws.amazon.com/account/)
* GitHub [Account](https://github.com/join)
* Terraform `1.4.x` or newer.

## Usage

1.) Copy [`./terraform.tfvars.sample`](./terraform.tfvars.sample) to `./terraform.tfvars` and fill in all values.

* `fontawesome_identifier` expects a [Font Awesome](https://fontawesome.com) Kit identifier.
* `gandi_key` expects a [Gandi](https://www.gandi.net/en/solutions/api) API key.
* `github_owner` expects a GitHub User or GitHub Organization slug.
* `github_token` expects a GitHub [Personal Access Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token).

Optionally, all values may be provided as environment variables (including options such as `DirEnv` and `.envrc` files)
https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token

2.) Initialize Terraform to retrieve OS-specific provider binaries and underlying Terraform Module code.

```shell
cd get-your-website-into-the-cloud

terraform init
```

3.) Preview the expected deployment resources by running `terraform plan`

```shell
terraform plan
```

4.) If the output of step 3 looks acceptable, deploy the changes using `terraform apply`

```shell
terraform apply
```

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| fontawesome_identifier | Font Awesome Kit Identifier. | `string` | yes |
| gandi_key | This is Gandi API Access Key. | `string` | yes |
| github_owner | This is the target GitHub organization or individual user account to manage. | `string` | yes |
| github_token | This is the GitHub token. | `string` | yes |
| website | Object of Website Configuration data. | <pre>object({<br>    domain       = string<br>    theme_color  = string<br>    twitter_user = string<br>  })</pre> | no |

### Outputs

| Name | Description |
|------|-------------|
| gandi_domain | Exported Attributes of the `gandi_domain.main` Data Source. |
| gandi_nameservers | Exported Attributes of the `gandi_nameservers.main` Resource. |
| github_repositories | Exported Attributes of the `github_repository.main` Data Source. |
| github_repositories_list | Exported List of Repositories of the `github_repositories.main` Data Source. |
| github_user | Exported Attributes of the `github_user.main` Data Source. |
| invalidation_command | AWS CLI Command for CloudFront Invalidation. |
| random_string | Exported Attributes of the `random_string.main` Resource. |
| route53_zone | Exported Attributes of the `aws_route53_zone.main` Resource. |
| workshop_urls | Convenience Output with URLs for the workshop. |
<!-- END_TF_DOCS -->

## Author Information

This module is maintained by the contributors listed on [GitHub](https://github.com/ksatirli/get-your-website-into-the-cloud/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
