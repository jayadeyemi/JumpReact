variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "bucket_region" {
  description = "The AWS region where the S3 bucket is located"
  type        = string
}

variable "origin_access_identity" {
  description = "The origin access identity for CloudFront"
  type        = string
}