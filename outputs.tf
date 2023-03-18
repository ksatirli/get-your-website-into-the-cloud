output "aws_route53_zone" {
  description = "Exported Attributes of the `aws_route53_zone.main` Resource."
  value       = aws_route53_zone.main
}

output "gandi_domain" {
  description = "Exported Attributes of the `gandi_domain.main` Data Source."
  value       = data.gandi_domain.main
}

output "gandi_nameservers" {
  description = "Exported Attributes of the `gandi_nameservers.main` Resource."
  value       = gandi_nameservers.main
}

output "github_repositories_list" {
  description = "Exported List of Repositories of the `github_repositories.main` Data Source."
  value       = data.github_repositories.main
}

output "github_repositories" {
  description = "Exported Attributes of the `github_repository.main` Data Source."
  value       = data.github_repository.main
}

output "github_user" {
  description = "Exported Attributes of the `github_user.main` Data Source."
  value       = data.github_user.main
}

output "workshop_urls" {
  description = "Convenience Output with URLs for the workshop."
  value = [
    "https://us-east-1.console.aws.amazon.com/route53/v2/hostedzones#ListRecordSets/${aws_route53_zone.main.zone_id}"
  ]
}
