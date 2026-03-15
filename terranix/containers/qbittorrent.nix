# qBittorrent container configuration
{
  vm_id = 205;
  ip_address = "192.168.4.212/24";
  gateway = "192.168.4.1";

  cores = 2;
  memory = 2048;

  # Mount points
  # Config/state is persisted on bx500; full disks mounted for flexible download paths
  mount_points = [
    {
      volume = "/mnt/pve/bx500/qbittorrent";
      path = "/var/lib/qbittorrent";
    }
    {
      volume = "/mnt/pve/bx1000";
      path = "/mnt/bx1000";
    }
    {
      volume = "/mnt/pve/hd4000";
      path = "/mnt/hd4000";
    }
  ];

  tags = [
    "qbittorrent"
    "downloads"
    "media"
  ];
}
