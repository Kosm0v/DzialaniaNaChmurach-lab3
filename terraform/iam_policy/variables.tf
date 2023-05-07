variable "name" {
  type        = string
  description = "Name of IAM Policy"
}

variable "statements" {
  type = map(object({
    actions   = set(string)
    effect    = string
    resources = set(string)
  }))
}
