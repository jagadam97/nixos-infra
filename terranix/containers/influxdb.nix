# InfluxDB container configuration
{
  vm_id = 204;
  ip_address = "192.168.4.248/24";
  gateway = "192.168.4.1";

  # Mount points
  mount_points = [
    {
      volume = "/mnt/pve/bx500/influxdb/data";
      path = "/var/lib/influxdb2";
    }
    {
      volume = "/mnt/pve/bx500/influxdb/config";
      path = "/etc/influxdb2";
    }
  ];

  # Custom values (defaults: cores=1, memory=512, disk_size=8)
  memory = 768;
  disk_size = 4;
  storage = "bx500";
  tags = [ "influxdb" "monitoring" "database" ];
}
