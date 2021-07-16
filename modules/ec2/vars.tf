variable "instance_type" {
  default = "t2.micro"
}

variable "backend_targetgrp_arn" {
  default = ""
}

variable "frontend_targetgrp_arn" {
  default = ""

}
variable "vpc_id" {
  default = ""
}

variable "private_subnets" {
  default = ""
}

variable "public_subnets" {
  default = ""
}

variable "environment" {
  default = ""
}

variable "application" {
  default = "petclinic"
}

variable "vpc_cidr_block" {
  default = ""
}

variable "db_user" {
  description = "Username for the database"
  sensitive   = true
}
variable "db_password" {

  description = "Password for the database"
  sensitive   = true

}
variable "db_name" {
  description = "Database name to create"
  sensitive   = true
}

variable "backend_lb_url" {
  default = ""
}