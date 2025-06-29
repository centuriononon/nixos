{
  programs.nixvim = {
    config.colorschemes.kanagawa = {
      enable = true;
      settings.theme = "wave";
      autoLoad = true;
    };

    options.background = "";
  };
}
