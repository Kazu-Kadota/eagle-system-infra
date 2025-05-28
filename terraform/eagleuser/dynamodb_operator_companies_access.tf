resource "aws_dynamodb_table" "operator_companies_access" {
  name         = "${var.project}-operator-companies-access-${terraform.workspace}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "user_id"
  deletion_protection_enabled = true

  point_in_time_recovery {
    enabled = true
  }

  attribute {
    name = "user_id"
    type = "S"
  }

  tags = {
    Service = var.project
  }
}
