provider "aws" {
  region = "us-east-1"
}

# S3 Bucket for the static webpage
resource "aws_s3_bucket" "static_site" {
  bucket = "my-static-site-bucket-unique"
}

# Enable public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "static_site_public_access" {
    bucket                  = aws_s3_bucket.static_site.id
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "static_site_ownership" {
  bucket = aws_s3_bucket.static_site.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "static_site_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.static_site_ownership,
    aws_s3_bucket_public_access_block.static_site_public_access
  ]

  bucket = aws_s3_bucket.static_site.id
  acl    = "public-read"
}
# Upload the static HTML page to S3
resource "aws_s3_object" "static_site_index" {
  bucket       = aws_s3_bucket.static_site.id
  key          = "index.html"
  source       = "static/index.html"
  content_type = "text/html"
}



# Route 53 DNS record to point your domain to CloudFront
resource "aws_route53_record" "static_site_record" {
  zone_id = "YOUR_ROUTE53_ZONE_ID"  # Replace with your Route 53 hosted zone ID
  name    = "www.babasanmiadeyemiportfolio.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.static_site_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.static_site_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_s3_bucket_policy" "private_prefix_policy" {
  bucket = aws_s3_bucket.static_site.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "DenyPublicReadForPrivateFolder",
        "Effect": "Deny",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "${aws_s3_bucket.static_site.arn}/private/*"
      }
    ]
  })
}

# S3 Bucket for the interactive visualization page
resource "aws_s3_bucket" "interactive_site" {
  bucket = "my-interactive-site-bucket-unique"
  acl    = "public-read"

  website {
    index_document = "interactive.html"
    error_document = "error.html"
  }
}

# Upload the interactive HTML page to S3
resource "aws_s3_bucket_object" "interactive_page" {
  bucket       = aws_s3_bucket.interactive_site.id
  key          = "interactive.html"
  source       = "interactive/interactive.html"  # Local path to your interactive page
  content_type = "text/html"
}


