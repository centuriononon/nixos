{
  config,
  lib,
  ...
}: {
  imports = [../../themes/nixy.nix];

  config.var = {
    hostname = "nixy";
    username = "centurion";
    configDirectory =
      "/home/"
      + config.var.username
      + "/.config/nixos"; # The path of the nixos configuration directory

    keyboardLayout = "us,ru";
    location = "Brazil";
    timeZone = "Etc/GMT+3";
    defaultLocale = "en_US.UTF-8";
    extraLocale = "en_US.UTF-8";
    git = {
      username = "centurion";
      email = "centurionoff.dev@proton.me";
    };

    autoUpgrade = false;
    autoGarbageCollector = true;
  };

  # Let this here
  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };
}
