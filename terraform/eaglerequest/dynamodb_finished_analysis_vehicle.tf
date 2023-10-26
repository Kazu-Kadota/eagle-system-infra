resource "aws_dynamodb_table" "finished_analysis_vehicle" {
  name         = "${var.project}-finished-analysis-vehicle-${terraform.workspace}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "request_id"
  range_key    = "vehicle_id"

  point_in_time_recovery {
    enabled = true
  }

  attribute {
    name = "request_id"
    type = "S"
  }

  attribute {
    name = "vehicle_id"
    type = "S"
  }

  attribute {
    name = "company_name"
    type = "S"
  }

  attribute {
    name = "plate"
    type = "S"
  }

  attribute {
    name = "plate_state"
    type = "S"
  }

  global_secondary_index {
    name            = "company-name-index"
    hash_key        = "company_name"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "plate-index"
    hash_key        = "plate"
    range_key       = "plate_state"
    projection_type = "ALL"
  }

  tags = {
    Service = var.project
  }
}
