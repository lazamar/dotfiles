let
	pkgs = import <nixpkgs> {};

in pkgs.buildEnv {
    name = "marcelo";

    paths = with pkgs; [
        git
        fzf               # Fast file search
        silver-searcher   # Fast string search
        bat               # Syntax highlighting
        powerline-rs      # Prompt with git info
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
