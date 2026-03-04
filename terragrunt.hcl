# Terragrunt configuration

# Generate Terraform config from Terranix before running
terraform {
  source = "."

  before_hook "generate" {
    commands = ["init", "plan", "apply", "destroy"]
    execute  = ["nix", "run", ".#generate"]
  }
}

# Inputs passed to Terraform
inputs = {
  # Variables should be set via environment variables or tfvars
  # proxmox_api_url    = "https://192.168.4.1:8006/api2/json"
  # proxmox_api_token  = "..."
}
