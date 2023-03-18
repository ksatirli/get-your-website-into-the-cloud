output "workshop_urls" {
  description = "Convenience Output with URLs for the workshop."
  value = [
    "https://us-east-1.console.aws.amazon.com/route53/v2/hostedzones#ListRecordSets/${aws_route53_zone.main.zone_id}"
  ]
}

output "gandi_domain" {
  description = "Exported Attributes of the `gandi_domain.main` Data Source."
  value       = data.gandi_domain.main
}

output "aws_route53_zone" {
  description = "Exported Attributes of the `aws_route53_zone.main` Resource."
  value       = aws_route53_zone.main
}

output "gandi_nameservers" {
  description = "Exported Attributes of the `gandi_nameservers.main` Resource."
  value       = gandi_nameservers.main
}
