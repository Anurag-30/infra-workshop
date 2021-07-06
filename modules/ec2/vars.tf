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