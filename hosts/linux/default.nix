{ config, osConfig, pkgs, ... }:
let user = "nathancollins"; in
{
  imports = [
    ../../modules/linux/home-manager.nix
    ../../modules/shared
  ];
  # Setup user, packages, programs
  nix = {
    package = pkgs.nixVersions.git;
    settings.trusted-users = [ "@admin" "${user}" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  programs.home-manager.enable = true;

  # services = {
  #   xserver = {
  #     enable = true;
  #     xkbOptions = "caps:escape_shifted_capslock";
  #   };
  # };
}
