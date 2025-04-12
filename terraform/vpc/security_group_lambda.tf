resource "aws_security_group" "lambda" {
  name   = "${var.project}-lambda-${terraform.workspace}"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project}-lambda-${terraform.workspace}"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
