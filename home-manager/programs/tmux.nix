{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;  # Start window numbering at 1 instead of 0

    extraConfig = ''
      # Prevent tmux from automatically renaming windows
      set-option -g allow-rename off
    '';
  };
}
