{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs_24
  ];

  # Set up npm global configuration and PATH
  home.sessionVariables = {
    NPM_CONFIG_PREFIX = "${config.home.homeDirectory}/.npm-global";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.npm-global/bin"
  ];
}
