resource "aws_dynamodb_table" "company" {
  name         = "${var.project}-company-${terraform.workspace}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "company_id"
  deletion_protection_enabled = true

  point_in_time_recovery {
    enabled = true
  }

  attribute {
    name = "company_id"
    type = "S"
  }

  attribute {
    name = "name"
    type = "S"
  }

  attribute {
    name = "cnpj"
    type = "S"
  }

  global_secondary_index {
    name            = "name-index"
    hash_key        = "name"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "cnpj-index"
    hash_key        = "cnpj"
    projection_type = "ALL"
  }

  tags = {
    Service = var.project
  }
}
