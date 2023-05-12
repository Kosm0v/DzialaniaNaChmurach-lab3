variable "iam_roles" {
  type = map(object({
    statements = map(object({
      actions     = list(string)
      type        = string
      identifiers = list(string)
    }))
  }))
}

