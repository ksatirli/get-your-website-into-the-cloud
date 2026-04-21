config {
  call_module_type    = "none"
  force               = false
  disabled_by_default = false
}

plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

plugin "azurerm" {
  enabled = true

  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"

  # see https://github.com/terraform-linters/tflint-ruleset-azurerm/releases
  version = "0.31.1"
}
