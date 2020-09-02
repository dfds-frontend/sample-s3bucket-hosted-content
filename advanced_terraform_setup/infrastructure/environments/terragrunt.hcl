# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"

  config = {
    encrypt        = true
    bucket         = "advanced-dfds-app-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
    terraform {  
      backend "s3" {}
      required_version = "~> 0.12.2"
    }
    provider "aws" {
      region  = "eu-central-1"
      version = "~> 2.27.0"
    }
EOF
}