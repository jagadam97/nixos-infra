# Root Terragrunt configuration
# Common settings for all environments

# Remote state configuration via Terraform Cloud
# The actual backend config is in the Terranix-generated main.tf.json

# Generate Terraform configs from Terranix before running
dependency "terranix" {
  config_path = ".."

  # Trigger Terranix generation
  mock_outputs = {
    # Will be replaced by actual outputs
  }
}

# Common inputs for all environments
inputs = {
  # These should be set in Terraform Cloud workspace variables
  # proxmox_api_url      = "https://192.168.4.1:8006/api2/json"
  # proxmox_token_id     = "root@pam!terraform"
  # proxmox_token_secret = "xxx"
}

# Hooks to generate Terraform configs before running
terraform {
  before_hook "generate_configs" {
    commands = ["init", "plan", "apply", "destroy"]
    execute  = ["nix", "run", ".#generate"]
  }

  extra_arguments "auto_approve" {
    commands  = ["apply"]
    arguments = ["-auto-approve"]
  }
}
