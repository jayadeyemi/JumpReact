output "lambda_function_arn" {
  value = module.lambda.lambda_function_arn
}

output "api_rest_api_id" {
  value = module.api_gateway.rest_api_id
}

output "s3_bucket_website" {
  value = module.s3.website_endpoint
}

output "cloudfront_domain_name" {
  value = module.cloudfront.cloudfront_domain_name
}

output "route53_dns_record" {
  value = module.route53.dns_record
}

output "lambda_role_arn" {
  value = module.iam.lambda_role_arn
}
