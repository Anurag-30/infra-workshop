provider "aws" {
  region = "ap-south-1"
}


terraform {
  backend "s3" {
    bucket = "petclinic"
    key = "state"
    region = "ap-south-1"
  }
}