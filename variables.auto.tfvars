iam_roles = {
  "KosmowskiDynamodbGetItemRole" = {
    statements = {
      "AllowAssumeForLambda" = {
        actions     = ["sts:AssumeRole"]
        type        = "Service"
        identifiers = ["lambda.amazonaws.com"]
      }
    }
  }
}
