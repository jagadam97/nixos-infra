{ config, lib, pkgs, ... }:

{
  # Terraform configuration
  terraform = {
    required_version = ">= 1.0.0";

    required_providers = {
      proxmox = {
        source = "bpg/proxmox";
        version = ">= 0.50.0";
      };
    };

    # Terraform Cloud backend
    cloud = {
      organization = "jagadam97";

      workspaces = {
        name = "donnager";
      };
    };
  };

  # Variables
  variable = {
    proxmox_api_url = {
      type = "string";
      description = "Proxmox API URL";
      sensitive = true;
    };

    proxmox_username = {
      type = "string";
      description = "Proxmox username (e.g., root@pam)";
      sensitive = true;
    };

    proxmox_password = {
      type = "string";
      description = "Proxmox password";
      sensitive = true;
    };
  };

  # Proxmox provider (bpg/proxmox)
  provider.proxmox = {
    endpoint = "\${var.proxmox_api_url}";
    username = "\${var.proxmox_username}";
    password = "\${var.proxmox_password}";
    insecure = true;
  };
}
