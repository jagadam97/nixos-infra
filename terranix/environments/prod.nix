{ config, lib, pkgs, ... }:

{
  # Set environment variable
  variable.environment.default = "prod";

  # Proxmox node for prod environment
  variable.proxmox_node = {
    type = "string";
    default = "donnager";
  };

  # Storage for prod
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

  # InfluxDB container (production)
  resource.proxmox_virtual_environment_container.influxdb = {
    node_name = "\${var.proxmox_node}";
    vm_id = 10;
    hostname = "influxdb-prod";

    # Use downloaded template
    template_file_id = "\${proxmox_virtual_environment_download_file.influxdb_template.id}";

    # Disk
    disk = {
      datastore_id = "\${var.storage}";
      size = 16;
    };

    # CPU and memory (more resources for prod)
    cpu = {
      cores = 2;
    };

    memory = {
      dedicated = 1024;
    };

    # Network
    network_interface = {
      name = "eth0";
      bridge = "vmbr0";
      ipv4_address = "192.168.4.10/24";
      ipv4_gateway = "192.168.4.1";
    };

    # Mount points
    mount_point = [
      {
        volume = "\${var.storage}";
        path = "/var/lib/influxdb2";
        size = "50G";
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
    tags = [ "prod" "influxdb" "monitoring" ];
  };
}
