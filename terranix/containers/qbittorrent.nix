# qBittorrent container configuration
{
  vm_id = 205;
  ip_address = "192.168.4.212/24";
  gateway = "192.168.4.1";

  cores = 2;
  memory = 2048;
  storage = "bx500";
  template_file_storage = "bx500";

  # Mount points
  # Config/state is persisted on bx500; downloads are on bx1000 and hd4000
  mount_points = [
    {
      volume = "/mnt/pve/bx500/qbittorrent";
      path = "/var/lib/qbittorrent";
    }
    {
      volume = "/mnt/pve/bx1000/downloads";
      path = "/mnt/bx1000/downloads";
    }
    {
      volume = "/mnt/pve/hd4000/downloads";
      path = "/mnt/hd4000/downloads";
    }
  ];

  tags = [
    "qbittorrent"
    "downloads"
    "media"
  ];
}
