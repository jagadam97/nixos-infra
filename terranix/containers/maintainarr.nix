# Maintainarr container configuration (Bazarr, Radarr, Sonarr)
{
  vm_id = 201;
  ip_address = "192.168.4.211/24";
  gateway = "192.168.4.1";

  cores = 2;
  memory = 1230;

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
