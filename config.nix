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
        coreutils
        ctags
        curl
        erlang
        gawk
        # gcc
        gdb
        git
        gitAndTools.hub
        # glib
        # gnupg
        htop
        less
        llvm
        nix-repl
        nmap
        nox
        otool
        # pass
        rsync
        ruby
        sbcl
        tig
        tmux
        tree
        unzip
        vim
        wget
        yank
      ];
    };

    serviceEnv = pkgs.buildEnv {
      name = "serviceEnv";
      paths = [
        nginx
        postgresql
        redis
      ];
    };

    haskellEnv = pkgs.buildEnv {
      name = "haskellEnv";
      paths = [
        ghc
        stack
        # Haskell packages
        haskellPackages.ghc-mod
        haskellPackages.hdevtools
        haskellPackages.ShellCheck
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
