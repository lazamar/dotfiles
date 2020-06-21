let
	pkgs = import <nixpkgs> {};

    # My version of powerline-rs which includes line breaks
    my-powerline-rs = import (builtins.fetchGit {
         name = "powerline-rs-my-fork";
         url = "https://github.com/lazamar/powerline-rs";
         ref = "refs/heads/master";
         rev = "aaeb0a98536c1408c6f579d2afe7b9ff452d3987";
    }) {};

    # Mosh has merged TrueColor support, but it hasn't had
    # a release after that. The last release was in 2017
    mosh-truecolor = pkgs.mosh.overrideDerivation (old: {
        name = "mosh-1.3.2-TrueColor";

        src = pkgs.fetchurl {
            url = "https://github.com/mobile-shell/mosh/archive/03087e7a761df300c2d8cd6e072890f8e1059dfa.tar.gz";
            sha256 = "1v2qlh6jbngizg5c9sfrx4d79a9x3gmi9fjfxdzpjss2i8wkhl8z";
        };

        patches = [];
    });

in pkgs.buildEnv {
    name = "marcelo";

    paths = with pkgs; [
        git
        fzf               # Fast file search
        silver-searcher   # Fast string search
        bat               # Syntax highlighting
        my-powerline-rs   # Prompt with git info
        vim               # Text editor
        neovim            # Text editor
        nodejs            # Needed for neovim completion
        mosh-truecolor    # Better SSH

        stack
        haskellPackages.fast-tags
        haskellPackages.ghcid
        haskellPackages.hlint
    ];
}
