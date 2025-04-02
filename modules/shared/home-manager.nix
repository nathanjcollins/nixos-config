{ config, pkgs, lib, ... }:

let name = "Nathan Collins";
    user = "nathancollins";
    email = "nathjcollins@gmail.com";
in
{
  alacritty = {
    enable = true;
    settings = {
      terminal = {
        shell = "/Users/nathancollins/.nix-profile/bin/fish";
      };
      font = {
        normal = {
          family = "Maple Mono";
          style = "Regular";
        };
        size = 18;
      };
      keyboard = {
        bindings = [
          {
            key = "`";
            mods = "Control";
            action = "ToggleViMode";
          }
        ];
      };
      window = {
        opacity = 0.9;
      };
      colors = {
        bright = {
          black = "#585273";
          blue = "#78a8ff";
          cyan = "#63f2f1";
          green = "#7fe9c3";
          magenta = "#7676ff";
          red = "#f02e6e";
          white = "#8a889d";
          yellow = "#f2b482";
        };
        cursor = {
          cursor = "#a1efd3";
          text = "#1e1c31";
        };
        normal = {
          black = "#1e1c31";
          blue = "#91ddff";
          cyan = "#abf8f7";
          green = "#a1efd3";
          magenta = "#d4bfff";
          red = "#f48fb1";
          white = "#cbe3e7";
          yellow = "#ffe6b3";
        };
        primary = {
          background = "#1e1c31";
          foreground = "#cbe3e7";
        };
      };
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
