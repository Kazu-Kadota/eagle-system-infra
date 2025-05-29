resource "aws_dynamodb_table" "feature_flag_bff" {
  name         = "${var.project}-feature-flag-bff-${terraform.workspace}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "feature_flag"
  deletion_protection_enabled = true

  point_in_time_recovery {
    enabled = true
  }

  attribute {
    name = "feature_flag"
    type = "S"
  }

  tags = {
    Service = var.project
  }
}
