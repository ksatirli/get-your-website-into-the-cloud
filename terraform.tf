terraform {
  #  # Terraform Cloud provides a runtime environment for your Terraform Runs.
  #  # see https://developer.hashicorp.com/terraform/tutorials/cloud-get-started/cloud-sign-up
  #  # and https://developer.hashicorp.com/terraform/language/settings/terraform-cloud
  #  cloud {
  #    # see https://developer.hashicorp.com/terraform/cli/cloud/settings#organization
  #    organization = "a-demo-organization"
  #
  #    # see https://developer.hashicorp.com/terraform/cli/cloud/settings#workspaces
  #    workspaces {
  #      name = "get-your-website-into-the-cloud"
  #    }
  #  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/aws/4.59.0
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.59.0, < 5.0.0"
    }

    # see https://registry.terraform.io/providers/go-gandi/gandi/2.2.3
    gandi = {
      source  = "go-gandi/gandi"
      version = "2.2.3"
    }

    # see https://registry.terraform.io/providers/integrations/github/5.18.3/
    github = {
      source  = "integrations/github"
      version = ">= 5.18.3, < 6.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/local/2.4.0
    local = {
      source  = "hashicorp/local"
      version = ">= 2.4.0, < 3.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/random/3.4.3
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-a-required-terraform-version
  required_version = ">= 1.4.2"
}
