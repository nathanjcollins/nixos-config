{ config, pkgs, lib, ... }:

let name = "Nathan Collins";
    user = "nathancollins";
    email = "nathjcollins@gmail.com";
in
{
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
