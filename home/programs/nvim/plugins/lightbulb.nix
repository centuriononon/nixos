{
  programs.nixvim.plugins.nvim-lightbulb = {
    enable = true;

    settings = {
      line.enabled = true;
      number.enabled = true;
      autocmd = {
        enabled = true;
        updatetime = 200;
      };
      sign = {
        enabled = true;
        text = " 󰌶";
      };
      status_text = {
        enabled = true;
        text = " 󰌶 ";
      };
    };
  };
}
