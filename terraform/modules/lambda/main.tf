
# Lambda function for dynamic data processing
resource "aws_lambda_function" "data_processor" {
  function_name    = "dataProcessor"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.8"
  role             = aws_iam_role.lambda_exec_role.arn
  filename         = "lambda_function.zip"  # Package your lambda_function.py into a zip file
  source_code_hash = filebase64sha256("lambda_function.zip")
}
