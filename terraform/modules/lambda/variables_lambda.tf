variable "lambda_role_name" {
  description = "The name of the IAM role for Lambda execution"
  type        = string
}

variable "lambda_py_zip" {
  description = "The path to the zipped Python Lambda function code"
  type        = string
}

variable "api_gateway_rest_api_arn" {
  description = "ID of the API Gateway"
  type        = string  
}