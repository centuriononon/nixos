{ config, lib, pkgs, ... }: {
  programs.nixvim = {
    nixpkgs.config.allowUnfree = true; # For copilot
    highlightOverride = {
      WhichKeySeparator.bg = "#${config.lib.stylix.colors.base00}";
    };
    plugins = {
      copilot-vim = {
        enable = true;
        # FIXME: Temp issue solving
        settings.node_command = lib.getExe pkgs.nodejs_20;
      };
      web-devicons.enable = true;
      flash.enable = true;
      todo-comments.enable = true;
      lualine.enable = true;
      aerial.enable = true;
    };
    keymaps = [{
      key = "<leader>ct";
      action = "<cmd>AerialToggle<cr>";
      options.desc = "Aerial (tags)";
    }];
  };
}
