resource "aws_apigatewayv2_integration" "api_integration" {
  api_id             = var.api_id
  integration_type   = var.integration_type
  integration_method = var.api_method
  integration_uri    = var.integration_uri
  payload_format_version = var.payload_version
}
