# use data source to get domain name as registered through Gandi
# see https://registry.terraform.io/providers/go-gandi/gandi/latest/docs/data-sources/domain
data "gandi_domain" "main" {
  name = var.website.domain
}

# create DNS Zone in AWS to get Nameserver values
# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone
resource "aws_route53_zone" "main" {
  name    = data.gandi_domain.main.name
  comment = "Terraform-managed DNS Zone for Open Source 101 workshop."
}

# set Nameserver values from AWS inside Gandi
# see https://registry.terraform.io/providers/go-gandi/gandi/latest/docs/resources/nameservers
resource "gandi_nameservers" "main" {
  domain      = data.gandi_domain.main.name
  nameservers = aws_route53_zone.main.name_servers
}
