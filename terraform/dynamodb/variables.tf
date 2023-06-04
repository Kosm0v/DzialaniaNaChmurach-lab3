variable "table_name" {
  type        = string
  description = "DynamoDB Table Name"
}

variable "billing_mode" {
  type        = string
  description = "Billing mode"
}

variable "hash_key" {
  type        = string
  description = "Hash Key"
}

variable "attribute_name" {
  type = string
}

variable "attribute_type" {
  type = string
}
