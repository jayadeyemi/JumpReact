variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "iam_role_name" {
  description = "Name for the Lambda execution role"
  type        = string
  default     = "portfolio_iam_role"
}

variable "lambda_function_name" {
  description = "Name for the Lambda function"
  type        = string
  default     = "my_lambda_function"
}

variable "lambda_role_name" {
  description = "The name of the IAM role for Lambda execution"
  type        = string
  default     = "portfolio_lambda_role"
}

variable "lambda_py_zip" {
  description = "The path to the zipped Python Lambda function code"
  type        = string
  default     = "./lambda/lambda_function.zip"
}
variable "lambda_handler" {
  description = "Lambda function handler"
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "lambda_runtime" {
  description = "Lambda runtime"
  type        = string
  default     = "python3.8"
}

variable "lambda_s3_bucket" {
  description = "S3 bucket for Lambda deployment package"
  type        = string
}

variable "lambda_s3_key" {
  description = "S3 key for the Lambda deployment package zip file"
  type        = string
}

variable "api_name" {
  description = "Name of the API Gateway"
  type        = string
  default     = "my-api-gateway"
}

variable "api_stage_name" {
  description = "Stage name for the API Gateway deployment"
  type        = string
  default     = "prod"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for static website hosting"
  type        = string
}

variable "domain_name" {
  description = "Domain name for Route53 DNS records"
  type        = string
}

variable "zone_id" {
  description = "Route 53 Hosted Zone ID"
  type        = string
}
