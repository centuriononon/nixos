{ pkgs, config, ... }: {
  imports = [
    ./variables.nix

    ../../home/programs/direnv
    ../../home/programs/git
    ../../home/programs/kitty
    ../../home/programs/lazygit
    ../../home/programs/shell
    ../../home/programs/spicetify
    ../../home/programs/thunar
    ../../home/programs/udiskie
    ../../home/programs/zathura
    ../../home/programs/zen
    ../../home/programs/zed

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
      brave
      vscode
      zed-editor
      keepassxc
      telegram-desktop
      resources
      mpv
      pavucontrol
      libreoffice-fresh
      alacritty

      # Dev
      elixir
      erlang
      rebar3
      postgresql
      redis
      postman
      go
      nodejs
      python3
      just
      pnpm
      flyctl
      doctl
      mtr
      kubectl
      kubernetes-helm
      minikube
      gcc
      cmake
      vimHugeX
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
      apacheKafka
      lsof
      protobuf
      envsubst
      packer
      libvirt
      OVMF
      qemu
    ];

    # Don't touch this
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}

