let 
	pkgs = import <nixpkgs> {};

in pkgs.buildEnv {
	name = "Marcelo";

	paths = with pkgs; [
		# Desktop environment
		rxvt_unicode
        	xmonad-with-packages

		# Development environment
		git
		fzf
		silver-searcher
		bat # Syntax highlighting

		# Editors
		vim
		vimPlugins.vim-plug
        	sublime3

		# Haskell
		ghc
		cabal-install
		stack
		haskellPackages.ghcid
		haskellPackages.hlint
		haskellPackages.hoogle
		haskellPackages.stylish-haskell
	];
} 
