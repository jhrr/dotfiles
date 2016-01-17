# ~/.nixpkgs/config.nix

{ pkgs }: {

  packageOverrides = super: let pkgs = super.pkgs; in with pkgs; rec {
  
    userEnv = pkgs.buildEnv {
      name = "jhrrEnv";
      paths = [
        clang
        ctags
        emacs24Macport
        ghc
        git
        gitAndTools.hub
        gnupg
        less
        llvm
        nix-repl
        pass
        python27Full
        python3
        stack
        tig
        vim
        yank
      ];
    };
  };
}

