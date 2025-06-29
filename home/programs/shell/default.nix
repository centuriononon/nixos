{
  imports = [
    ./fzf.nix
    ./zsh.nix
    # MIGRATE: starhip is likely the reason of broken nix-shell terminal
    ./starship.nix
    ./zoxide.nix
    # MIGRATE: Tmux won't be used
    ./tmux.nix
    # MIGRATE: eza is useless
    ./eza.nix
  ];
}
