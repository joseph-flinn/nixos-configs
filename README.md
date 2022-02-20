# Recognition
Thanks to Chris Bailey and his [NixOS configs](https://github.com/vereis/nixos)! They were heavily
referenced in the initial setup and organization of the nix files. The `hardware` directory and usage
is essentailly a direct copy. The other ones start deviating a bit to match my system needs.

# Setup
Install NixOS from the minimal installation media and follow the latest install manual. I'd highly 
recommend using LVM to set up the partitions in the installation. 

You will need `git` to retreive the config files from this repo. `nix-shell -p git` will install it for usage without affecting the user's version that will be installed.

The Intel wifi card that is in my Framework laptop needs a kernel version greater than 5.15.4. The 
latest version of 5.15.4 on the `nixos-unstable` channel meets this description. 

```
nix-channel --add https://nixos.org/channels/nixos-unstable nixos
nix-channel --update
```

I've decided to use Home-Manager to maintain all of my user packages and package configuration. The channel has to be added before running `nixos-rebuild switch` for the first time.

```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```

Once the above has been set up, we continue with retreiving the `nix` files and setup up the system.

```
nix-shell -p git
cd /etc/nixos

git clone https://github.com/joseph-flinn/nixos-configs.git .
ln -s machine/framework.nix configuration.nix

nixos-rebuild switch
```

The `wpa_supplicant` will probably fail since `/etc/wpa_supplicant.conf` probably doesn't exist.

```
wpa_passphrase <ESSID> <Passsword> > /etc/wpa_supplicant.conf
systemctl restart wpa_supplicant.service
```


# NixOS Generation Cleanup

With the named profiles (built with `nixos-rebuild switch -p test`), sometimes they stick around in
GRUB when you don't want them to and `nix-collect-garbage -d` doesn't delete them. 

```
sudo nix-env --delete-generations old --profile /nix/var/nix/profiles/system
sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch.
```

Then might not get all of the profiles that have been manually created. To clean those ones:

```
# https://github.com/NixOS/nixpkgs/issues/3542#issuecomment-570490137 

sudo rm /nix/var/nix/profiles/system-profiles/<entries> (There will be two for each)
sudo nix-collect-garbage -d
sudo nixos-rebuild switch
sudo rm /boot/loader/entries/<entry>
shutdown -r now
```
