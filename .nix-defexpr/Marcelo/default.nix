let
	pkgs = import <nixpkgs> {};

    # My version of powerline-rs which includes line breaks
    my-powerline-rs = import (builtins.fetchGit {
         name = "powerline-rs-my-fork";
         url = "https://github.com/lazamar/powerline-rs";
         ref = "refs/heads/master";
         rev = "aaeb0a98536c1408c6f579d2afe7b9ff452d3987";
    }) {};

in pkgs.buildEnv {
    name = "marcelo";

    paths = with pkgs; [
        git
        fzf               # Fast file search
        silver-searcher   # Fast string search
        bat               # Syntax highlighting
        my-powerline-rs   # Prompt with git info
        mosh              # Better ssh
        vim               # Text editor
        neovim            # Text editor
        nodejs            # Needed for neovim completion
        stack
        haskellPackages.fast-tags
        haskellPackages.ghcid
        haskellPackages.hlint
    ];
}
