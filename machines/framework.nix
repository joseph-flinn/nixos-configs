# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [ 
    <home-manager/nixos>
    /etc/nixos/hardware-configuration.nix  # Include the results of the hardware scan.

    ../hardware/screen.nix
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

  # networking.networkmanager.enable = true;
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.useDHCP = false;
  networking.interfaces.wlp170s0.useDHCP = true;
  #networking.interfaces.enp0s13f0u4u2.useDHCP = true;
  #networking.interfaces.enp0s13f0u4u3.useDHCP = true;

  virtualisation.docker.enable = true;

  users.users.joseph = {
    isNormalUser = true;
    extraGroups = [ "wheel" "dialout" "video" "docker" ];
    shell = pkgs.bash;
  };

  hardware.x11.dpi = 120;
  hardware.x11.enable = true;

  hardware.sound.enable = true;
  hardware.bluetooth.enable = true;
  hardware.keyboard.enable = true;
  hardware.mouse.enable = true;

  security.pki.certificates = [
  ''
    Local K8s Cluster Issuer Root CA
    ================================
    -----BEGIN CERTIFICATE-----
    MIIBezCCASKgAwIBAgIQHZf5eBpi5Z/WBPLvPuyTGDAKBggqhkjOPQQDAjAeMRww
    GgYDVQQDExNsb2NhbC1zZWxmc2lnbmVkLWNhMB4XDTIyMDExNDE2MzEyNloXDTIy
    MDQxNDE2MzEyNlowHjEcMBoGA1UEAxMTbG9jYWwtc2VsZnNpZ25lZC1jYTBZMBMG
    ByqGSM49AgEGCCqGSM49AwEHA0IABC75PkiB2JS50lW361jFD4oOY28Blct4+mRc
    a4lrCC50JAP2VuWIQHBxp8fkmpzqp4H775GUKKN/w8Wwxky4rLOjQjBAMA4GA1Ud
    DwEB/wQEAwICpDAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBQtLlEhSwXp3Co+
    QaiDhS+78G49kDAKBggqhkjOPQQDAgNHADBEAiARVXcakceMJd4S0+rKIZTC/OYv
    J0iGG5TriNmOMiX03AIgY1YHpRbPL9vTJwf6v2KHlT/PzQzJcVkgfiq/wcM9azg=
    -----END CERTIFICATE-----

  ''
  ];

  # System wide packages
  environment.systemPackages = with pkgs; [
    home-manager
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
