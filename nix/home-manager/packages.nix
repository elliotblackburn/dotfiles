{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    git-lfs
    tmux
    direnv
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };
}
