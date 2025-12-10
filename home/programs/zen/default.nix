{ pkgs, inputs, ... }:
let
  zen = pkgs.symlinkJoin {
    name = "zen-browser";
    paths = [ inputs.zen-browser.packages."${pkgs.system}".default ];
  };
in
{
  home.packages = [ zen ];
}
