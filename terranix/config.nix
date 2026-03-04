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

    proxmox_api_token = {
      type = "string";
      description = "Proxmox API token";
      sensitive = true;
    };
  };

  # Proxmox provider (bpg/proxmox)
  provider.proxmox = {
    endpoint = "\${var.proxmox_api_url}";
    api_token = "\${var.proxmox_api_token}";
    insecure = true; # Set to false with proper certs
  };
}
