{ config, lib, pkgs, ... }:

{
  # Proxmox node
  variable.proxmox_node = {
    type = "string";
    default = "donnager";
  };

  # Storage
  variable.storage.default = "bx500";

  # Download container template from GitHub Releases
  resource.proxmox_virtual_environment_download_file.influxdb_template = {
    node_name = "\${var.proxmox_node}";
    content_type = "vztmpl";
    datastore_id = "local";
    url = "https://github.com/jagadam97/nixos-vm-builder/releases/download/influxdb-v2.7.12/influxdb-v2.7.12.tar.xz";
    file_name = "influxdb-v2.7.12.tar.xz";
    overwrite = false;
  };

  # InfluxDB container
  resource.proxmox_virtual_environment_container.influxdb = {
    node_name = "\${var.proxmox_node}";
    vm_id = 204;

    # Template
    operating_system = {
      template_file_id = "\${proxmox_virtual_environment_download_file.influxdb_template.id}";
      type = "nixos";
    };

    # Hostname and DNS
    initialization = {
      hostname = "influxdb";
      dns = {
        servers = [ "8.8.8.8" "1.1.1.1" ];
      };
      ip_config = [{
        ipv4 = {
          address = "192.168.4.248/24";
          gateway = "192.168.4.1";
        };
      }];
    };

    # Disk
    disk = {
      datastore_id = "\${var.storage}";
      size = 8;
    };

    # CPU
    cpu = {
      cores = 1;
    };

    # Memory
    memory = {
      dedicated = 712;
    };

    # Network interface
    network_interface = {
      name = "eth0";
      bridge = "vmbr0";
      enabled = true;
    };

    # Mount points
    mount_point = [
      {
        volume = "\${var.storage}";
        path = "/var/lib/influxdb2";
        size = "10G";
      }
      {
        volume = "\${var.storage}";
        path = "/etc/influxdb2";
        size = "1G";
      }
    ];

    # Features
    features = {
      nesting = true;
    };

    # Start on boot
    started = true;
    start_on_boot = true;

    # Tags
    tags = [ "influxdb" "monitoring" "test" ];

    # Unprivileged container
    unprivileged = true;
  };
}
