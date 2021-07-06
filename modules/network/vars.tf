variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "number_of_public_subnets" {
  default = ""
}
variable "number_of_private_subnets" {
  default = ""
}

variable "environment" {}

variable "application" {}