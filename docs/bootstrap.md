# Bootstrapping a New Machine

This document covers how to prepare a new machine to run the `switch` command and apply these dotfiles.

The setup differs between macOS and Linux because of how home-manager is integrated on each platform. On macOS, nix-darwin is used to manage system-level settings (things like macOS defaults, system packages, and launch daemons). Home-manager runs as a module within nix-darwin, so it is set up automatically when nix-darwin is first applied — there is nothing extra to install. On Linux, there is no equivalent system management layer, so home-manager is used directly as a standalone tool and must be explicitly made available before it can be run.

---

## 1. Install Lix

On both macOS and Linux, install Lix using the [Lix installer](https://lix.systems/install/):

```sh
curl -sSf -L https://install.lix.systems/lix | sh -s -- install
```

Follow the prompts. Once complete, open a new shell to pick up the changes.

> The Lix installer enables flakes by default, so no further Nix configuration is needed.

---

## 2. macOS: Install nix-darwin

nix-darwin is required on macOS to apply the system-level configuration. The [nix-darwin README](https://github.com/nix-darwin/nix-darwin) recommends bootstrapping it using `nix run` before the dotfiles are applied.

Clone this repo, then from the repo root run:

```sh
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .
```

You will be prompted for your password. If macOS reports conflicts with existing files (e.g. `/etc/zshrc`, `/etc/bashrc`), move or remove them and re-run the command.

Once this completes, `darwin-rebuild` is available and the system is managed by nix-darwin.

> For troubleshooting, see the [nix-darwin README](https://github.com/nix-darwin/nix-darwin).

---

## 3. Linux: Add the home-manager channel

On Linux, home-manager is used as a standalone tool. Before running `switch`, the home-manager Nix channel must be added.

Add the channel that matches the nixpkgs version used in this flake (unstable):

```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```

> For other nixpkgs versions or further detail, see the [home-manager installation docs](https://nix-community.github.io/home-manager/#ch-installation).

---

## 4. Apply the dotfiles

Clone this repo if you haven't already, then from the repo root run the appropriate switch command for your platform. This can be found in the [README.md](../README.md).
