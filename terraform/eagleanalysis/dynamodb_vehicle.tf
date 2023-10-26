resource "aws_dynamodb_table" "vehicles" {
  name         = "${var.project}-vehicles-${terraform.workspace}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "vehicle_id"
  range_key    = "plate"

  point_in_time_recovery {
    enabled = true
  }

  attribute {
    name = "vehicle_id"
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
    name            = "plate-index"
    hash_key        = "plate"
    range_key       = "plate_state"
    projection_type = "ALL"
  }

  tags = {
    Service = var.project
  }
}
