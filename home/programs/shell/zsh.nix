{
  pkgs,
  lib,
  config,
  ...
}:
let
  fetch = config.theme.fetch; # neofetch, nerdfetch, pfetch
in
{

  home.packages = with pkgs; [
    bat
    ripgrep
    tldr
    sesh
  ];

  home.sessionPath = [ "$HOME/go/bin" ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "main"
        "brackets"
        "pattern"
        "regexp"
        "root"
        "line"
      ];
    };
    historySubstringSearch.enable = true;

    initExtraFirst =
      #bash
      ''
        bindkey -e
        ${
          if fetch == "neofetch" then
            pkgs.neofetch + "/bin/neofetch"
          else if fetch == "nerdfetch" then
            "nerdfetch"
          else if fetch == "pfetch" then
            "echo; ${pkgs.pfetch}/bin/pfetch"
          else
            ""
        }

        function sesh-sessions() {
          session=$(sesh list -t -c | fzf --height 70% --reverse)
          [[ -z "$session" ]] && return
          sesh connect $session
        }

        zle     -N             sesh-sessions
        bindkey -M emacs '\es' sesh-sessions
        bindkey -M vicmd '\es' sesh-sessions
        bindkey -M viins '\es' sesh-sessions
      '';

    history = {
      ignoreDups = true;
      save = 10000;
      size = 10000;
    };

    profileExtra = lib.optionalString (config.home.sessionPath != [ ]) ''
      export PATH="$PATH''${PATH:+:}${lib.concatStringsSep ":" config.home.sessionPath}"
    '';

    #NOTE- for btop to show gpu usage
    #may want to check the driver version with:
    #nix path-info -r /run/current-system | grep nvidia-x11
    #and
    #nix search nixpkgs nvidia_x11
    sessionVariables = {
      LD_LIBRARY_PATH = lib.concatStringsSep ":" [
        "${pkgs.linuxPackages_latest.nvidia_x11_beta}/lib" # change the package name according to nix search result
        "$LD_LIBRARY_PATH"
      ];
    };

    shellAliases = {
      zed = "zeditor";
      cd = "z";
      ls = "eza --icons=always --no-quotes";
      tree = "eza --icons=always --tree --no-quotes";
      open = "${pkgs.xdg-utils}/bin/xdg-open";
      icat = "${pkgs.kitty}/bin/kitty +kitten icat";
      ssh = "kitty +kitten ssh";
      cat = "bat --theme=base16 --color=always --paging=never --tabs=2 --wrap=never --plain";

      obsidian-no-gpu = "env ELECTRON_OZONE_PLATFORM_HINT=auto obsidian --ozone-platform=x11";
      wireguard-import = "nmcli connection import type wireguard file";

      notes = "nvim ~/nextcloud/notes/index.md --cmd 'cd ~/nextcloud/notes' -c ':Telescope find_files'";
      note = "notes";

      nix-shell = "nix-shell --command zsh";
    };

    initExtra = ''
      # search history based on what's typed in the prompt
      autoload -U history-search-end
      zle -N history-beginning-search-backward-end history-search-end
      zle -N history-beginning-search-forward-end history-search-end
      bindkey "^[OA" history-beginning-search-backward-end
      bindkey "^[OB" history-beginning-search-forward-end

      # General completion behavior
      zstyle ':completion:*' completer _extensions _complete _approximate

      # Use cache
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

      # Complete the alias
      zstyle ':completion:*' complete true

      # Autocomplete options
      zstyle ':completion:*' complete-options true

      # Completion matching control
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
      zstyle ':completion:*' keep-prefix true

      # Group matches and describe
      zstyle ':completion:*' menu select
      zstyle ':completion:*' list-grouped false
      zstyle ':completion:*' list-separator '''
      zstyle ':completion:*' group-name '''
      zstyle ':completion:*' verbose yes
      zstyle ':completion:*:matches' group 'yes'
      zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
      zstyle ':completion:*:messages' format '%d'
      zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
      zstyle ':completion:*:descriptions' format '[%d]'

      # Colors
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

      # case insensitive tab completion
      zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
      zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
      zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
      zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands
      zstyle ':completion:*' special-dirs true
      zstyle ':completion:*' squeeze-slashes true

      # Sort
      zstyle ':completion:*' sort false
      zstyle ":completion:*:git-checkout:*" sort false
      zstyle ':completion:*' file-sort modification
      zstyle ':completion:*:eza' sort false
      zstyle ':completion:complete:*:options' sort false
      zstyle ':completion:files' sort false

      ${lib.optionalString config.services.gpg-agent.enable ''
        gnupg_path=$(ls $XDG_RUNTIME_DIR/gnupg)
        export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/$gnupg_path/S.gpg-agent.ssh"
      ''}

      # Allow foot to pipe command output
      function precmd {
        if ! builtin zle; then
            print -n "\e]133;D\e\\"
        fi
      }
      function preexec {
        print -n "\e]133;C\e\\"
      }

      # Forks execution 
      fork() {
        sh -ic "($* &) &>/dev/null"
      }
    '';
  };
}
