resource "aws_dynamodb_table" "dynamodb_table" {
  name         = var.table_name
  billing_mode = var.billing_mode
  hash_key     = var.hash_key

  attribute {
    name = var.attribute_name
    type = var.attribute_type
  }
}
