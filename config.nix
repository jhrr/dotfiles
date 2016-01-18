# ~/.nixpkgs/config.nix

{ pkgs }: {

  allowUnfree = true;
  packageOverrides = super: let pkgs = super.pkgs; in with pkgs; rec {
  
    userEnv = pkgs.buildEnv {
      name = "jhrrEnv";
      paths = [
        ack
        clang
        cmake
        ctags
        curl
        emacs24Macport
        ghc
        git
        gitAndTools.hub
        gnupg
        less
        llvm
        nix-repl
        nox
        pass
        python27Full
        python35
        rsync
        stack
        tig
        tree
        vim
        yank
      ];
    };
  };
}

# emacs = if pkgs.stdenv.isDarwin
#         then pkgs.emacs24Macport
#         else pkgs.emacs24;
