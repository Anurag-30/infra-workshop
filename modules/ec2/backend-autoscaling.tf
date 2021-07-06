resource "aws_launch_template" "backend_tmplate" {

  name = "backend-template"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }
  instance_type = "t2.micro"
  key_name = aws_key_pair.ec2-keypair.key_name
  image_id = data.aws_ami.image_id.id
  vpc_security_group_ids = [aws_security_group.backend_security_group_http.id]
}


resource "aws_autoscaling_group" "backend_autoscaling_grp" {
  name= "backend-asg"
  availability_zones = [data.aws_availability_zones.az.names[0]]
  max_size = 1
  min_size = 1
  target_group_arns= var.backend_targetgrp_arn
  launch_template {
    id = aws_launch_template.backend_tmplate.id
    version = "$Latest"
  }
}