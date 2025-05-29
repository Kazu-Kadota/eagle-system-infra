output "dynamodb_analysis_person_arn" {
  value = aws_dynamodb_table.analysis_person.arn
}

output "dynamodb_analysis_person_name" {
  value = aws_dynamodb_table.analysis_person.name
}

output "dynamodb_analysis_vehicle_arn" {
  value = aws_dynamodb_table.analysis_vehicle.arn
}

output "dynamodb_analysis_vehicle_name" {
  value = aws_dynamodb_table.analysis_vehicle.name
}

output "dynamodb_finished_analysis_person_arn" {
  value = aws_dynamodb_table.finished_analysis_person.arn
}

output "dynamodb_finished_analysis_person_name" {
  value = aws_dynamodb_table.finished_analysis_person.name
}

output "dynamodb_finished_analysis_vehicle_arn" {
  value = aws_dynamodb_table.finished_analysis_vehicle.arn
}

output "dynamodb_finished_analysis_vehicle_name" {
  value = aws_dynamodb_table.finished_analysis_vehicle.name
}

output "dynamodb_synthesis_arn" {
  value = aws_dynamodb_table.synthesis.arn
}

output "dynamodb_synthesis_name" {
  value = aws_dynamodb_table.synthesis.name
}