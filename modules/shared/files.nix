{ user, pkgs, config, ... }:

let
 # githubPublicKey = "ssh-ed25519 AAAA...";
  xdg_configHome = "${config.users.users.${user}.home}/.config";
  xdg_dataHome   = "${config.users.users.${user}.home}/.local/share";
  xdg_stateHome  = "${config.users.users.${user}.home}/.local/state";
in
{
  ".tmux/plugins/tmux/themes/cyberdream.tmuxtheme" = {
    source = "${pkgs.fetchFromGitHub {
      owner = "scottmckendry";
      repo = "cyberdream.nvim";
      rev = "9eb7c63091d7369eba9015e9c656ca644ba6a3a4";
      sha256 = "sha256-yVLHn3qg+gkP7y/1DL94gyfSkLModPGxjqkoC54Kndc=";
    }}/extras/tmux/cyberdream.tmuxtheme";
  };
  "${xdg_configHome}/nvim" = {
    source = "${pkgs.fetchFromGitHub {
      owner = "nathanjcollins";
      repo = "nvim-config";
      rev = "802482fb7f262daa237bea7bea1307bd3e3ee96d";
      sha256 = "sha256-KTyoyMwH91JuU54iIh4+dO2V46RCmbAcaOmQ5DCdyq4";
    }}";
    recursive = true;
  };

  # ".ssh/id_github.pub" = {
  #   text = githubPublicKey;
  # };

  # Initializes Emacs with org-mode so we can tangle the main config
  # ".emacs.d/init.el" = {
  #   text = builtins.readFile ../shared/config/emacs/init.el;
  # };
}
