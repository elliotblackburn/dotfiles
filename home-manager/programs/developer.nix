{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Language toolchains
    python3
    go

    # Development tools
    terraform
    ansible

    # General CLI tools
    jq
    yq
    numbat

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

  # Development-specific shell aliases
  home.shellAliases = {
    # Network debugging
    myip = "curl -s https://ipinfo.io/ip";
    ports = "netstat -tulanp";
  };
}
