iam_roles = {
  "KosmowskiDynamodbGetItemRole" = {
    statements = {
      "AllowAssumeForLambda" = {
        actions     = ["sts:AssumeRole"]
        type        = "Service"
        identifiers = ["lambda.amazonaws.com"]
      }
    }
    policies = ["KosmowskiBasicLambdaPermision", "KosmowskiDynamodbAllowGetItem"]
  }
}

lambda_functions = {
  "ReturnPriceOfProduct" = {
    filename  = "ReturnPriceOfProduct.zip"
    role_name = "KosmowskiDynamodbGetItemRole"
    handler   = "main.lambda_handler"
    runtime   = "python3.9"
    timeout   = 30
    environment_variables = {
      "DYNAMODB_TABLE_NAME" = "ceny"
      "API_KEY"             = "UyKd2n7XJ3ZJnD50eS51PWLC9coV7WAu"
    }
  }
}
