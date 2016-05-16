# ~/.nixpkgs/config.nix

{ pkgs }: {

  allowUnfree = true;

  packageOverrides = super: let pkgs = super.pkgs; in with pkgs; rec {

    emacs = emacs25pre;
    myVim = pkgs.vim_configurable.override {
      config.vim = {
        ruby = true;
      };
      ruby = ruby;
    };

    vimEnv = pkgs.buildEnv {
      name = "vimEnv";
      paths = [
        myVim
      ];
    };

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
        silver-searcher
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

    cEnv = pkgs.buildEnv {
      name = "cEnv";
      paths = [
        # binutils
        cc
        gdb
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

    langsEnv = pkgs.buildEnv {
      name = "langsEnv";
      paths = [
        clojure
        erlang
        pltScheme
        ruby
        sbcl
      ];
    };

    mlEnv = pkgs.buildEnv {
      name = "mlEnv";
      paths = [
        ocaml
        # smlnj
        ocamlPackages.utop
      ];
    };

    musicEnv = pkgs.buildEnv {
      name = "musicEnv";
      paths = [
        # fftw
        flac
        # libffi
        mpd
        mpg123
        # mpdscribble
        # ncmpcpp
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

    serviceEnv = pkgs.buildEnv {
      name = "serviceEnv";
      paths = [
        nginx
        nodejs
        openjdk8
        postgresql
        redis
        sqlite
        # xquartz
      ];
    };

  };
}
