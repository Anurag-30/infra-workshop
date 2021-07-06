data "aws_availability_zones" "azs" {
  state = "available"
}


data "aws_subnet" "public" { // create Map of subnet_id's and corresponding attributes
  for_each = var.public_subnets
  id       = each.value
}


locals { // create a map with availability zones and corresponding subnets_id's
  availability_zone_subnets = {
    for s in data.aws_subnet.public : s.availability_zone => s.id...
  }
}

resource "aws_lb" "public_alb" {

  name               = "frontend-alb"
  load_balancer_type = "application"
  subnets            = [for subnet_ids in local.availability_zone_subnets : subnet_ids[0]] // pick a subnet from each availability_zone
  security_groups    = [aws_security_group.elb_security_group_http.id, aws_security_group.elb_security_group_https.id]

}


resource "aws_security_group" "elb_security_group_http" {
  name        = "petclinic-allow_http_access"
  description = "Allow traffic over port 80"
  vpc_id      = var.vpc_id

  ingress {

    description = "Allow-http from public"
    from_port   = 0
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]

  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]

  }

  tags = {
    Name = "allow_http_access"
  }
}

resource "aws_security_group" "elb_security_group_https" {
  name        = "petclinic-allow_https_access"
  description = "Allow traffic over port 443"
  vpc_id      = var.vpc_id

  ingress {

    description = "Allow-http from public"
    from_port   = 0
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }



  tags = {
    Name = "allow_http_access"
  }

}