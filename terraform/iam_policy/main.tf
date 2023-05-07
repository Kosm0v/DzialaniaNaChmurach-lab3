data "aws_iam_policy_document" "policy" {
  dynamic "statement" {
    for_each = var.statements
    content {
      sid       = statement.key
      effect    = statement.value.effect
      actions   = statement.value.actions
      resources = statement.value.resources
    }
  }
}

resource "aws_iam_policy" "iam_policy" {
  name   = var.name
  policy = data.aws_iam_policy_document.policy.json
}
