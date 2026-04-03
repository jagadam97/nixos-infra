# qBittorrent container configuration
{
  vm_id = 205;
  ip_address = "192.168.4.212/24";
  gateway = "192.168.4.1";

  cores = 2;
  memory = 2048;
  # storage = "local-lvm";  # Use default
  # template_file_storage = "hd4000";  # Use default

  # Mount points
  # Config/state is persisted on bx500; downloads are on bx1000 and hd4000
  mount_points = [
    {
      volume = "/mnt/pve/bx500/qbittorrent";
      path = "/var/lib/qbittorrent";
    }
    {
      volume = "/mnt/pve/bx1000/downloads";
      path = "/mnt/ssd/downloads";
    }
    {
      volume = "/mnt/pve/hd4000/downloads";
      path = "/mnt/hdd/downloads";
    }
  ];

  tags = [
    "qbittorrent"
    "downloads"
    "media"
  ];
}
