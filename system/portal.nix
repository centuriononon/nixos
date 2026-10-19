{ config, pkgs, lib, ... }:

{
  # Fix xdg-desktop-portal PATH issues
  services.xserver.displayManager.sessionCommands = ''
    # Import PATH and other important variables into systemd user services
    ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all
    systemctl --user import-environment PATH DISPLAY XAUTHORITY XDG_CONFIG_DIRS XDG_DATA_DIRS XDG_RUNTIME_DIR DBUS_SESSION_BUS_ADDRESS || true
  '';

  # Set default environment for all systemd user services
  systemd.user.settings.Manager.DefaultEnvironment = [
    "PATH=/run/current-system/sw/bin:/etc/profiles/per-user/%u/bin"
  ];

  environment.systemPackages = with pkgs; [
    webkitgtk_6_0
  ];
}
