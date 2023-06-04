module "iam_policy" {
  source     = "./terraform/iam_policy"
  for_each   = local.policies
  name       = each.key
  statements = each.value
}

module "iam_role" {
  source     = "./terraform/iam_role"
  for_each   = var.iam_roles
  statements = each.value.statements
  role_name  = each.key
  policy_arn = module.iam_policy[each.value.policy_name].policy_arn
}

module "lambda_function" {
  source   = "./terraform/lambda_function"
  for_each = var.lambda_functions

  function_name         = each.key
  filename              = each.value.filename
  role_arn              = module.iam_role[each.value.role_name].role_arn
  handler               = each.value.handler
  runtime               = each.value.runtime
  timeout               = each.value.timeout
  environment_variables = each.value.environment_variables
}

module "dynamodb" {
  source   = "./terraform/dynamodb"
  for_each = var.dynamodb_tables

  table_name     = each.key
  billing_mode   = each.value.billing_mode
  hash_key       = each.value.hash_key
  attribute_name = each.value.attribute_name
  attribute_type = each.value.attribute_type
}


module "http_api" {
  source           = "./terraform/http_api_gateway"
  for_each         = var.api_gateways
  api_gateway_name = each.key
  protocol_type    = each.value.protocol_type
}

module "http_api_integration" {
  source           = "./terraform/http_api_integration"
  for_each         = local.api_gateways
  api_id           = each.value.api_id
  integration_type = each.value.integration_type
  api_method       = each.value.api_method
  integration_uri  = each.value.integration_uri
  payload_version  = each.value.payload_version
}

module "http_api_route" {
  source    = "./terraform/http_api_route"
  for_each  = local.api_routes
  api_id    = each.value.api_id
  route_key = each.value.route_key
  target    = each.value.target
}

module "http_api_stage" {
  source     = "./terraform/http_api_stage"
  for_each   = local.api_stages
  api_id     = each.value.api_id
  stage_name = each.value.stage_name
  depends_on = [module.http_api_route]
}

module "lambda_permission" {
  source   = "./terraform/lambda_permissions"
  for_each = local.lambda_permissions

  statement_id  = each.value.statement_id
  action        = each.value.action
  function_name = each.value.function_name
  principal     = each.value.principal
  source_arn    = each.value.source_arn
}
