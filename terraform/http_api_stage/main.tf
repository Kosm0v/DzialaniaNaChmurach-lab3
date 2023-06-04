resource "aws_apigatewayv2_deployment" "http_api_deployment" {
  api_id = var.api_id
}

resource "aws_apigatewayv2_stage" "http_api_stage" {
  api_id = var.api_id
  name   = var.stage_name
  #   deployment_id = aws_apigatewayv2_deployment.http_api_deployment.id
  auto_deploy = true
}
