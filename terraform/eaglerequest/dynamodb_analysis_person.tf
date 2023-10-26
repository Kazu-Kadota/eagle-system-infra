resource "aws_dynamodb_table" "analysis_person" {
  name         = "${var.project}-analysis-person-${terraform.workspace}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "request_id"
  range_key    = "person_id"

  point_in_time_recovery {
    enabled = true
  }

  attribute {
    name = "request_id"
    type = "S"
  }

  attribute {
    name = "person_id"
    type = "S"
  }

  attribute {
    name = "rg"
    type = "S"
  }

  attribute {
    name = "document"
    type = "S"
  }

  attribute {
    name = "company_name"
    type = "S"
  }

  global_secondary_index {
    name            = "company-name-index"
    hash_key        = "company_name"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "rg-index"
    hash_key        = "rg"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "document-index"
    hash_key        = "document"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "person-id-index"
    hash_key        = "person_id"
    projection_type = "ALL"
  }

  tags = {
    Service = var.project
  }
}
