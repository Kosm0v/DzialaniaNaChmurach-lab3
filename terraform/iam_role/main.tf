data "aws_iam_policy_document" "trust_relationship" {
  dynamic "statement" {
    for_each = var.statements
    content {
      actions = statement.value.actions
      sid     = statement.key
      principals {
        type        = statement.value.type
        identifiers = statement.value.identifiers
      }
    }
  }
}

resource "aws_iam_role" "role" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.trust_relationship.json
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = var.policy_arn
}
