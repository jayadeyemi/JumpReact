
# S3 Bucket for the static webpage
resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name
  region = var.bucket_region
}

# Enable public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "static_site_private_access" {
    bucket                  = aws_s3_bucket.website_bucket.id
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "static_site_ownership" {
  bucket = aws_s3_bucket.website_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "static_site_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.static_site_ownership,
    aws_s3_bucket_public_access_block.static_site_private_access
  ]

  bucket = aws_s3_bucket.website_bucket.id
  acl    = "public-read"
}
# Upload the static HTML page to S3
resource "aws_s3_object" "static_site" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "static/index.html"
  source       = "./app/static/index.html"
  content_type = "text/html"
}

# Upload the dynamic HTML page to S3
resource "aws_s3_object" "interactive_site" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "dynamic/interactive.html"
  source       = "./app/dynamic/interactive.html"
  content_type = "text/html"
}


resource "aws_s3_bucket_policy" "static_site_policy" {
  bucket = aws_s3_bucket.website_bucket.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "AllowCloudFrontAccess",
        "Effect": "Allow",
        "Principal": {
          "AWS": "${var.origin_access_identity}"
        },
        "Action": "s3:GetObject",
        "Resource": "${aws_s3_bucket.static_site.arn}/*"
      }
    ]
  })
}

