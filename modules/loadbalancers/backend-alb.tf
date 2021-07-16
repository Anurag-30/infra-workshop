resource "aws_lb" "internal_alb" {

  name               = "${var.application}-backend-${var.environment}"
  load_balancer_type = "application"
  subnets            = [for subnet_ids in local.availability_zone_subnets : subnet_ids[0]] // pick a subnet from each availability_zone
  security_groups    = [aws_security_group.elb_security_group_http.id, aws_security_group.elb_security_group_https.id]

}

output "backend_lb" {
  value = aws_lb.internal_alb.dns_name
}