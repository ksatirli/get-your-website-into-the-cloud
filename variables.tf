variable "gandi_key" {
  type        = string
  description = "This is Gandi API Access Key."
  sensitive   = true
}

variable "github_owner" {
  type        = string
  description = "This is the target GitHub organization or individual user account to manage."
  default     = "ksatirli"
}

variable "github_token" {
  type        = string
  description = "This is the GitHub token."
  sensitive   = true
}

variable "fontawesome_identifier" {
  type        = string
  description = "Font Awesome Kit Identifier."
  sensitive   = true
}

# see https://admin.gandi.net/domain/opensource101.fun/overview
variable "website" {
  type = object({
    domain       = string
    theme_color  = string
    twitter_user = string
  })

  description = "Object of Website Configuration data."
  default = {
    # Website Domain
    domain = "opensource101.fun"

    # Website Theme Color
    theme_color = "#e71e25" # Open Source 101-Red

    # Website Twitter Account
    twitter_user = "@OS101Series"
  }
}
