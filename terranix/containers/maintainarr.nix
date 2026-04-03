# Maintainarr container configuration (Bazarr, Radarr, Sonarr)
{
  vm_id = 206;
  ip_address = "192.168.4.211/24";
  gateway = "192.168.4.1";

  cores = 2;
  memory = 2048;
  storage = "bx500";
  template_file_storage = "hd4000";

  # Mount points
  # Config persisted on bx500; media storage on ssd and hdd
  mount_points = [
    {
      volume = "/mnt/pve/bx500/maintainarr";
      path = "/config";
    }
    {
      volume = "/mnt/pve/ssd";
      path = "/mnt/ssd";
    }
    {
      volume = "/mnt/pve/hdd";
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
