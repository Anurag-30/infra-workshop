variable "public_subnets" {
  type = set(string)
}
variable "vpc_id" {
  default = ""
}

variable "application" {}

variable "environment" {}