resource "aws_security_group" "frontend_security_group_http" {
  name        = "${var.application}-frontend-${var.environment}"
  description = "Allow traffic over port 80"
  vpc_id      = var.vpc_id

  ingress {

    description = "Allow-http from public"
    from_port   = 0
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"
    ]

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

resource "aws_security_group" "backend_security_group_http" {
  name        = "${var.application}-backend-${var.environment}"
  description = "Allow traffic over port 80"
  vpc_id      = var.vpc_id

  ingress {

    description = "Allow-http from public"
    from_port   = 0
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"
    ]

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