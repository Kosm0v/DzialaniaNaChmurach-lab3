resource "aws_lambda_function" "lambda_function" {
  filename         = var.filename
  function_name    = var.function_name
  role             = var.role_arn
  handler          = var.handler
  runtime          = var.runtime
  source_code_hash = filebase64sha256(var.filename)
  timeout          = var.timeout

  dynamic "environment" {
    for_each = length(var.environment_variables) == 0 ? [] : ["0"]
    content {
      variables = var.environment_variables
    }
  }
}
