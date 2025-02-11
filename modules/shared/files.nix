{ user, lib, pkgs, config, ... }:

let
 # githubPublicKey = "ssh-ed25519 AAAA...";
  xdg_configHome = "${config.users.users.${user}.home}/.config";
  xdg_dataHome   = "${config.users.users.${user}.home}/.local/share";
  xdg_stateHome  = "${config.users.users.${user}.home}/.local/state";
in
{
  # "${xdg_configHome}/nvim" = {
  #   source = "${pkgs.fetchFromGitHub {
  #     owner = "nathanjcollins";
  #     repo = "nvim-config";
  #     rev = "16d0122cbdc426ea6d844807a9630c687dd675d3";
  #     sha256 = "sha256-otUZ7Vox7z5rdbOjKP4sbyHGkgoNeRVE5Zaof4U9nrM=";
  #   }}";
  #   recursive = true;
  # };

  # ".ssh/id_github.pub" = {
  #   text = githubPublicKey;
  # };

  # Initializes Emacs with org-mode so we can tangle the main config
  # ".emacs.d/init.el" = {
  #   text = builtins.readFile ../shared/config/emacs/init.el;
  # };
}
