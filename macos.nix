{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Core utilities
    ack
    coreutils
    grc
    openssl
  ];

  nix.settings.experimental-features = "nix-command flakes";

  # macOS system settings
  system = {
    stateVersion = 6;
    configurationRevision = null;

    primaryUser = "elliot";

    defaults = {
      # Global settings
      NSGlobalDomain = {
        ApplePressAndHoldEnabled = false; # Disable press-and-hold for keys in favor of key repeat
        KeyRepeat = 1; # Set a really fast key repeat
      };

      finder = {
        FXPreferredViewStyle = "Nlsv"; # List view
        ShowExternalHardDrivesOnDesktop = true; # Show external drives on desktop
        ShowRemovableMediaOnDesktop = true; # Show removable media on desktop
      };


    };
  };

  #homebrew = {
  #  enabled = true;
  #}
}
