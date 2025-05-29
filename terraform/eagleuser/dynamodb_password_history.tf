resource "aws_dynamodb_table" "password_history" {
  name         = "${var.project}-password-history-${terraform.workspace}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "user_id"
  range_key    = "created_at"
  deletion_protection_enabled = true

  point_in_time_recovery {
    enabled = true
  }

  attribute {
    name = "user_id"
    type = "S"
  }

  attribute {
    name = "created_at"
    type = "S"
  }

  tags = {
    Service = var.project
  }
}
