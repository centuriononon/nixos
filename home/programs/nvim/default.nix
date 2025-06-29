{ inputs, ... }: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./plugins/cmp.nix
    ./plugins/lz-n.nix
    ./plugins/git-conflict.nix
    ./plugins/conform.nix
    ./plugins/git.nix
    ./plugins/lightbulb.nix
    ./plugins/lsp.nix
    ./plugins/markdown-preview.nix
    ./plugins/markdown.nix
    ./plugins/neo-tree.nix
    ./plugins/telescope.nix
    ./plugins/trouble.nix
    ./plugins/kanagawa.nix
    ./plugins/utils.nix

    ./options.nix
    ./keymaps.nix
    ./autocmds.nix
  ];

  programs.nixvim.enable = true;
}
