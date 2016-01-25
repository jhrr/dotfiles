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
        erlang
        git
        gitAndTools.hub
        glib
        # gnupg
        less
        llvm
        nix-repl
        # nmap
        nox
        # otool
        # pass
        rsync
        # sbcl
        stack
        tig
        tree
        vim
        yank
      ];
    };

    haskellEnv = pkgs.buildEnv {
      name = "haskellEnv";
      paths = [
        ghc
      ];
    };

    pythonEnv = pkgs.buildEnv {
      name = "pythonEnv";
      paths = [
        python27Full
        python35

        # Python2 packages
        python27Packages.ipython
        python27Packages.virtualenv
        python27Packages.virtualenvwrapper
        python27Packages.flake8

        # Python3 packages
        python35Packages.ipython
      ];
    };
  };
}

# emacs = if pkgs.stdenv.isDarwin
#         then pkgs.emacs24Macport
#         else pkgs.emacs24;
