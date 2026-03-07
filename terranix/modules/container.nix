# Container module - creates a Proxmox LXC container with defaults
# Usage: import ./modules/container.nix { name = "mycontainer"; vm_id = 100; ...; }

{ lib
, name
, vm_id
, version
, ip_address
, gateway
, mount_points ? []
, device_passthrough ? []
, hostname ? name
, cores ? 1
, memory ? 512
, disk_size ? 8
, tags ? []
, node_name ? "donnager"
, storage ? "local-lvm"
, bridge ? "vmbr0"
, dns_servers ? [ "152.70.69.235" "1.1.1.1" "8.8.8.8" ]
, os_type ? "nixos"
, unprivileged ? true
, features ? { nesting = true; }
, template_file_storage ? "hd4000"
}:

let
  # Auto-generate template URL and filename
  template_url = "https://github.com/jagadam97/nixos-vm-builder/releases/download/${name}-${version}/${name}-${version}.tar.xz";
  template_file = "${name}-${version}.tar.xz";
in

{
  # Download template resource (stored on hd4000)
  resource.proxmox_virtual_environment_download_file."${name}_template" = {
    node_name = node_name;
    content_type = "vztmpl";
    datastore_id = template_file_storage;
    url = template_url;
    file_name = template_file;
    overwrite = false;
  };

  # Container resource
  resource.proxmox_virtual_environment_container.${name} = {
    node_name = node_name;
    vm_id = vm_id;

    # Template
    operating_system = {
      template_file_id = "\${proxmox_virtual_environment_download_file.${name}_template.id}";
      type = os_type;
    };

    # Hostname and DNS
    initialization = {
      hostname = hostname;
      dns = {
        servers = dns_servers;
      };
      ip_config = [{
        ipv4 = {
          address = ip_address;
          gateway = gateway;
        };
      }];
    };

    # Disk
    disk = {
      datastore_id = storage;
      size = disk_size;
    };

    # CPU
    cpu = {
      cores = cores;
    };

    # Memory
    memory = {
      dedicated = memory;
    };

    # Network interface
    network_interface = {
      name = "eth0";
      bridge = bridge;
      enabled = true;
    };

    # Mount points
    mount_point = mount_points;

    # Device passthrough
    device_passthrough = device_passthrough;

    # Features
    features = features;

    # Start on boot
    started = true;
    start_on_boot = true;

    # Tags
    tags = tags;

    # Privileged/unprivileged
    unprivileged = unprivileged;
  };
}
