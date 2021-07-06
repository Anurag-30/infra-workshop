resource "aws_lb" "internal_alb" {

  name               = "backend-internal-alb"
  load_balancer_type = "application"
  internal           = true
  subnets            = [for subnet_ids in local.availability_zone_subnets : subnet_ids[0]] // pick a subnet from each availability_zone
  security_groups    = [aws_security_group.elb_security_group_http.id, aws_security_group.elb_security_group_https.id]

}