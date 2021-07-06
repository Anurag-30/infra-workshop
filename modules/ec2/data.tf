data "aws_ami" "image_id" {

  owners      = ["120116087690"]
  most_recent = true

  filter {
    name   = "name"
    values = ["Centos 7*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

}


