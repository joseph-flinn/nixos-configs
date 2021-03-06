{ config, lib, pkgs, ... }: 

with lib; {
  options.hardware.mouse = {
    enable = mkOption { type = types.bool; default = false; }; 
  };

  config = mkIf config.hardware.mouse.enable {
    services.xserver.libinput.enable = true;
    services.xserver.libinput.mouse = {
      accelProfile = "flat";
      accelSpeed = "-0.5";
    };
  };
}
