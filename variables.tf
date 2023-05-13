variable "iam_roles" {
  type = map(object({
    statements = map(object({
      actions     = list(string)
      type        = string
      identifiers = list(string)
    }))
    policies = set(string)
  }))
}

variable "lambda_functions" {
  type = map(object({
    filename  = string
    role_name = string
    handler   = string
    runtime   = string
    timeout   = number
  }))
}
