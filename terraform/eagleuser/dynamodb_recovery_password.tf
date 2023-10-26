resource "aws_dynamodb_table" "recovery_password" {
  name         = "${var.project}-recovery-password-${terraform.workspace}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "recovery_id"

  point_in_time_recovery {
    enabled = true
  }

  attribute {
    name = "recovery_id"
    type = "S"
  }

  attribute {
    name = "email"
    type = "S"
  }

  global_secondary_index {
    name            = "email-index"
    hash_key        = "email"
    projection_type = "ALL"
  }

  tags = {
    Service = var.project
  }
}
