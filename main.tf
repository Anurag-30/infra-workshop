
module "vpc" {
  source                    = "./modules/network"
  vpc_cidr_block            = var.vpc_cidr_block
  number_of_private_subnets = var.number_of_private_subnets
  number_of_public_subnets  = var.number_of_public_subnets
  environment               = var.environment
  application               = var.application
}

module "lb" {
  depends_on     = [module.vpc]
  source         = "./modules/loadbalancers"
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  environment    = var.environment
  application    = var.application
}


module "ec2" {
  source                 = "./modules/ec2"
  backend_targetgrp_arn  = ["${module.lb.backend_target_group}"]
  frontend_targetgrp_arn = module.lb.frontend_target_group
  instance_type          = var.instance_type
  vpc_id                 = module.vpc.vpc_id
  public_subnets         = module.vpc.public_subnets
  private_subnets        = module.vpc.private_subnets
  environment            = var.environment
  db_name                = var.db_name
  db_password            = var.db_password
  db_user                = var.db_user
  vpc_cidr_block         = var.vpc_cidr_block
  backend_lb_url         = module.lb.backend_lb
  max_instance_count     = var.max_instance_count
  min_instance_count     = var.min_instance_count

}

output "frontend_alb" {
  value = module.lb.frontend_alb
}

output "backend_alb" {
  value = module.lb.backend_lb
}

output "bastion_ip" {

  value = module.ec2.bastion_ip


}