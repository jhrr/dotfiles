# Roadmap

- [ ] Finish nixifying dotfiles — move remaining config (bash, git, fzf, tmux, direnv, zoxide) into home-manager; retire the Makefile symlink approach
- [ ] Write a custom prompt executable in Rust — replace the current `prompt` shell script
- [ ] Use Nix to compile Emacs and manage its library dependencies — emacs config will live in a separate repository, to be linked from here
- [ ] Merge dotfiles and emacs config into a single repository organised around the abstraction of a 'machine' rather than per-software groupings
