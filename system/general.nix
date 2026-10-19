{
  pkgs,
  config,
  ...
}:
let
  hostname = config.var.hostname;
  configDir = config.var.configDirectory;
  timeZone = config.var.timeZone;
  keyboardLayout = config.var.keyboardLayout;
  defaultLocale = config.var.defaultLocale;
  extraLocale = config.var.extraLocale;
  autoUpgrade = config.var.autoUpgrade;
in
{
  #
  # Networking
  #

  networking.hostName = hostname;

  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  # Wi-Fi backend
  networking.networkmanager.wifi.backend = "iwd";
  networking.wireless.iwd.enable = true;

  # DNS
  services.resolved.enable = true;
  networking.networkmanager.dns = "systemd-resolved";
  networking.resolvconf.enable = false;

  # Disable connectivity checks
  networking.networkmanager.settings = {
    connectivity = {
      enabled = false;
    };
  };

  #
  # System upgrades
  #

  system.autoUpgrade = {
    enable = autoUpgrade;
    dates = "04:00";
    persistent = true;
    randomizedDelaySec = "30min";
    fixedRandomDelay = true;
    operation = "boot";
    flake = "${configDir}#${hostname}";
    flags = [
      "--update-input"
      "nixpkgs"
    ];
    allowReboot = false;
  };

  #
  # Time & locale
  #

  time.timeZone = timeZone;

  i18n.defaultLocale = defaultLocale;
  i18n.extraLocaleSettings = {
    LC_ALL = extraLocale;
  };

  #
  # Journald / logging
  #

  services.journald.settings.Journal = {
    # Do NOT persist logs across reboots.
    # Fixes slow boot caused by corrupted /var/log/journal
    Storage = "volatile";

    # Safety limits (still apply to runtime journal)
    RuntimeMaxUse = "50M";
    RateLimitIntervalSec = "0";
    RateLimitBurst = "0";
  };

  # If you ever want persistent logs again, use instead:
  #
  # services.journald.extraConfig = ''
  #   Storage=persistent
  #   SystemMaxUse=200M
  #   RuntimeMaxUse=50M
  #   MaxFileSec=1day
  #   Compress=yes
  # '';

  #
  # Display (X11, WM, DM) & input
  #

  services.xserver = {
    enable = true;

    windowManager.bspwm.enable = true;
    displayManager.lightdm.enable = true;

    exportConfiguration = true;

    xkb = {
      layout = keyboardLayout;
      options = "grp:alt_space_toggle";
    };

    # Keyboard repeat rate
    autoRepeatDelay = 260;
    autoRepeatInterval = 40;
  };

  console.keyMap = "us";
  services.libinput.enable = true;

  #
  # Desktop services
  #

  services.xscreensaver.enable = true;
  programs.dconf.enable = true;

  services.gnome.gnome-keyring.enable = true;

  services.psd = {
    enable = true;
    resyncTimer = "10m";
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;

    config = {
      common.default = [ "gtk" ];
    };

    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.dbus = {
    enable = true;
    implementation = "broker";
    packages = with pkgs; [
      gcr_4
      gnome-settings-daemon
    ];
  };

  #
  # Power management
  #

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  systemd.sleep.settings.Sleep = {
    AllowSuspend = "no";
    AllowHibernation = "no";
    AllowHybridSleep = "no";
    AllowSuspendThenHibernate = "no";
  };

  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
  };

  #
  # Storage / removable media
  #

  services.udisks2.enable = true;

  #
  # Nix / developer ergonomics
  #

  programs.nix-ld.enable = true;
  environment.pathsToLink = [ "/share/zsh" ];

  #
  # Docs (leaner rebuilds)
  #

  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
    info.enable = false;
    nixos.enable = false;
  };

  #
  # Environment variables
  #

  environment.variables = {
    XDG_DATA_HOME = "$HOME/.local/share";
    PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
    EDITOR = "nvim";
    TERMINAL = "kitty";
    TERM = "kitty";
    BROWSER = "zen-beta";
  };

  #
  # Packages
  #

  environment.systemPackages = with pkgs; [
    xscreensaver
    sxhkd
    polybar
    picom
    fd
    bc
    gcc
    git-ignore
    xdg-utils
    wget
    curl
    vim
    remmina
    freerdp
  ];

  #
  # Security
  #

  security = {
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
    polkit.enable = true;
  };


  services.openssh.enable = true;
}
