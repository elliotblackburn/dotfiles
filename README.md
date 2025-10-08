# Elliot's dot files

A Nix-centric dotfiles configuration that manages system packages and core configurations declaratively, while maintaining flexibility for custom shell functions and scripts.

## Structure

The dotfiles are organized around Nix as the primary configuration system, with custom shell scripts for flexibility:

- **nix/**: Core system and application configuration using Nix and home-manager
- **shell/**: Custom shell functions and completions that extend the base configuration
- **bin/**: Executable scripts available in PATH

## Core Philosophy

This setup uses Nix where it excels (declarative package and configuration management) while keeping shell functions and scripts flexible for rapid iteration and customization.

## What's Inside

### Nix Configuration
- **nix/flake.nix**: Main flake configuration for macOS and Linux
- **nix/home-manager/**: Home Manager configurations for user programs
- **nix/home-manager/programs/**: Individual program configurations (git, zsh, tmux)

### Shell Extensions
- **shell/functions/**: Custom shell functions (git helpers, prompt, window management)
- **shell/completions/**: Custom zsh completions
- **bin/**: Utility scripts and git helpers

## How It Works

### Nix Management
Nix handles:
- Package installation and management
- Core program configuration (git, zsh, tmux, etc.)
- Environment variables and shell aliases
- System-level settings

### Shell Function Loading
The zsh configuration automatically loads:
- All `*.zsh` files from `shell/functions/` as shell functions
- All `*.zsh` files from `shell/completions/` as completions (after compinit)
- Scripts from `bin/` are automatically added to `$PATH`

### Adding New Functionality
- **Declarative config**: Add to appropriate `nix/home-manager/programs/*.nix` file
- **Shell functions**: Create new `.zsh` files in `shell/functions/`
- **Completions**: Add completion scripts to `shell/completions/`
- **Executables**: Add scripts to `bin/`

## Installation

### Prerequisites
- Install Nix: `curl -L https://nixos.org/nix/install | sh`
- On macOS, install nix-darwin: Follow [nix-darwin installation guide](https://github.com/LnL7/nix-darwin)

### Setup
```sh
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles/nix

# On macOS:
sudo darwin-rebuild build --flake .#macosDev
sudo darwin-rebuild switch --flake .#macosDev

# On Linux:
home-manager switch --flake .#elliot@hostname
```

### Customization
- Edit program configurations in `nix/home-manager/programs/`
- Add shell functions to `shell/functions/`
- Modify the flake.nix for system-level changes
- Use `~/.localrc` and `~/.localaliases` for machine-specific overrides
