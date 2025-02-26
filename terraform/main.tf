module "acm" {
  source                    = "./modules/acm"
  acm_certificate_name      = local.acm_certificate_name
  domain_name               = var.website_domain_name
  project_name              = var.project_name
  subject_alternative_names = var.website_alternative_names
  route53_zone_id           = data.aws_route53_zone.selected.zone_id
  
}
module "cloudfront" {
  source                          = "./modules/cloudfront"
  cloudfront_origin_id            = local.cloudfront_origin_id
  cloudfront_price_class          = var.cloudfront_price_class
  acm_certificate_arn             = module.acm.acm_certificate_arn
  cloudfront_distribution_comment = local.cloudfront_distribution_comment
  oac_name                        = local.oac_name
  cloudfront_aliases              = local.cloudfront_aliases
  project_name                    = var.project_name
  s3_bucket_domain_name           =  module.s3.bucket_domain_name
  }

module "iam" {
  source                      = "./modules/iam"
  lambda_role_name            = local.lambda_role_name
  lambda_policy_name          = local.lambda_policy_name
  lambda_s3_resource_arn      = module.s3.s3_bucket_arn
  lambda_secrets_manager_arn  = module.secretsmanager.secrets_manager_secret_arn
}

module "lambda" {
  source                        = "./modules/lambda"
  lambda_function_name          = local.lambda_function_name
  lambda_filename               = var.lambda_filename
  lambda_zip_path               = local.lambda_zip_path
  lambda_runtime                = var.lambda_runtime
  lambda_role_arn               = module.iam.lambda_role_arn 
  lambda_environment_variables  = local.lambda.environment_variables
  }
  
module "route53" {
  source                    = "./modules/route53"
  website_domain_name       = var.website_domain_name
  cloudfront_domain_name    = module.cloudfront.cloudfront_domain_name
  cloudfront_hosted_zone_id = module.cloudfront.cloudfront_hosted_zone_id
  website_domain_zone_id    = data.aws_route53_zone.selected.zone_id
}

module "s3" {
  source                      = "./modules/s3"
  project_name                = var.project_name
  bucket_name                 = local.bucket_name
  s3_files                    = local.s3_files_list
  cloudfront_distribution_arn = module.cloudfront.cloudfront_distribution_arn
}

module "sns" {
  source                  = "./modules/sns"
  sns_topic_name          = local.sns_topic_name
  lambda_function_name    = local.lambda_function_name
  sns_subscription_email  = var.sns_subscription_email
}

module "secretsmanager" {
  source                      = "./modules/secretsmanager"
  secrets_manager_secret_name = var.secrets_manager_secret_name
  spotify_client_id           = var.spotify_client_id
  spotify_client_secret       = var.spotify_client_secret
}