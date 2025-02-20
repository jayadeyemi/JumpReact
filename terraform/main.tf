module "iam" {
  source           = "./modules/iam"
  iam_role_name = var.iam_role_name
}

module "lambda" {
  source           = "./modules/lambda"
  lambda_role_name = var.lambda_role_name
  lambda_py_zip    = var.lambda_py_zip
  api_gateway_rest_api_arn = module.api_gateway.api_gateway_rest_api_arn
  }

module "api_gateway" {
  source                = "./modules/api_gateway"
  api_name              = var.api_name
  lambda_function_name  = module.lambda.lambda_function_name
  lambda_function_arn   = module.lambda.lambda_function_arn
}

module "s3" {
  source          = "./modules/s3"
  bucket_name     = var.s3_bucket_name
  bucket_region   = var.aws_region
  origin_access_identity = module.cloudfront.aws_cloudfront_origin_access_identity.oai.iam_arn

}

module "cloudfront" {
  source             = "./modules/cloudfront"
  origin_domain_name = module.s3.website_endpoint
}

module "route53" {
  source      = "./modules/route53"
  domain_name = var.domain_name
}