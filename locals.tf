locals {
  policies = {
    "KosmowskiBasicLambdaPermision" = {
      "CreateLogGroupPermission" = {
        effect    = "Allow"
        actions   = ["logs:CreateLogGroup"],
        resources = ["arn:aws:logs:eu-central-1:294914763164:*"]
      }
      "PutLogEventsPermission" = {
        effect = "Allow"
        actions = ["logs:CreateLogStream",
        "logs:PutLogEvents"]
        resources = [
          "arn:aws:logs:eu-central-1:294914763164:log-group:/aws/lambda/ReturnPriceOfProduct:*"
        ]
      }
    }
    "KosmowskiDynamodbAllowGetItem" = {
      "AllowGetItem" = {
        effect = "Allow"
        actions = ["dynamodb:DescribeTable",
        "dynamodb:GetItem"]
        resources = ["arn:aws:dynamodb:eu-north-1:294914763164:table/ceny"]
      }
    }
  }




}
