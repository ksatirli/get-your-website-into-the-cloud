# create a random string that we can use as a prefix or suffix for resources
# that have a name that must be globally unique, such as AWS S3 Buckets.
# see https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "main" {
  length  = 4
  lower   = true
  special = false
  upper   = false
}

# see https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
resource "local_file" "website" {
  # see https://developer.hashicorp.com/terraform/language/functions/templatefile
  content = templatefile("./templates/index.tftpl.html", {
    fontawesome_identifier = var.fontawesome_identifier
    name                   = local.github_owner_data.name,
    github_user            = local.github_owner_data.username,
    description            = local.github_owner_data.description,
    repositories           = data.github_repository.main,
    theme_color            = var.website.theme_color,
    query                  = local.github_owner_data.query,
    twitter_user           = var.website.twitter_user,
  })

  filename = "${path.module}/dist/index.html"
}

# see https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
resource "local_file" "stylesheet" {
  # see https://developer.hashicorp.com/terraform/language/functions/templatefile
  content = templatefile("./templates/website.tftpl.css", {
    theme_color = var.website.theme_color,
  })

  filename = "${path.module}/dist/website.css"
}

module "websites" {
  source  = "ksatirli/cloudfront-website/aws"
  version = "1.0.0"

  # see https://developer.hashicorp.com/terraform/language/providers/configuration#alias-multiple-provider-configurations
  providers = {
    # NOTE: ACM Certificates for usage with CloudFront must be created in the `us-east-1` region
    # see https://amzn.to/2TW2J16
    aws.certificate = aws.certificate
  }

  # take domain name and remove dot characters from string, then append suffix with random string
  s3_bucket_name = "${local.github_owner_data.username}-site-${random_string.main.result}"
  domain_name    = data.gandi_domain.main.name

  # create `www` subdomain for broader accessibility
  alternate_domain_names = [
    "www.${data.gandi_domain.main.name}",
  ]
}

locals {
  website_files = [
    {
      path = local_file.website.filename,
      type = "text/html",
      }, {
      path = local_file.stylesheet.filename,
      type = "text/css",
    }
  ]
}

# see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
resource "aws_s3_object" "main" {
  # iterate over website files
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = {
    for index, file in local.website_files :
    file.path => file
  }

  # retrieve S3 Bucket name from Module
  bucket = module.websites.aws_s3_bucket.id

  content_type = each.value.type

  # replace `dist/` to clean up destination
  key    = replace(each.value.path, "dist/", "")
  source = each.value.path

  # set an ETag to allow for easier content invalidation
  # see https://developer.hashicorp.com/terraform/language/functions/filemd5
  #etag = filemd5(each.key)
}
