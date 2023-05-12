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

lambda_functions = {
  "ReturnPriceOfProduct" = {
    filename  = "ReturnPriceOfProduct.zip"
    role_name = "KosmowskiDynamodbGetItemRole"
    handler   = "main.lambda_handler"
    runtime   = "python3.9"
    timeout   = 30
  }
}
