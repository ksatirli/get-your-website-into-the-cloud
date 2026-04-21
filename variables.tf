variable "github_owner" {
  type        = string
  description = "This is the target GitHub organization or individual user account to poll."
}

variable "github_token" {
  type        = string
  description = "This is the GitHub token."
  sensitive   = true
}

variable "website_theme_color" {
  description = "Website Theme color."
  default     = "#d74117" # DevOpsCon orange
  type        = string
}
