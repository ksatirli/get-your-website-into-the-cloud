# The GitHub Provider is set to retrieve configuration from the executing environment
# see https://registry.terraform.io/providers/integrations/github/latest/docs
provider "github" {
  token = var.github_token
  owner = var.github_owner
}

# see https://registry.terraform.io/providers/hashicorp/local/latest/docs
provider "local" {}
