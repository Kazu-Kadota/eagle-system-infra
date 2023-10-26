output "dynamodb_people_arn" {
  value = aws_dynamodb_table.people.arn
}

output "dynamodb_people_name" {
  value = aws_dynamodb_table.people.name
}

output "dynamodb_vehicles_arn" {
  value = aws_dynamodb_table.vehicles.arn
}

output "dynamodb_vehicles_name" {
  value = aws_dynamodb_table.vehicles.name
}
