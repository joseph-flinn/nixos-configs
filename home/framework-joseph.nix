{ config, pkgs, ... }: {

  imports = [
    ../modules/base.nix
    ../modules/dwm.nix
  ];

  modules.base.enable = true;
  modules.dwm.enable = true;

  home.packages = with pkgs; [
    dmenu
    brave
  ];
}
