{ pkgs }:

with pkgs; [
  # General packages for development and system management
  aspell
  aspellDicts.en
  bash-completion
  bat
  btop
  cmake
  colima
  coreutils
  delta
  eza
  fsautocomplete
  fzf
  gettext
  gh
  helix
  killall
  lazydocker
  neovim
  ninja
  openssh
  sqlite
  wget
  yazi
  zip
  zoxide

  # Encryption and security tools
  age
  age-plugin-yubikey
  gnupg
  libfido2

  # Cloud-related tools and SDKs
  docker
  docker-compose

  # Media-related packages
  # dejavu_fonts
  ffmpeg
  fd
  # font-awesome
  # hack-font
  # noto-fonts
  # noto-fonts-emoji
  # meslo-lgs-nf

  # Node.js development tools
  nodePackages.npm # globally install npm
  nodePackages.prettier
  nodePackages.typescript
  nodePackages.typescript-language-server
  nodePackages."@vue/language-server"
  nodePackages.svelte-language-server
  prettierd
  nodejs
  deno
  bun

  # Text and terminal utilities
  grc
  htop
  hunspell
  iftop
  jetbrains-mono
  jq
  oh-my-fish
  ripgrep
  tree
  unzip

  # Python packages
  pyenv
  python312
  python312Packages.virtualenv # globally install virtualenv

  # Rust development tools
  rustup

  # .NET
  (with dotnetCorePackages; combinePackages [
    sdk_9_0
    sdk_8_0
  ])

  # Gleam
  gleam
  erlang_27

  # LSPs
  lua-language-server
  roslyn-ls
]
