{
  programs.nixvim = {
    extraFiles."after/ftplugin/markdown.lua".text = ''
      vim.bo.tabstop = 2
      vim.bo.shiftwidth = 2
      vim.bo.expandtab = true 
      vim.wo.cursorline = false
    '';

    plugins = {
      render-markdown = {
        enable = true;
        settings = { completions.lsp.enabled = true; };
      };

      mkdnflow = {
        enable = true;
        mappings = {
          MkdnTableNextCell = {
            key = "<S-Tab>";
            modes = "i";
          };
          MkdnTablePrevCell = false;
        };
      };
    };
  };
}
