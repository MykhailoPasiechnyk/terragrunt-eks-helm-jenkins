
# Generate _backend.tf file with remote state configuration
remote_state {
  backend  = "s3"
  generate = {
    path      = "_backend.tf"
    if_exists = "overwrite"
  }

  config = {
    bucket  = "test-terragrunt-state-bucket" # set your bucket name
    region  = "eu-central-1"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    encrypt = true
  }
}

# Generate providers.tf file with provider configuration
generate "provider" {
  path = "_provider.tf"
  if_exists = "overwrite"

  contents = <<EOF
provider "aws" {
  region = var.aws_region
}

variable "aws_region" {}
EOF
}

# Load Variables
terraform {
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()

    required_var_files = [find_in_parent_folders("common.tfvars"),]
  }
}

