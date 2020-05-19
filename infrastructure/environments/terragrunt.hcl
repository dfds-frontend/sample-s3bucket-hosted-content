# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"

  config = {
    encrypt        = true
    bucket         = "dfds-app-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
  }
}

terraform {
  extra_arguments "common_vars" {

    commands = get_terraform_commands_that_need_vars()

    optional_var_files = [
      "${get_terragrunt_dir()}/${find_in_parent_folders("region.tfvars", "skip-region-if-does-not-exist")}",
      "${get_terragrunt_dir()}/${find_in_parent_folders("account.tfvars", "skip-account-if-does-not-exist")}"
    ]
  }
}