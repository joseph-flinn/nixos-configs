# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [ 
    <home-manager/nixos>
    ../hardware-configuration.nix  # Include the results of the hardware scan.

    ../hardware/x11.nix
    ../hardware/sound.nix
    ../hardware/bluetooth.nix
    ../hardware/keyboard.nix
    ../hardware/mouse.nix
  ];

  networking.hostName = "framework"; # Define your hostname.
  time.timeZone = "America/Los_Angeles";

  # EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_5_15;

  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.useDHCP = false;
  networking.interfaces.enp0s13f0u4u2.useDHCP = true;
  networking.interfaces.enp0s13f0u4u3.useDHCP = true;

  users.users.joseph = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  hardware.x11.dpi = 120;
  hardware.x11.enable = true;

  hardware.sound.enable = true;
  hardware.bluetooth.enable = true;
  hardware.keyboard.enable = true;
  hardware.mouse.enable = true;

  home-manager.users.joseph = import ../home/framework-joseph.nix;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}
