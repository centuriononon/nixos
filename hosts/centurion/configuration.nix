{ config, ... }:
{
  imports = [
    # Mostly system related configuration
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
    ../../system/ollama.nix

    ./hardware-configuration.nix
    ./variables.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  # Don't touch this
  system.stateVersion = "24.05";
}
