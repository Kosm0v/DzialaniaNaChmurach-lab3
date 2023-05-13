variable "statements" {
  type = map(object({
    actions     = list(string)
    type        = string
    identifiers = list(string)
  }))
}

variable "role_name" {
  type = string
}

variable "policy_arns" {
  type = set(string)
}
