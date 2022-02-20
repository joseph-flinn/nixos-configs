{ config, lib, pkgs, ... }:

with lib; {
  options.hardware.x11 = {
    enable = mkOption { type = types.bool; default = false; };
    dpi = mkOption { type = types.int; default = 100; };
    layout = mkOption { type = types.str; default = "us"; };
  };

  config = mkIf config.hardware.x11.enable {
    services.xserver.enable = true;
    services.xserver.autorun = true;

    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.displayManager.session = [
      {
        manage = "desktop";
        name = "xsession";
        start = "exec $HOME/.xsession";
      }
    ];

    services.xserver.dpi = config.hardware.x11.dpi;
    hardware.video.hidpi.enable = config.hardware.x11.dpi > 100;

    services.xserver.layout = config.hardware.x11.layout;
  };
}
