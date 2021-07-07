variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "number_of_public_subnets" {
  default = "2"
}
variable "number_of_private_subnets" {
  default = "2"
}

variable "environment" {
  default = "stage"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "application" {
  default = "petclinic"
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