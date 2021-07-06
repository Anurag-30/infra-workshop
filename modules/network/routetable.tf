

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${local.APP_NAME}-private-rt"
  }
}
