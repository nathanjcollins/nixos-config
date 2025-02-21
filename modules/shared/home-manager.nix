{ config, pkgs, lib, ... }:

let name = "Nathan Collins";
    user = "nathancollins";
    email = "nathjcollins@gmail.com";
in
{
  # Shared shell configuration
  zsh = {
    enable = true;
    autocd = false;
    cdpath = [ "~/.local/share/src" ];
    plugins = [
      {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
          name = "powerlevel10k-config";
          src = lib.cleanSource ./config;
          file = "p10k.zsh";
      }
    ];
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Load oh-my-zsh
      export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/

      ZSH_THEME="robbyrussell"

      source $ZSH/oh-my-zsh.sh

      source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

      # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
      [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

      [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
      source <(fzf --zsh)

      # Define variables for directories
      export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
      export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
      export PATH=$HOME/.local/share/bin:$PATH

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      # Ripgrep alias
      alias search=rg -p --glob '!node_modules/*'  $@

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }

      # pnpm is a javascript package manager
      alias pn=pnpm
      alias px=pnpx

      # Use difftastic, syntax-aware diffing
      alias diff=difft

      # Always color ls and group directories
      alias ls='ls --color=auto'

      alias cdf='cd $(find ~/repos  -maxdepth 5 -type d -not -path "*/.*" -print | fzf)'

      # alias z='zellij'

      alias lg='lazygit'

      # pnpm
      export PNPM_HOME="/Users/nathancollins/.local/share/pnpm"
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac
      # pnpm end

      export DOTNET_TOOLS="/Users/nathancollins/.dotnet/tools"
      case ":$PATH:" in
        *":$DOTNET_TOOLS:"*) ;;
        *) export PATH="$DOTNET_TOOLS:$PATH" ;;
      esac

      export HELIX_RUNTIME=/Users/nathancollins/repos/helix/runtime

      # export KUBECONFIG=/Users/nathancollins/repos/cap/caput-energy/config/caput-shared-cluster.kubeconfig:/Users/nathancollins/repos/cap/cap-terraform/config/cap-dev-cluster.kubeconfig
      #
      # export KUBECONFIG=/Users/nathancollins/repos/cap/cap-terraform/config/cap-prod-cluster.kubeconfig
      export KUBECONFIG=/Users/nathancollins/repos/cap/cap-terraform/config/cap-test-cluster.kubeconfig

      export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

      export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
      export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
      # bun completions
      [ -s "/Users/nathancollins/.bun/_bun" ] && source "/Users/nathancollins/.bun/_bun"

      alias ls='eza --icons'

      # pnpm shortcuts
      alias pi='pnpm i'
      alias pd='pnpm dev'
      alias pr='pnpm remove'
      alias pt='pnpm test'

      # npm shortcuts
      alias ni='npm i'
      alias nd='npm dev'
      alias nr='npm remove'
      alias nt='npm test'
      export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

      bindkey "^[[1;3C" forward-word
      bindkey "^[[1;3D" backward-word

      bindkey -s "^[3" "#"

      eval "$(zoxide init zsh)"

      export PATH=/home/nathancollins/.cache/rebar3/bin:$PATH
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" "kubectl" ];
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

  vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline vim-airline-themes vim-startify ];
    settings = { ignorecase = true; };
    extraConfig = ''
      "" General
      set number
      set history=1000
      set nocompatible
      set modelines=0
      set encoding=utf-8
      set scrolloff=3
      set showmode
      set showcmd
      set hidden
      set wildmenu
      set wildmode=list:longest
      set cursorline
      set ttyfast
      set nowrap
      set ruler
      set backspace=indent,eol,start
      set laststatus=2
      set clipboard=autoselect

      " Dir stuff
      set nobackup
      set nowritebackup
      set noswapfile
      set backupdir=~/.config/vim/backups
      set directory=~/.config/vim/swap

      " Relative line numbers for easy movement
      set relativenumber
      set rnu

      "" Whitespace rules
      set tabstop=8
      set shiftwidth=2
      set softtabstop=2
      set expandtab

      "" Searching
      set incsearch
      set gdefault

      "" Statusbar
      set nocompatible " Disable vi-compatibility
      set laststatus=2 " Always show the statusline
      let g:airline_theme='bubblegum'
      let g:airline_powerline_fonts = 1

      "" Local keys and such
      let mapleader=","
      let maplocalleader=" "

      "" Change cursor on mode
      :autocmd InsertEnter * set cul
      :autocmd InsertLeave * set nocul

      "" File-type highlighting and configuration
      syntax on
      filetype on
      filetype plugin on
      filetype indent on

      "" Paste from clipboard
      nnoremap <Leader>, "+gP

      "" Copy from clipboard
      xnoremap <Leader>. "+y

      "" Move cursor by display lines when wrapping
      nnoremap j gj
      nnoremap k gk

      "" Map leader-q to quit out of window
      nnoremap <leader>q :q<cr>

      "" Move around split
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l

      "" Easier to yank entire line
      nnoremap Y y$

      "" Move buffers
      nnoremap <tab> :bnext<cr>
      nnoremap <S-tab> :bprev<cr>

      "" Like a boss, sudo AFTER opening the file to write
      cmap w!! w !sudo tee % >/dev/null

      let g:startify_lists = [
        \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      }
        \ ]

      let g:startify_bookmarks = [
        \ '~/.local/share/src',
        \ ]

      let g:airline_theme='bubblegum'
      let g:airline_powerline_fonts = 1
      '';
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

  ghostty = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        # font-family = "Maple Mono";
        shell-integration = "zsh";
        font-size = "18";
        command = "zsh";
        background-opacity = "0.9";
        macos-option-as-alt = "true";

        theme = "kanagawa-dragon";

        keybind = [
          "ctrl+t=new_tab"
          "ctrl+w=close_surface"
          "global:cmd+grave_accent=toggle_quick_terminal"

          "ctrl+s>h=new_split:left"
          "ctrl+s>j=new_split:down"
          "ctrl+s>k=new_split:up"
          "ctrl+s>l=new_split:right"
          "ctrl+s>f=toggle_split_zoom"
          "ctrl+s>equal=equalize_splits"

          "ctrl+up=resize_split:up,20"
          "ctrl+down=resize_split:down,20"
          "ctrl+left=resize_split:left,20"
          "ctrl+right=resize_split:right,20"

          "alt+h=goto_split:left"
          "alt+j=goto_split:bottom"
          "alt+k=goto_split:top"
          "alt+l=goto_split:right"

          "ctrl+z=toggle_tab_overview"
        ];

        window-save-state = "always";
      };
      themes = {
        kanagawa-dragon = {
          background = "181616";
          foreground = "c5c9c5";
          cursor-color = "c8c093";
          selection-background = "2d4f67";
          selection-foreground = "c8c093";
          palette = [
            "0=#0d0c0c"
            "1=#c4746e"
            "2=#8a9a7b"
            "3=#c4b28a"
            "4=#8ba4b0"
            "5=#a292a3"
            "6=#8ea4a2"
            "7=#c8c093"
            "8=#a6a69c"
            "9=#e46876"
            "10=#87a987"
            "11=#e6c384"
            "12=#7fb4ca"
            "13=#938aa9"
            "14=#7aa89f"
            "15=#c5c9c5"
          ];
        };
        kanagawa-lotus = {
          background = "f2ecbc";
          foreground = "545464";
          cursor-color = "43436c";
          selection-background = "c9cbd1";
          selection-foreground = "43436c";
          palette = [
            "0=#1f1f28"
            "1=#c84053"
            "2=#6f894e"
            "3=#77713f"
            "4=#4d699b"
            "5=#b35b79"
            "6=#597b75"
            "7=#545464"
            "8=#8a8980"
            "9=#d7474b"
            "10=#6e915f"
            "11=#836f4a"
            "12=#6693bf"
            "13=#624c83"
            "14=#5e857a"
            "15=#43436c"
          ];
        };
        kanagawa-wave = {
          background = "1f1f28";
          foreground = "dcd7ba";
          cursor-color = "c8c093";
          selection-background = "2d4f67";
          selection-foreground = "c8c093";
          palette = [
            "0=#16161d"
            "1=#c34043"
            "2=#76946a"
            "3=#c0a36e"
            "4=#7e9cd8"
            "5=#957fb8"
            "6=#6a9589"
            "7=#c8c093"
            "8=#727169"
            "9=#e82424"
            "10=#98bb6c"
            "11=#e6c384"
            "12=#7fb4ca"
            "13=#938aa9"
            "14=#7aa89f"
            "15=#dcd7ba"
          ];
        };
      };
  };
}
