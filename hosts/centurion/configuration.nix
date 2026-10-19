{ config, ... }:
{
  imports = [
    # Mostly system related configuration
    ../../home/programs/codex
    ../../system/portal.nix
    ../../system/nvidia.nix
    ../../system/audio.nix
    ../../system/docker.nix
    ../../system/bluetooth.nix
    ../../system/fonts.nix
    ../../system/home-manager.nix
    ../../system/nix.nix
    ../../system/systemd-boot.nix
    ../../system/users.nix
    ../../system/general.nix
    ../../system/virtualization.nix
    ../../system/ollama.nix
    ../../system/flatpak.nix

    ./hardware-configuration.nix
    ./variables.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  programs.happ = {
    enable = true;
    tunMode.enable = true;
  };

  # Don't touch this
  system.stateVersion = "24.05";
}
