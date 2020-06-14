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

		vim

		stack
		haskellPackages.ghcid
		haskellPackages.hlint
	];
}
