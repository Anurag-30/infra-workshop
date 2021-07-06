
resource "aws_launch_template" "backend_tmplate" {

  name = "${var.application}-backend-${var.environment}"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ec2-keypair.key_name
  image_id               = data.aws_ami.image_id.id
  vpc_security_group_ids = [aws_security_group.backend_security_group_http.id]
  tags = {
    Name = "${var.application}-backend-${var.environment}"
  }
}



resource "aws_autoscaling_group" "backend_autoscaling_grp" {
  name                = "${var.application}-backend-${var.environment}"
  vpc_zone_identifier = var.private_subnets
  max_size            = 1
  min_size            = 1
  target_group_arns   = var.backend_targetgrp_arn
  launch_template {
    id      = aws_launch_template.backend_tmplate.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "${var.application}-backend-${var.environment}"
    propagate_at_launch = true
  }

}