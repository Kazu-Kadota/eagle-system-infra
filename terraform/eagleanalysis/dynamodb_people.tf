resource "aws_dynamodb_table" "people" {
  name         = "${var.project}-people-${terraform.workspace}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "person_id"
  range_key    = "document"

  point_in_time_recovery {
    enabled = true
  }

  attribute {
    name = "person_id"
    type = "S"
  }

  attribute {
    name = "document"
    type = "S"
  }

  global_secondary_index {
    name            = "document-index"
    hash_key        = "document"
    projection_type = "ALL"
  }

  tags = {
    Service = var.project
  }
}
