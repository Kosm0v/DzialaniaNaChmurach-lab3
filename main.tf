module "iam_policy" {
  source     = "./terraform/iam_policy"
  for_each   = local.policies
  name       = each.key
  statements = each.value
}
