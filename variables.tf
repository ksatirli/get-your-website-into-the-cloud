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

