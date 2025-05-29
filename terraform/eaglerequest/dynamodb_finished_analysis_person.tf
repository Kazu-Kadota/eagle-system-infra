resource "aws_dynamodb_table" "finished_analysis_person" {
  name         = "${var.project}-finished-analysis-person-${terraform.workspace}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "request_id"
  range_key    = "person_id"
  deletion_protection_enabled = true

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
    name = "company_name"
    type = "S"
  }

  attribute {
    name = "document"
    type = "S"
  }

  global_secondary_index {
    name            = "company-name-index"
    hash_key        = "company_name"
    projection_type = "ALL"
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
