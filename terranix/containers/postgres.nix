# PostgreSQL 17 + TimescaleDB container configuration
{
  vm_id = 205;
  ip_address = "192.168.4.218/24";
  gateway = "192.168.4.1";

  cores = 2;
  memory = 1024;
  disk_size = 8;
  storage = "hd4000";
  template_file_storage = "bx500";

  # Attached data disk — mount your dedicated disk on the Proxmox host
  # at /mnt/pve/bx500/postgres/data before deploying
  mount_points = [
    {
      volume = "/mnt/pve/bx500/postgres/data";
      path = "/var/lib/postgresql";
    }
  ];

  tags = [ "postgres" "timescaledb" "database" "riglab" ];
}
