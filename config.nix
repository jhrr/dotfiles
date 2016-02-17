# ~/.nixpkgs/config.nix

{ pkgs }: {

  allowUnfree = true;
  packageOverrides = super: let pkgs = super.pkgs; in with pkgs; rec {

    emacs = if pkgs.stdenv.isDarwin
            then emacs24Macport
            else emacs24;

    userEnv = pkgs.buildEnv {
      name = "jhrrEnv";
      paths = [
        ack
        clang
        cmake
        coreutils
        ctags
        curl
        gawk
        gdb
        git
        gitAndTools.hub
        # gnupg
        htop
        less
        netcat
        nix-repl
        nmap
        nox
        openssl
        otool
        # pass
        pv
        rsync
        subversion
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
        sqlite
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

    langsEnv = pkgs.buildEnv {
      name = "langsEnv";
      paths = [
        erlang
        ruby
        sbcl
      ];
    };

  };
}

