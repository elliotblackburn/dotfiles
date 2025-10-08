{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    git-lfs
    direnv
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };
}
