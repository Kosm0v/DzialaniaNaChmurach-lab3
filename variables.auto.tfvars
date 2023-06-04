iam_roles = {
  "Kosmowski-DynamodbGetItemRole" = {
    statements = {
      "AllowAssumeForLambda" = {
        actions     = ["sts:AssumeRole"]
        type        = "Service"
        identifiers = ["lambda.amazonaws.com"]
      }
    }
    policy_name = "Kosmowski-LambdaRole"
  }
}

lambda_functions = {
  "Kosmowski-ZwrocCenySzkolenia" = {
    filename  = "Kosmowski-ZwrocCenySzkolenia.zip"
    role_name = "Kosmowski-DynamodbGetItemRole"
    handler   = "main.lambda_handler"
    runtime   = "python3.9"
    timeout   = 10
    environment_variables = {
      "DYNAMODB_TABLE_NAME" = "Kosmowski-Ceny"
    }
  }
}

dynamodb_tables = {
  "Kosmowski-Ceny" = {
    billing_mode   = "PAY_PER_REQUEST"
    hash_key       = "Usluga"
    attribute_name = "Usluga"
    attribute_type = "S"
  }
  "Kosmowski-Ceny2" = {
    billing_mode   = "PAY_PER_REQUEST"
    hash_key       = "Usluga"
    attribute_name = "Usluga"
    attribute_type = "S"
  }
}

api_gateways = {
  "Kosmowski-CenyAPI" = {
    protocol_type = "HTTP"
  }
}
