# Terragrunt configuration for prod environment

# Include common configuration from root
include "root" {
  path = find_in_parent_folders()
}

# Use generated Terraform config from Terranix
terraform {
  source = "../generated/prod"
}

# Environment-specific inputs
inputs = {
  environment = "prod"
}
