{ config, pkgs, ... }:

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
    ({ config, pkgs, ... }: import ./programs/git.nix {
      inherit config pkgs;
      userName = "Elliot Blackburn";
      userEmail = "elliot@lybrary.io";
      gpgSshProgram = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF3fznw303UZ4U+35laeeSuY4VMCKIDsT/ZGpSbQGQpi";
    })
    ./programs/zsh.nix
    ./programs/tmux.nix
  ];
}
