terraform {
  required_providers {
    # see https://registry.terraform.io/providers/integrations/github/5.18.3/
    github = {
      source  = "integrations/github"
      version = ">= 6.11.0, < 7.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/local/2.8.0
    local = {
      source  = "hashicorp/local"
      version = ">= 2.8.0, < 3.0.0"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-a-required-terraform-version
  required_version = ">= 1.14.0, < 2.0.0"
}
