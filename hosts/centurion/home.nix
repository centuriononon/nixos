{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./variables.nix

    ../../home/programs/git
    ../../home/programs/kitty
    ../../home/programs/lazygit
    ../../home/programs/shell
    ../../home/programs/spicetify
    ../../home/programs/thunar
    ../../home/programs/udiskie
    ../../home/programs/zathura

    ../../home/desktop/mime
    ../../home/desktop/sxhkd
    ../../home/desktop/bspwm
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    packages = with pkgs; [
      # Apps
      neovim # Neovim text-editor
      zed-editor # IDE
      keepassxc # Password manager
      telegram-desktop # Messenger telegram
      vlc # Video player
      blanket # White-noise app
      gnome-calendar # Calendar
      textpieces # Manipulate texts
      curtail # Compress images
      resources
      gnome-clocks
      gnome-text-editor
      mpv # Video player

      # Dev
      postgresql
      redis
      postman
      go
      nodejs
      python3
      elixir
      erlang
      just
      pnpm
      flyctl

      # Utils
      scrcpy
      calc
      television # Fuzzy search for Zed Editor
      zip
      unzip
      optipng
      jpegoptim
      htop
      btop
      docker-compose
      alsa-utils
      xdotool
      xclip

      # Backup
      brave
      vscode
    ];

    # Don't touch this
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
