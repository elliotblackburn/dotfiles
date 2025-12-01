{ config, pkgs, gitConfig, ... }:

{
  home.username = "elliot";
  home.homeDirectory = "/Users/elliot";
  home.stateVersion = "25.05";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  programs.home-manager.enable = true;

  # Import shared configs
  imports = [
    ./packages.nix
    ./programs/developer.nix
    ./programs/python-dev.nix
    (import ./programs/git.nix { inherit config pkgs gitConfig; })
    ./programs/zsh.nix
    ./programs/tmux.nix
    ./programs/zed.nix
  ];
}
