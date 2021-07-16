resource "aws_lb_target_group" "public_lb_target_group" {
  name     = "${var.application}-frontend-${var.environment}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path = "/petclinic/welcome"
  }

}

resource "aws_alb_listener" "public_lb_target_group" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_lb_target_group.arn
  }
}


resource "aws_lb_target_group" "internal_lb_target_group" {
  name     = "${var.application}-backend-${var.environment}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path = "/petclinic/swagger-ui.html"
  }
}

resource "aws_alb_listener" "internal_lb_target_group" {
  load_balancer_arn = aws_lb.internal_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.internal_lb_target_group.arn
  }
}


output "frontend_target_group" {
  value = tostring(aws_lb_target_group.public_lb_target_group.arn)
}

output "backend_target_group" {
  value = tostring(aws_lb_target_group.internal_lb_target_group.arn)
}