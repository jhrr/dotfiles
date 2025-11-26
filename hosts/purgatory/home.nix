{ pkgs, ... }:
{
  home.username = "jhrr";
  home.homeDirectory = "/Users/jhrr";

  home.packages = with pkgs; [
    bashInteractive
    coreutils
    # cmake  # TODO: Add to emacs config?
    # devenv
    gnuawk
    gnused
    ripgrep
    tig
    tree
  ];

  # TODO: If supported by home-manager use programs.foo, If not, home.packages.
  # programs.bash = {
  #   enable = true;
  #   profileExtra = builtins.readFile ./bash_profile;
  #   initExtra = builtins.readFile ./bashrc;
  #   # TODO: bash-aliases
  # };

  # programs.git = {
  #   enable = true;
  #   userName = "jhrr";
  #   userEmail = "jhrr@users.noreply.github.com";
  #   includes = [{ path = "~/.config/nixpkgs/gitconfig"; }];  # TODO: Better.
  # };

  # programs.direnv = { enable = true; nix-direnv.enable = true; };

  # programs.fzf = {
  #   enable = true;
  #   enableBashIntegration = true; # TODO: Needed??
  #   tmux.enableShellIntegration = true;
  # };

  # programs.tmux = {
  #   enable = true;
  #   terminal = "screen-256color";
  #   secureSocket = false;
  #   extraConfig = builtins.readFile ./tmux.conf;
  # };

  # programs.zoxide = { enable = true; };

  # TODO: Link other files like so.
  # home.file.".inputrc".source = ./inputrc;

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
