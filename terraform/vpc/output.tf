output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  value = aws_subnet.public.*.id
}

output "private_subnet_ids" {
  value = aws_subnet.private.*.id
}

output "availability_zones_indexes" {
  value = length(var.availability_zones)
}

output "private_subnet_arns" {
  value = aws_subnet.private.*.arn
}

output "vpc_endpoint_api_gateway" {
  value = aws_vpc_endpoint.api_gateway.id
}

output "private_subnet_lambda_sg" {
  value = aws_security_group.lambda.id
}

output "private_subnet_alb_sg" {
  value = aws_security_group.alb.id
}