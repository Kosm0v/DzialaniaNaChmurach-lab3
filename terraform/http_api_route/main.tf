resource "aws_apigatewayv2_route" "http_api_route" {
  api_id    = var.api_id
  route_key = var.route_key
  target    = var.target
}
