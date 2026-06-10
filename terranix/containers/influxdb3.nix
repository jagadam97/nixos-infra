# InfluxDB 3 container configuration
{
  vm_id = 206;
  ip_address = "192.168.4.249/24";
  gateway = "192.168.4.1";

  # Mount points
  mount_points = [
    {
      volume = "/mnt/pve/bx500/influxdb3/data";
      path = "/var/lib/influxdb3";
    }
    {
      volume = "/mnt/pve/bx500/influxdb3/config";
      path = "/etc/influxdb3";
    }
  ];

  # Custom values (defaults: cores=1, memory=512, disk_size=8)
  memory = 768;
  disk_size = 4;
  # storage = "bx500";
  tags = [ "influxdb3" "monitoring" "database" ];
}
