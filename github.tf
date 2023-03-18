# see https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/user
data "github_user" "main" {
  username = var.github_owner
}

# If your projects are hosted inside a GitHub Organization, uncomment this:
# see https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/organization
#data "github_organization" "main" {
#  name = var.github_owner
#}

locals {
  # use this search query if you are retrieving projects stored under a personal GitHub Account
  # change "is:public" to "is:private" if you intend to showcase private projects
  # change "archived:false" to "archived:true" if you intend to showcase archived projects
  github_api_query = "user:${data.github_user.main.username} is:public archived:false"

  # uncomment and use this search query if you are retrieving projects stored under a GitHub Organization
  # change "is:public" to "is:private" if you intend to showcase private projects
  # change "archived:false" to "archived:true" if you intend to showcase archived projects
  #github_api_query = "org:${data.github_organization.main.orgname} is:public archived:false"
}

# get all repositories for the GitHub Organization
# see https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/repositories
data "github_repositories" "main" {
  # find all repositories that are specific to this organization and are publicly available
  # see https://docs.github.com/search-github/searching-on-github/searching-for-repositories
  query = local.github_api_query
}

# iterate over ALL repositories from the `data.github_repositories` data source and retrieve more information
# see https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/repository
data "github_repository" "main" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = toset(data.github_repositories.main.full_names)

  full_name = each.key
}
