{ pkgs }:

with pkgs; [
  # General packages for development and system management
  aider-chat
  aspell
  aspellDicts.en
  azure-cli
  bash-completion
  bat
  # bruno
  btop
  cmake
  colima
  coreutils
  delta
  discord
  eza
  fsautocomplete
  fzf
  gettext
  gh
  git-crypt
  # helix
  killall
  kubectl
  k9s
  lazydocker
  lazygit
  neofetch
  neovim-unwrapped
  ninja
  openssh
  sqlite
  terraform
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
  nodePackages.pnpm
  nodePackages.prettier
  nodePackages.typescript
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
  nodePackages."@tailwindcss/language-server"
  nodePackages.typescript-language-server
  nodePackages."@vue/language-server"
  nodePackages.svelte-language-server

  claude-code
  trivy
  evil-helix
  ollama
]
