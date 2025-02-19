
# API Gateway REST API
resource "aws_api_gateway_rest_api" "data_api" {
  name = "data-api"
}

# Create a resource endpoint (e.g. /data)
resource "aws_api_gateway_resource" "data_resource" {
  rest_api_id = aws_api_gateway_rest_api.data_api.id
  parent_id   = aws_api_gateway_rest_api.data_api.root_resource_id
  path_part   = "data"
}

# Define a GET method for the /data resource
resource "aws_api_gateway_method" "get_data" {
  rest_api_id   = aws_api_gateway_rest_api.data_api.id
  resource_id   = aws_api_gateway_resource.data_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

# Integrate the GET method with the Lambda function (AWS_PROXY)
resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.data_api.id
  resource_id             = aws_api_gateway_resource.data_resource.id
  http_method             = aws_api_gateway_method.get_data.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.data_processor.invoke_arn
}



# Deploy the API Gateway
resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on  = [aws_api_gateway_integration.lambda_integration]
  rest_api_id = aws_api_gateway_rest_api.data_api.id
  stage_name  = "prod"
}
