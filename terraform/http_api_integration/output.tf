output "integration_id" {
  value = aws_apigatewayv2_integration.api_integration.id
}

output "test" {
  value = aws_apigatewayv2_integration.api_integration.integration_uri
}
