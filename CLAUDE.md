# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a unified Nix flake configuration supporting multiple platforms:
- **Darwin (macOS)**: aarch64-darwin, x86_64-darwin
- **NixOS**: x86_64-linux, aarch64-linux  
- **Home Manager (Linux)**: x86_64-linux, aarch64-linux

## Common Commands

### Darwin (macOS)
```bash
# Initial setup with user configuration
nix run .#apply-aarch64-darwin

# Build configuration
nix run .#build-aarch64-darwin

# Build and apply changes
nix run .#build-switch-aarch64-darwin

# Rollback to previous generation
nix run .#rollback-aarch64-darwin
```

### NixOS
```bash
# Initial setup with disk partitioning
nix run .#apply-x86_64-linux

# Build configuration
nix run .#build-x86_64-linux

# Build and switch
nix run .#build-switch-x86_64-linux
```

### Secrets Management
```bash
# Copy SSH keys for secrets access
nix run .#copy-keys-<platform>

# Generate new age keys
nix run .#create-keys-<platform>

# Verify secrets configuration
nix run .#check-keys-<platform>
```

## Architecture

### Module Structure
- `modules/shared/` - Common configuration across all platforms
- `modules/darwin/` - macOS-specific modules (dock, homebrew casks)
- `modules/nixos/` - NixOS-specific modules (display manager, disk config)
- `hosts/` - Platform-specific entry points that import relevant modules

### File Organization Pattern
Each module directory follows this pattern:
- `default.nix` - Main module definition and imports
- `packages.nix` - Package declarations
- `home-manager.nix` - User program configuration
- `files.nix` - Static configuration file management
- `secrets.nix` - Age-encrypted secrets (NixOS/Darwin only)

### Key Technologies
- **Secrets**: `agenix` with private GitHub repository for encrypted configuration
- **Darwin**: Declarative homebrew management with custom taps (koekeishiya, felixkratz)
- **NixOS Desktop**: BSPWM + LightDM + Polybar + Rofi + Picom

### Template System
The `apply` scripts use token replacement during initial setup:
- `%USER%` - Username
- `%EMAIL%` - User email
- `%HOSTNAME%` - System hostname

## Development Stack
Comprehensive tooling including multiple language runtimes (Node.js, Python, Rust, .NET), LSPs, AI tools (claude-code, aider-chat), and container tools (Docker, Colima).