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
}

module "lambda_function" {
  source   = "./terraform/lambda_function"
  for_each = var.lambda_functions

  function_name = each.key
  filename      = each.value.filename
  role_arn      = module.iam_role[each.value.role_name].role_arn
  handler       = each.value.handler
  runtime       = each.value.runtime
  timeout       = each.value.timeout
}
