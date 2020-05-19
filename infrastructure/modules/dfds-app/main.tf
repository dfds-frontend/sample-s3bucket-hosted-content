terraform {
  backend          "s3"             {}
  required_version = "~> 0.12.2"
}

provider "aws" { # default 
  region  = "eu-central-1"
  version = "~> 2.27.0"
}

module "aws_s3-bucket-dfds-app" {
  source = "git::https://github.com/dfds-frontend/terraform-modules.git//aws/s3-bucket?ref=v0.15.0"  
  s3_bucket = "dfds-app-${var.env}"
}