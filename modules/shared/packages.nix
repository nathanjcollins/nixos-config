{ pkgs }:

with pkgs; [
  # General packages for development and system management
  aspell
  aspellDicts.en
  bash-completion
  bat
  btop
  cmake
  coreutils
  delta
  gettext
  helix
  killall
  kitty
  neovim-nightly
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
  dejavu_fonts
  ffmpeg
  fd
  font-awesome
  hack-font
  noto-fonts
  noto-fonts-emoji
  meslo-lgs-nf

  # Node.js development tools
  nodePackages.npm # globally install npm
  nodePackages.prettier
  prettierd
  nodejs
  deno
  bun

  # Text and terminal utilities
  htop
  hunspell
  iftop
  jetbrains-mono
  jq
  ripgrep
  tree
  unzip
  zsh-powerlevel10k

  # Python packages
  python312
  python312Packages.virtualenv # globally install virtualenv

  # Rust development tools
  rustup

  # .NET
  (with dotnetCorePackages; combinePackages [
    sdk_9_0
    sdk_8_0
    # sdk_7_0
  ])
  # dotnetCorePackages.sdk_8_0_2xx
  # dotnetCorePackages.sdk_7_0_3xx

  # Gleam
  gleam
  erlang_27
]
