# Jellyfin media server container configuration
{
  vm_id = 203;
  ip_address = "192.168.4.203/24";
  gateway = "192.168.4.1";

  # 4 cores for transcoding
  cores = 4;
  memory = 4096;

  # Mount points
  mount_points = [
    {
      volume = "/mnt/pve/bx500/jellyfin";
      path = "/var/lib/jellyfin";
    }
    {
      volume = "/mnt/pve/bx1000/media";
      path = "/mnt/media/bx1000";
    }
    {
      volume = "/mnt/pve/hd4000/media";
      path = "/mnt/media/hd4000";
    }
  ];

  # Intel iGPU passthrough for transcoding
  device_passthrough = [
    {
      path = "/dev/dri/card1";
    }
    {
      path = "/dev/dri/renderD128";
    }
  ];

  tags = [ "jellyfin" "media" ];
}
