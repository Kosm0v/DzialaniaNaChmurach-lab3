output "api_id" {
  value = aws_apigatewayv2_api.http_api_gateway.id
}

output "api_execution_arn" {
  value = aws_apigatewayv2_api.http_api_gateway.execution_arn
}
