# DevOpsCon - Terraform Hands-On Workshop

## Table of Contents

<!-- TOC -->
* [DevOpsCon - Terraform Hands-On Workshop](#devopscon---terraform-hands-on-workshop)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Usage](#usage)
    * [Inputs](#inputs)
    * [Outputs](#outputs)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Requirements

* GitHub [Account](https://github.com/join)
* Terraform `1.14.x` or newer.

## Usage

1.) Copy [`./terraform.tfvars.sample`](./terraform.tfvars.sample) to `./terraform.tfvars` and fill in all values.

* `github_owner` expects a GitHub User or GitHub Organization slug.
* `github_token` expects a GitHub [Personal Access Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token).
  Terraform creates the `${github_owner}.github.io` repository if it does not already exist, enables GitHub Pages, and commits website files. The token therefore needs write access for repository administration and contents updates.
  If the `${github_owner}.github.io` repository already exists, import it into Terraform state before running `terraform apply`:
  ```shell
  terraform import github_repository.main ${github_owner}.github.io

Optionally, all values may be provided as environment variables (including options such as `DirEnv` and `.envrc` files)

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
| ---- | ----------- | ---- | :------: |
| github_owner | This is the target GitHub organization or individual user account to poll. | `string` | yes |
| github_token | This is the GitHub token. | `string` | yes |
| website_theme_color | Website Theme color. | `string` | no |

### Outputs

| Name | Description |
| ---- | ----------- |
| github_repositories | Exported Attributes of the `github_repository.main` Data Source. |
| github_repositories_list | Exported List of Repositories of the `github_repositories.main` Data Source. |
| github_user | Exported Attributes of the `github_user.main` Data Source. |
<!-- END_TF_DOCS -->

## Author Information

This module is maintained by the contributors listed on [GitHub](https://github.com/ksatirli/get-your-website-into-the-cloud/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
