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

# Option 1: Personal GitHub Account
# uncomment and use this output if you are retrieving projects stored under a personal GitHub Account
output "github_user" {
  description = "Exported Attributes of the `github_user.main` Data Source."
  value       = data.github_user.main
}

# Option 2: GitHub Organization
# uncomment and use this output if you are retrieving projects stored under a GitHub Organization
#output "github_organization" {
#  description = "Exported Attributes of the `github_organization.main` Data Source."
#  value       = data.github_organization.main
#}

output "invalidation_command" {
  description = "AWS CLI Command for CloudFront Invalidation."
  value       = "aws cloudfront create-invalidation --distribution-id ${module.websites.aws_cloudfront_distribution.id} --paths '/${basename(local_file.website.filename)}' '/${basename(local_file.stylesheet.filename)}'"
}

output "random_string" {
  description = "Exported Attributes of the `random_string.main` Resource."
  value       = random_string.main
}

output "route53_zone" {
  description = "Exported Attributes of the `aws_route53_zone.main` Resource."
  value       = aws_route53_zone.main
}

output "workshop_urls" {
  description = "Convenience Output with URLs for the workshop."

  value = [
    "https://s3.console.aws.amazon.com/s3/buckets/${module.websites.aws_s3_bucket.id}?region=${module.websites.aws_s3_bucket.region}",
    "https://us-east-1.console.aws.amazon.com/route53/v2/hostedzones#ListRecordSets/${aws_route53_zone.main.zone_id}",
    "https://us-east-1.console.aws.amazon.com/cloudfront/v3/home?region=us-east-1#/distributions/${module.websites.aws_cloudfront_distribution.id}",
  ]
}
