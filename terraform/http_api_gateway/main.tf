resource "aws_apigatewayv2_api" "http_api_gateway" {
  name          = var.api_gateway_name
  protocol_type = var.protocol_type
}
