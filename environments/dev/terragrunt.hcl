# Terragrunt configuration for dev environment

# Include common configuration from root
include "root" {
  path = find_in_parent_folders()
}

# Use generated Terraform config from Terranix
terraform {
  source = "../generated/dev"
}

# Environment-specific inputs
inputs = {
  environment = "dev"
}
