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
    ../../home/programs/zen

    ../../home/desktop/sxhkd
    ../../home/desktop/polybar
    ../../home/desktop/picom
    ../../home/desktop/mime
    ../../home/desktop/bspwm
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    packages = with pkgs; [
      # Apps
      neovim
      zed-editor
      keepassxc
      telegram-desktop
      resources
      mpv
      pavucontrol
      libreoffice-fresh

      # Dev
      alacritty
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
      doctl
      mtr
      kubectl

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
      maim
      gnumake

      brave
      vscode
    ];

    # Don't touch this
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
