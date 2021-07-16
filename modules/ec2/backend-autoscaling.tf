
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
  user_data              = base64encode(data.template_file.backend.rendered)
  tags = {
    Name = "${var.application}-backend-${var.environment}"
  }
}

data "template_file" "backend" {
  template = file("${path.module}/scripts/backend.sh.tpl")

  vars = {
    DB_USERNAME = var.db_user
    DB_PASSWORD = var.db_password
    DB_NAME     = var.db_name
    DB_HOST     = aws_instance.database.private_ip
  }
}

resource "aws_autoscaling_group" "backend_autoscaling_grp" {
  name                      = "${var.application}-backend-${var.environment}"
  vpc_zone_identifier       = var.private_subnets
  max_size                  = var.max_instance_count
  min_size                  = var.min_instance_count
  target_group_arns         = var.backend_targetgrp_arn
  health_check_type         = "ELB"
  health_check_grace_period = "20"
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