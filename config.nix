# ~/.nixpkgs/config.nix

{ pkgs }: {

  allowUnfree = true;
  packageOverrides = super: let pkgs = super.pkgs; in with pkgs; rec {

    # emacs = if pkgs.stdenv.isDarwin
    #         then emacs24Macport
    #         else emacs24;

    userEnv = pkgs.buildEnv {
      name = "jhrrEnv";
      paths = [
        ack
        cmake
        coreutils
        ctags
        curl
        gawk
        git
        gitAndTools.hub
        htop
        # inconsolata-lgc
        less
        netcat
        nix-repl
        nmap
        nox
        # otool
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

    # cryptoEnv = pkgs.buildEnv {
    #   name = "cryptoEnv";
    #   paths = [
    #     # gnupg
    #     # openssh
    #     # openssl
    #     # pass
    #   ];
    # };

    cEnv = pkgs.buildEnv {
      name = "cEnv";
      paths = [
        # binutils
        clang
        gdb
      ];
    };

    serviceEnv = pkgs.buildEnv {
      name = "serviceEnv";
      paths = [
        nginx
        node.js
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
        python27
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
