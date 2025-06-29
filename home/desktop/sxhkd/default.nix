# Required packages:
# 1. maim (screenshoter), xclip (clipboard)
# 2. xdotool (helpers for keybindings)
# 3. alsa-mixer (alsa-utils, sound control)
{
  xdg.configFile."sxhkd/sxhkdrc" = {
    source = ./sxhkdrc;
    executable = true;
  };
}
