locals {
  policies = {
    "Kosmowski-LambdaRole" = {
      "CreateLogGroup" = {
        effect    = "Allow"
        actions   = ["logs:CreateLogGroup"],
        resources = ["arn:aws:logs:eu-north-1:700865812391:*"]
      }
      "PutLogEvents" = {
        effect = "Allow"
        actions = ["logs:CreateLogStream",
        "logs:PutLogEvents"]
        resources = [
          "arn:aws:logs:eu-north-1:700865812391:log-group:/aws/lambda/Kosmowski-ZwrocCenySzkolenia:*"
        ]
      }
      "AllowGetItem" = {
        effect = "Allow"
        actions = ["dynamodb:DescribeTable",
        "dynamodb:GetItem"]
        resources = [module.dynamodb["Kosmowski-Ceny"].table_arn]
      }
    }
  }

  api_gateways = {
    "Kosmowski-CenyAPIIntegration" = {
      api_id           = module.http_api["Kosmowski-CenyAPI"].api_id
      integration_type = "AWS_PROXY"
      api_method       = "POST"
      integration_uri  = module.lambda_function["Kosmowski-ZwrocCenySzkolenia"].invoke_arn
      payload_version  = "2.0"
    }
  }

  api_routes = {
    "Kosmowski-GetCenyRoute" = {
      api_id    = module.http_api["Kosmowski-CenyAPI"].api_id
      route_key = "GET /Ceny"
      target    = "integrations/${module.http_api_integration["Kosmowski-CenyAPIIntegration"].integration_id}"
    }
  }

  api_stages = {
    "Kosmowski-GetCenyStage" = {
      api_id     = module.http_api["Kosmowski-CenyAPI"].api_id
      stage_name = "prd"
    }
  }

  lambda_permissions = {
    "Kosmowski-ZwrocCenySzkoleniaPermissions" = {
      statement_id  = "AllowInvokeFunction"
      action        = "lambda:InvokeFunction"
      function_name = module.lambda_function["Kosmowski-ZwrocCenySzkolenia"].function_name
      principal     = "apigateway.amazonaws.com"
      source_arn    = "${module.http_api["Kosmowski-CenyAPI"].api_execution_arn}/*/*/Ceny"
    }
  }
}
