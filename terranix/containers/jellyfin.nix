# Jellyfin media server container configuration
{
  vm_id = 203;
  ip_address = "192.168.4.203/24";
  gateway = "192.168.4.1";
  ssh_host = "192.168.4.240";
  ssh_user = "root";

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
  lxc_config = ''
lxc.cgroup2.devices.allow: c 226:0 rwm
lxc.cgroup2.devices.allow: c 226:128 rwm
lxc.mount.entry: /dev/dri/card1 dev/dri/card1 none bind,optional,create=file
lxc.mount.entry: /dev/dri/renderD128 dev/dri/renderD128 none bind,optional,create=file
'';

  tags = [ "jellyfin" "media" ];
}
