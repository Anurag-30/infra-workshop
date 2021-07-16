resource "aws_instance" "database" {
  depends_on             = [aws_key_pair.ec2-keypair]
  ami                    = data.aws_ami.image_id.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.database_sg.id]
  key_name               = aws_key_pair.ec2-keypair.key_name
  user_data              = data.template_file.db.rendered
  subnet_id              = var.private_subnets[1]

  tags = {
    Name = "petclinic-${var.environment}-database"
  }

}



data "template_file" "db" {
  template = file("${path.module}/scripts/database.sh.tpl")

  vars = {
    db_user     = var.db_user
    db_password = var.db_password
    db_name     = var.db_name
  }
}


resource "aws_security_group" "database_sg" {

  name        = "database-node-sg"
  description = "Allow traffic over port 22"
  vpc_id      = var.vpc_id


  ingress {

    description = "Allow-http from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
    var.vpc_cidr_block]

  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]

  }

  tags = {
    Name = "allow_connectivity_database"
  }
}

resource "aws_security_group_rule" "example" {
  type        = "ingress"
  from_port   = 5432
  to_port     = 5432
  protocol    = "tcp"
  cidr_blocks = [var.vpc_cidr_block]

  security_group_id = aws_security_group.database_sg.id
  description       = "Allow postgresql port"
}

output "db_host" {
  value = aws_instance.database.private_ip
}
