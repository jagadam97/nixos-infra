# Maintainarr container configuration (Bazarr, Radarr, Sonarr)
{
  vm_id = 206;
  ip_address = "192.168.4.211/24";
  gateway = "192.168.4.1";

  cores = 2;
  memory = 2048;
  storage = "bx500";  # Use default
  # template_file_storage = "bx500";

  # Mount points
  # Config persisted on bx500; media storage on bx1000 (ssd) and hd4000 (hdd)
  mount_points = [
    {
      volume = "/mnt/pve/bx500/maintainarr";
      path = "/config";
    }
    {
      volume = "/mnt/pve/bx1000";
      path = "/mnt/ssd";
    }
    {
      volume = "/mnt/pve/hd4000";
      path = "/mnt/hdd";
    }
  ];

  tags = [
    "maintainarr"
    "bazarr"
    "radarr"
    "sonarr"
    "media"
    "arr"
  ];
}
