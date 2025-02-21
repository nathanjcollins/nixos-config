{ config, pkgs, lib, ... }:

let
  user = "nathancollins";
  xdg_configHome  = "/home/${user}/.config";
  shared-programs = import ../shared/home-manager.nix { inherit config pkgs lib; };
  # shared-files = import ../shared/files.nix { inherit config pkgs; };
in
{
  home = {
    enableNixpkgsReleaseCheck = false;
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = pkgs.callPackage ./packages.nix {};
    # file = shared-files // import ./files.nix { inherit user; };
    stateVersion = "21.05";
  };

  dconf.settings = {
      "org/gnome/desktop/input-sources" = {
        xkb-options = ["caps:escape_shifted_capslock"];
      };
  };

  # Screen lock
  services = {
    # Auto mount devices
    udiskie.enable = true;
  };

  programs = shared-programs // { gpg.enable = true; };

}
