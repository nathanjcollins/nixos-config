{ config, pkgs, lib, ... }:

let name = "Nathan Collins";
    user = "nathancollins";
    email = "nathjcollins@gmail.com";
in
{
  starship = {
    enable = true;
  };
  kitty = {
    enable = true;
    font = {
      name = "Maple Mono";
      size = 18;
    };
    shellIntegration.enableFishIntegration = true;
    settings = {
      hide_window_decorations = "yes";
      cursor_trail = 1;
      background = "#1E1C31";
      foreground = "#CBE3E7";

      cursor = "#A1EFD3";

      selection_background = "#3E3859";
      selection_foreground = "#CBE3E7";

      # black
      color0 = "#1E1C31";
      color8 = " #585273";

      # red
      color1 = "#F48FB1";
      color9 = "#F02E6E";

      # green
      color2 = "#A1EFD3";
      color10 = "#7FE9C3";

      # yellow
      color3 = "#FFE6B3";
      color11 = "#F2B482";

      # blue
      color4 = "#91DDFF";
      color12 = "#78A8FF";

      # magenta
      color5 = "#D4BFFF";
      color13 = "#7676FF";

      # cyan
      color6 = "#ABF8F7";
      color14 = "#63F2F1";

      # white
      color7 = "#CBE3E7";
      color15 = "#8A889D";

      active_border_color = "#A1EFD3";
      inactive_border_color = "#585273";
      bell_border_color = "#F56574";

      active_tab_foreground = "#2D2B40";
      active_tab_background = "#63F2F1";
      active_tab_font_style = "bold";

      inactive_tab_foreground = "#CBE3E7";
      inactive_tab_background = "#585273";
      inactive_tab_font_style = "normal";

      url_color = "#D4BFFF";
    };
  };

  tmux = {
    enable = true;
    keyMode = "vi";
    plugins = [
      pkgs.tmuxPlugins.resurrect
      pkgs.tmuxPlugins.vim-tmux-navigator
      pkgs.tmuxPlugins.weather
    ];
    extraConfig = "
      set-option -g default-shell /Users/nathancollins/.nix-profile/bin/fish
      set -g default-terminal \"tmux-256color\"
      set -ga terminal-overrides \",*256col*:Tc\"
      set-environment -g COLORTERM \"truecolor\"
      bind '`' copy-mode
      bind-key    -T copy-mode-vi v                  send-keys -X begin-selection
      set -s escape-time 0
    ";
  };

  # Shared shell configuration
  fish = {
    enable = true;
    plugins = [
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      { name = "z"; src = pkgs.fishPlugins.z.src; }
      { name = "plugin-git"; src = pkgs.fishPlugins.plugin-git.src; }
    ];
    shellAliases = {
      lg = "lazygit";
      pd = "pnpm run dev";
      pi = "pnpm install";
    };
    shellInit = "
        set -Ux KUBECONFIG /Users/nathancollins/repos/cap/cap-terraform/config/cap-prod-cluster.kubeconfig
        # set -Ux KUBECONFIG /Users/nathancollins/repos/cap/cap-terraform/config/cap-test-cluster.kubeconfig
        fish_add_path /Users/nathancollins/.opencode/bin
        set -gx OPENAI_API_KEY asdasd
        set -gx OPENAI_BASE_URL http://localhost:11434/v1
        set -gx OPENAI_MODEL qwen3-30b-a3b-2507
    ";
  };

  gpg = {
    enable = true;
  };

  git = {
    enable = true;
    ignores = [ "*.swp" ];
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
	    editor = "vim";
        autocrlf = "input";
      };
      commit.gpgsign = true;
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };

  ssh = {
    enable = true;
    includes = [
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "/home/${user}/.ssh/config_external"
      )
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "/Users/${user}/.ssh/config_external"
      )
    ];
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
            "/home/${user}/.ssh/id_github"
          )
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
            "/Users/${user}/.ssh/id_github"
          )
        ];
      };
    };
  };

  lazygit = {
    enable = true;
    settings = {
      gui = {
       theme = {
         activeBorderColor = ["#63F2F1"];
         inactiveBorderColor = ["#585273"];
         optionsTextColor = ["#D4BFFF"];
         selectedLineBgColor = ["#3E3859"];
         selectedRangeBgColor = ["#2D2B40"];
         cherryPickedCommitBgColor = ["#585273"];
         cherryPickedCommitFgColor = ["#91DDFF"];
         unstagedChangesColor = ["#F48FB1"];
         defaultFgColor = ["#CBE3E7"];
         searchingActiveBorderColor = ["#FFE6B3"];
        };
      };
      git = {
        paging = {
          colorArg = "always";
          pager = "delta --dark --paging=never";
        };
      };
    };
  };
}
