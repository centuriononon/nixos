{
  pkgs,
  config,
  ...
}:
{
  imports = [
    # Mostly user-specific configuration
    ./variables.nix

    # Programs
    ../../home/programs/kitty
    ../../home/programs/shell
    ../../home/programs/fetch
    ../../home/programs/git
    ../../home/programs/spicetify
    ../../home/programs/thunar
    ../../home/programs/lazygit
    ../../home/programs/zen
    ../../home/programs/duckduckgo-colorscheme
    ../../home/programs/discord
    ../../home/programs/tailscale
    ../../home/programs/anyrun

    # Scripts
    ../../home/scripts # All scripts

    # System (Desktop environment like stuff)
    ../../home/system/hyprland
    ../../home/system/hypridle
    ../../home/system/hyprlock
    ../../home/system/hyprpanel
    ../../home/system/hyprpaper
    ../../home/system/wofi
    ../../home/system/zathura
    ../../home/system/mime
    ../../home/system/udiskie
    ../../home/system/clipman
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
      obsidian # Note taking app
      planify # Todolists
      gnome-calendar # Calendar
      textpieces # Manipulate texts
      curtail # Compress images
      resources
      gnome-clocks
      gnome-text-editor
      mpv # Video player
      figma-linux

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
      air
      flyctl

      # Utils
      scrcpy
      calc
      television # Fuzzy search for Zed Editor
      zip
      unzip
      optipng
      jpegoptim
      pfetch
      htop
      btop
      fastfetch
      docker-compose

      # Just cool
      peaclock
      cbonsai
      pipes
      cmatrix

      # Backup
      brave
      vscode
    ];

    # Import my profile picture, used by the hyprpanel dashboard
    file.".face.icon" = {
      source = ./profile_picture.png;
    };

    # Don't touch this
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
