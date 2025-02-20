output "dns_record" {
  description = "The DNS record created for the domain"
  value       = aws_route53_record.site_dns.fqdn
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.static_site.arn
}