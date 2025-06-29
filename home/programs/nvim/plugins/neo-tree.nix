{
  programs.nixvim.plugins.neo-tree = {
    enable = true;

    closeIfLastWindow = true;

    filesystem = {
      filteredItems = {
        hideDotfiles = false;
        hideHidden = false;

        neverShowByPattern = [
          ".direnv"
          ".git"
        ];

        visible = true;
      };

      followCurrentFile = {
        enabled = true;
        leaveDirsOpen = true;
      };

      useLibuvFileWatcher.__raw = ''vim.fn.has "win32" ~= 1'';
    };

    window = {
      width = 40;
      autoExpandWidth = false;
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<space><space>";
      action = "<cmd>Neotree focus<CR>";
      options.desc = "Focus NeoTree panel.";
    }
    {
      mode = "n";
      key = "<leader>E";
      action = "<cmd>Neotree action=focus reveal toggle<CR>";
      options.desc = "Explorer toggle";
    }
  ];
}
