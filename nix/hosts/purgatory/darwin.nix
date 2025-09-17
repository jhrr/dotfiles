{ pkgs, ... }:
{
  services.nix-daemon.enable = true;
  services.nix-daemon.package = pkgs.nixFlakes;

  users = {
    users.jhrr = {
      home = /Users/jhrr;
    };
  };

  homebrew = {
    enable = true;
    autoUpdate = true;
    casks = [
      # TODO: port from mac log gist
    ];
  };

  # Configure macOS settings.
  system.defaults.dock.autohide = false;
  system.defaults.dock.show-recents = false;
}
