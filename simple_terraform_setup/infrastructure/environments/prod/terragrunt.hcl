# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
    source = "git::https://github.com/dfds-frontend/terraform-modules.git//aws/s3-bucket?ref=v0.15.0"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# vars
inputs = {
  s3_bucket = "simple-dfds-app-prod"
}