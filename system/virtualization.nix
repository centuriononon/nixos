{ pkgs, config, ... }:
{
  virtualisation.libvirtd.enable = true;

  environment.systemPackages = with pkgs; [
    virt-manager
    qemu
  ];

  users.users."${config.var.username}".extraGroups = [ "libvirtd" "kvm" ];
}

