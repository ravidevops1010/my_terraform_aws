#terraform {
#  backend "s3" {
#    bucket          = "terraform-s3-1.2.0"
#    key             = "tfstate/terraform.tfstate"
#   region          = "us-east-2"
#   dynamodb_table  = "terraformstate"
# }
#}

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA5GDEM7WAWORYGT22"
  secret_key = "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"
}