resource "aws_dynamodb_table" "synthesis" {
  name         = "${var.project}-synthesis-${terraform.workspace}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "request_id"
  range_key    = "synthesis_id"

  point_in_time_recovery {
    enabled = true
  }

  attribute {
    name = "request_id"
    type = "S"
  }

  attribute {
    name = "synthesis_id"
    type = "S"
  }

  attribute {
    name = "company_name"
    type = "S"
  }

  global_secondary_index {
    name            = "synthesis-id-index"
    hash_key        = "synthesis_id"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "company-name-index"
    hash_key        = "company_name"
    projection_type = "ALL"
  }

  tags = {
    Service = var.project
  }
}
