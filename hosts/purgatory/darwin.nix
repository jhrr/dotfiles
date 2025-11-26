{ pkgs, ... }: {
  services.nix-daemon.enable = true;
  services.nix-daemon.package = pkgs.nixFlakes;

  users = {
    users.jhrr = {
      home = /Users/jhrr;
    };
  };

  environment = {
    # TODO: devenv? gnupg? pass? here or in home?
    systemPackages = with pkgs; [];
  };

  homebrew = {
    enable = true;
    autoUpdate = true;
    taps = [];
    brews = [];
    casks = [];
  };

  system.defaults.dock.autohide = false;
  system.defaults.dock.show-recents = false;
}
