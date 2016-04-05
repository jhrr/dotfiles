# ~/.nixpkgs/config.nix

{ pkgs }: {

  allowUnfree = true;

  packageOverrides = super: let pkgs = super.pkgs; in with pkgs; rec {

    emacs = emacs25pre;
    # vim = pkgs.vim_configurable.override {
    #   ruby = true;
    #   x11 = false;
    # };

    # vimEnv = pkgs.buildEnv {
    #   name = "vimEnv";
    #   paths = [
    #     vim
    #   ];
    # };

    userEnv = pkgs.buildEnv {
      name = "jhrrEnv";
      paths = [
        ack
        coreutils
        ctags
        curl
        emacs
        gawk
        git
        gitAndTools.hub
        gnumake
        htop
        # inconsolata-lgc
        less
        netcat
        nix-repl
        nmap
        pv
        rsync
        subversion
        tig
        tmux
        tree
        unzip
        # weechat
        wget
        yank
        yuicompressor
      ];
    };

    cryptoEnv = pkgs.buildEnv {
      name = "cryptoEnv";
      paths = [
        gnupg
        # gnupg-agent (?)
        # openssh
        openssl
        # keychain
        pass
      ];
    };

    cEnv = pkgs.buildEnv {
      name = "cEnv";
      paths = [
        # binutils
        cc
        gdb
      ];
    };

    musicEnv = pkgs.buildEnv {
      name = "musicEnv";
      paths = [
        # fftw
        flac
        # libffi
        # mpd
        mpg123
        # mpdscribble
        # ncmpcpp
      ];
    };

    serviceEnv = pkgs.buildEnv {
      name = "serviceEnv";
      paths = [
        nginx
        nodejs
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
        # Packages
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
        pltScheme
        ruby
        sbcl
      ];
    };

  };
}
