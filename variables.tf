variable "iam_roles" {
  type = map(object({
    statements = map(object({
      actions     = list(string)
      type        = string
      identifiers = list(string)
    }))
    policy_name = string
  }))
}

variable "lambda_functions" {
  type = map(object({
    filename              = string
    role_name             = string
    handler               = string
    runtime               = string
    timeout               = number
    environment_variables = map(string)
  }))
}

variable "dynamodb_tables" {
  type = map(object({
    billing_mode   = string
    hash_key       = string
    attribute_name = string
    attribute_type = string
  }))
}

variable "api_gateways" {
  type = map(object({
    protocol_type = string
  }))
}
