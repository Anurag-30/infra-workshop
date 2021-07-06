resource "aws_lb_target_group" "public_lb_target_group" {
  name     = "frontend-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_alb_listener" "public_lb_target_group" {
  load_balancer_arn = aws_lb.public_alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.public_lb_target_group.arn
  }
}


resource "aws_lb_target_group" "internal_lb_target_group" {
  name     = "backend-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_alb_listener" "internal_lb_target_group" {
  load_balancer_arn = aws_lb.internal_alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.internal_lb_target_group.arn
  }
}


output "frontend_target_group" {
  value = aws_lb_target_group.public_lb_target_group.arn
}

output "backend_target_group" {
  value = aws_lb_target_group.internal_lb_target_group.arn
}