{ name, config, lib, pkgs, ... }:

with lib;

{
  options = {
    container_id = mkOption {
      type = types.int;
      description = "LXC container ID";
    };

    hostname = mkOption {
      type = types.string;
      description = "Container hostname";
      default = name;
    };

    target_node = mkOption {
      type = types.string;
      description = "Proxmox node to deploy on";
    };

    template_repo = mkOption {
      type = types.string;
      description = "GitHub repo for container template";
      default = "jagadam97/nixos-vm-builder";
    };

    template_pattern = mkOption {
      type = types.string;
      description = "Pattern to match release asset";
      example = "influxdb-v*.tar.xz";
    };

    cores = mkOption {
      type = types.int;
      default = 1;
      description = "Number of CPU cores";
    };

    memory = mkOption {
      type = types.int;
      default = 512;
      description = "Memory in MB";
    };

    storage = mkOption {
      type = types.string;
      default = "local";
      description = "Storage for rootfs";
    };

    rootfs_size = mkOption {
      type = types.string;
      default = "8G";
      description = "Root filesystem size";
    };

    network_bridge = mkOption {
      type = types.string;
      default = "vmbr0";
      description = "Network bridge";
    };

    ip_address = mkOption {
      type = types.nullOr types.string;
      default = null;
      description = "Static IP address with CIDR (e.g., 192.168.4.100/24)";
    };

    gateway = mkOption {
      type = types.nullOr types.string;
      default = null;
      description = "Gateway IP address";
    };

    mount_points = mkOption {
      type = types.listOf (types.submodule {
        options = {
          host_path = mkOption { type = types.string; };
          container_path = mkOption { type = types.string; };
        };
      });
      default = [];
      description = "Mount points from host to container";
    };

    tags = mkOption {
      type = types.listOf types.string;
      default = [];
      description = "Tags for the container";
    };
  };
}
