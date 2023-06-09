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
  # Option 1: Personal GitHub Account
  # uncomment and use this object if you are retrieving projects stored under a personal GitHub Account
  github_owner_data = {
    description = data.github_user.main.bio
    image       = data.github_user.main.avatar_url
    name        = data.github_user.main.name
    query       = "user:${data.github_user.main.username}"
    username    = data.github_user.main.username
  }

  # Option 2: GitHub Organization
  # uncomment and use this object if you are retrieving projects stored under a GitHub Organization
  # then comment the `github_owner_data` object of "Option 1" above
  # github_owner_data = {
  #   description = data.github_organization.main.description
  #   name        = data.github_organization.main.name
  #   query       = "org:${data.github_organization.main.orgname}"
  #   username    = data.github_organization.main.orgname
  # }

  # change "is:public" to "is:private" if you intend to showcase private projects
  # change "archived:false" to "archived:true" if you intend to showcase archived projects
  github_api_query = "${local.github_owner_data.query} is:public archived:false"
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
