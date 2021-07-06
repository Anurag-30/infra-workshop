resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${local.APP_NAME}-VPC"
  }
}

output "vpc_id" {
  value = aws_vpc.main_vpc.id
}
