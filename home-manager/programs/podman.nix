{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    podman
    podman-compose
    # podman-desktop
  ];

  # Configure Podman to disable compose warning
  xdg.configFile."containers/containers.conf".text = ''
    [engine]
    compose_warning_logs = false
  '';

  home.shellAliases = {
    docker = "podman";
    docker-compose = "podman-compose";
  };

  # Uncomment the following to enable Podman socket for Docker API compatibility
  # This is needed if you want to use tools that expect Docker's REST API
  # or if you want to use DOCKER_HOST environment variable above
  #
  # home.sessionVariables = {
  #  # Use Podman as Docker replacement
  #  DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock";
  #};
  #
  # systemd.user.services.podman = {
  #   Unit = {
  #     Description = "Podman API Service";
  #     Requires = "podman.socket";
  #     After = "podman.socket";
  #     Documentation = "man:podman-system-service(1)";
  #     StartLimitIntervalSec = 0;
  #   };
  #   Service = {
  #     Type = "exec";
  #     # Start the Podman system service which provides the REST API
  #     ExecStart = "${pkgs.podman}/bin/podman system service";
  #     Environment = "LOGGING=--log-level=info";
  #     Restart = "on-failure";
  #     RestartSec = 1;
  #   };
  #   Install = {
  #     WantedBy = [ "default.target" ];
  #   };
  # };
  #
  # systemd.user.sockets.podman = {
  #   Unit = {
  #     Description = "Podman API Socket";
  #     Documentation = "man:podman-system-service(1)";
  #   };
  #   Socket = {
  #     # Unix socket path where the API will be available
  #     ListenStream = "/run/user/1000/podman/podman.sock";
  #     SocketMode = "0660";
  #   };
  #   Install = {
  #     # Enable socket activation - service starts when something connects
  #     WantedBy = [ "sockets.target" ];
  #   };
  # };
}
