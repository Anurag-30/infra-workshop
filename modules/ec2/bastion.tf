resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.image_id.id
  instance_type               = "t2.medium"
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  subnet_id                   = var.public_subnets[0]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ec2-keypair.key_name
  tags = {
    Name = "Bastion"
  }
}

resource "aws_security_group" "bastion" {
  name        = "bastion-node-sg"
  description = "Allow traffic over port 22"
  vpc_id      = var.vpc_id

  ingress {

    description = "Allow-http from public"
    from_port   = 0
    to_port     = 22
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
    Name = "allow_ssh_access"
  }
}