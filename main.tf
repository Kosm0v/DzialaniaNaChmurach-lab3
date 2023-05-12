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
