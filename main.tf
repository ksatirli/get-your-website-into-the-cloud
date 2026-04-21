# see https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/user
data "github_user" "main" {
  username = var.github_owner
}

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

# see https://registry.terraform.io/providers/integrations/github/6.11.1/docs/resources/repository
resource "github_repository" "main" {
  name        = "${var.github_owner}.github.io"
  description = "Terraform made this website for me!"

  visibility = "public"
  auto_init  = true
}

# see https://registry.terraform.io/providers/integrations/github/6.11.1/docs/resources/repository_file
resource "github_repository_file" "main" {
  for_each = {
    "index.html" = local_file.website.content
    "styles.css" = local_file.stylesheet.content
  }

  repository = github_repository.main.name
  branch     = "main"

  file    = each.key
  content = each.value

  commit_message      = "Managed by Terraform"
  commit_author       = var.github_owner
  commit_email        = "noreply@github.com"
  overwrite_on_create = true
}

# Enable GitHub Pages AFTER the `main` branch has content, to avoid the
# 422 "main branch must exist before GitHub Pages can be built" race the
# integrations/github provider exhibits when `pages` is embedded in the
# repository resource.
resource "null_resource" "pages" {
  depends_on = [github_repository_file.main]

  triggers = {
    repository = github_repository.main.name
  }

  provisioner "local-exec" {
    interpreter = ["/bin/sh", "-c"]
    environment = {
      GITHUB_TOKEN = var.github_token
      REPO         = "${var.github_owner}/${github_repository.main.name}"
    }
    command = <<-EOT
      set -e
      payload='{"source":{"branch":"main","path":"/"}}'
      # Try to create; if Pages is already configured, update instead.
      status=$(curl -sS -o /tmp/pages.out -w "%%{http_code}" \
        -X POST \
        -H "Authorization: Bearer $GITHUB_TOKEN" \
        -H "Accept: application/vnd.github+json" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        "https://api.github.com/repos/$REPO/pages" \
        -d "$payload")
      if [ "$status" = "409" ] || [ "$status" = "422" ]; then
        curl -sS -f \
          -X PUT \
          -H "Authorization: Bearer $GITHUB_TOKEN" \
          -H "Accept: application/vnd.github+json" \
          -H "X-GitHub-Api-Version: 2022-11-28" \
          "https://api.github.com/repos/$REPO/pages" \
          -d "$payload"
      elif [ "$status" != "201" ]; then
        cat /tmp/pages.out
        exit 1
      fi
    EOT
  }
}
