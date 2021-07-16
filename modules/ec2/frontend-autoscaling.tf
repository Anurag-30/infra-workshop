resource "aws_launch_template" "frontend_tmplate" {

  name = "${var.application}-frontend-${var.environment}"


  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ec2-keypair.key_name
  image_id               = data.aws_ami.frontend.id
  vpc_security_group_ids = [aws_security_group.frontend_security_group_http.id]
  user_data              = base64encode(data.template_file.frontend.rendered)

  tags = {
    Name = "${var.application}-frontend-${var.environment}"
  }
}


data "template_file" "frontend" {
  template = file("${path.module}/scripts/frontend.sh.tpl")

  vars = {
    BACKEND_LB_URL = var.backend_lb_url
  }
}


resource "aws_autoscaling_group" "frontend_autoscaling_grp" {
  name                = "${var.application}-frontend-${var.environment}"
  vpc_zone_identifier = var.private_subnets
  max_size            = var.max_instance_count
  min_size            = var.min_instance_count
  target_group_arns   = ["${var.frontend_targetgrp_arn}"]

  launch_template {
    id      = aws_launch_template.frontend_tmplate.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "${var.application}-frontend-${var.environment}"
    propagate_at_launch = true
  }
}