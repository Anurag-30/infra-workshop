provider "aws" {
  region = "ap-south-1"
}

# terraform {
#   backend "s3" {
#     bucket = "tfstate"
#     key    = "/stage/terraformstate/"
#     region = "ap-south-1"
#   }
# }