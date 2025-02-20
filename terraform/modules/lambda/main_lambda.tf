# Lambda function for dynamic data processing
resource "aws_lambda_function" "data_processor" {
  function_name    = var.lambda_role_name
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.8"
  role             = aws_iam_role.lambda_exec_role.arn
  filename         = var.lambda_py_zip
  source_code_hash = filebase64sha256("lambda_function.zip")
  timeout          = 300
}

# Grant API Gateway permission to invoke the Lambda function
resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.data_processor.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api_gateway_rest_api_arn}/*/*"
}