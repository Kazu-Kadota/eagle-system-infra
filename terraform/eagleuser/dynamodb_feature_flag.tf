resource "aws_dynamodb_table" "feature_flag" {
  name         = "${var.project}-feature-flag-${terraform.workspace}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "company_id"
  range_key    = "feature_flag"

  point_in_time_recovery {
    enabled = true
  }

  attribute {
    name = "company_id"
    type = "S"
  }

  attribute {
    name = "feature_flag"
    type = "S"
  }

  tags = {
    Service = var.project
  }
}
