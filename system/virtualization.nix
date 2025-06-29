{ pkgs, ... }:
{
  virtualisation.libvirtd.enable = true;
  users.users.username.extraGroups = [
    "libvirtd"
    "kvm"
  ];
  environment.systemPackages = with pkgs; [
    virt-manager
    qemu
  ];
}
