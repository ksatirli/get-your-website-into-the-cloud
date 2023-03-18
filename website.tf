# create a random string that we can use as a prefix or suffix for resources
# that have a name that must be globally unique, such as AWS S3 Buckets.
# see https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "main" {
  length  = 4
  lower   = true
  special = false
  upper   = false
}

# see https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
resource "local_file" "website" {
  # see https://developer.hashicorp.com/terraform/language/functions/templatefile
  content = templatefile("./templates/index.tftpl.html", {
    fontawesome_identifier = var.fontawesome_identifier
    name                   = local.github_owner_data.name,
    username               = local.github_owner_data.username,
    description            = local.github_owner_data.description,
    repositories           = data.github_repository.main,
    theme_color            = var.website.theme_color,
    query                  = local.github_owner_data.query,
    twitter_user           = var.website.twitter_user,
  })

  filename = "${path.module}/dist/index.html"
}

# see https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
resource "local_file" "stylesheet" {
  # see https://developer.hashicorp.com/terraform/language/functions/templatefile
  content = templatefile("./templates/website.tftpl.css", {
    theme_color = var.website.theme_color,
  })

  filename = "${path.module}/dist/website.css"
}
