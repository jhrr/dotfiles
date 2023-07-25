{ pkgs, ... }:
{
  services.nix-daemon.enable = true;
  services.nix-daemon.package = pkgs.nixFlakes;

  homebrew = {
    enable = true;
    autoUpdate = true;
    casks = [
      # TODO: port from gist
    ];
  };
}
