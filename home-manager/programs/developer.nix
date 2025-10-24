# ~/.dotfiles/nix/home-manager/programs/developer.nix
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Language toolchains
    nodejs_24
    beam.packages.erlang_28.erlang
    beam.packages.erlang_28.elixir_1_18
    python3
    go

    # Development tools
    terraform
    ansible

    # Modern CLI tools
    jq         # JSON processor
    yq         # YAML processor

    # Database tools
    # postgresql
    # redis
    # sqlite

    # Cloud CLIs
    awscli2
  ];

  # Programming language configurations
  programs = {
    # Go configuration
    go = {
      enable = true;
    };
  };

  # Set up npm global configuration and PATH
  home.sessionVariables = {
    NPM_CONFIG_PREFIX = "${config.home.homeDirectory}/.npm-global";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.npm-global/bin"
  ];

  # Development-specific shell aliases
  home.shellAliases = {
    # Network debugging
    myip = "curl -s https://ipinfo.io/ip";
    ports = "netstat -tulanp";
  };
}
