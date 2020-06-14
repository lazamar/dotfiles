let
	pkgs = import <nixpkgs> {};

in pkgs.buildEnv {
	name = "Marcelo";

	paths = with pkgs; [
		git
		fzf               # Fast file search
		silver-searcher   # Fast string search
		bat               # Syntax highlighting

		vim

		stack
		haskellPackages.ghcid
		haskellPackages.hlint
	];
}
