resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "${var.project}-private-rt-${terraform.workspace}"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.project}-nat-gw-eip-${terraform.workspace}"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = element(aws_subnet.public.*.id, 0)

  tags = {
    Name = "${var.project}-${terraform.workspace}"
  }
}

resource "aws_route" "nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_subnet" "private" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(local.cidr_block, var.subnet_size, count.index + 10)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.project}-private-${count.index + 1}-${terraform.workspace}"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}
