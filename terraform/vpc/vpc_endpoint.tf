resource "aws_security_group" "vpc_endpoint_private" {
  vpc_id = aws_vpc.main.id
  name   = "${var.project}-endpoint-${terraform.workspace}"

  tags = {
    Name = "${var.project}-endpoint-${terraform.workspace}"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc_endpoint" "api_gateway" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.us-east-1.execute-api"
  subnet_ids          = aws_subnet.private.*.id
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  security_group_ids = [aws_security_group.vpc_endpoint_private.id]

  tags = {
    Name = "${var.project}-api-gtw-${terraform.workspace}"
  }
}

resource "aws_vpc_endpoint" "kinesis" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.us-east-1.kinesis-streams"
  subnet_ids          = aws_subnet.private.*.id
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  security_group_ids = [aws_security_group.vpc_endpoint_private.id]

  tags = {
    Name = "${var.project}-kinesis-${terraform.workspace}"
  }
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.us-east-1.dynamodb"
  vpc_endpoint_type   = "Gateway"
  private_dns_enabled = false
  route_table_ids     = [aws_route_table.private.id]

  tags = {
    Name = "${var.project}-dynamodb-${terraform.workspace}"
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type   = "Gateway"
  private_dns_enabled = false
  route_table_ids     = [aws_route_table.private.id]

  tags = {
    Name = "${var.project}-s3-${terraform.workspace}"
  }
}

resource "aws_vpc_endpoint" "sqs" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.us-east-1.sqs"
  subnet_ids          = aws_subnet.private.*.id
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  security_group_ids = [aws_security_group.vpc_endpoint_private.id]

  tags = {
    Name = "${var.project}-sqs-${terraform.workspace}"
  }
}

resource "aws_vpc_endpoint" "sns" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.us-east-1.sns"
  subnet_ids          = aws_subnet.private.*.id
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  security_group_ids = [aws_security_group.vpc_endpoint_private.id]

  tags = {
    Name = "${var.project}-sns-${terraform.workspace}"
  }
}

resource "aws_vpc_endpoint" "lambda" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.us-east-1.lambda"
  subnet_ids          = aws_subnet.private.*.id
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  security_group_ids = [aws_security_group.vpc_endpoint_private.id]

  tags = {
    Name = "${var.project}-lambda-${terraform.workspace}"
  }
}
