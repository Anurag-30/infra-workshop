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