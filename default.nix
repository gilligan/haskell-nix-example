{ ghcVersion ? "ghc843"
, pkgs ? import ./nix/nixpkgs.nix
}:

let 

  inherit (pkgs.haskell.lib) buildStrictly justStaticExecutables overrideCabal;

  ghc = pkgs.haskell.packages."${ghcVersion}";

  cabal2nix = ghc.callCabal2nix;

  addDepsToEnv = drv: deps: drv.env.overrideAttrs(oldAttrs: { buildInputs = [ deps ]; });

  extraDeps = [ pkgs.cabal-install 
                pkgs.haskellPackages.ghcid 
                pkgs.haskellPackages.stylish-haskell 
                simple-ghcid
              ];

  simple-ghcid = pkgs.writeScriptBin "simple-ghcid"
  ''
    ${ghc.ghcid}/bin/ghcid -c "${ghc.cabal-install}/bin/cabal new-repl simple"
  '';

in rec {

  simple = justStaticExecutables (cabal2nix "haskell-nix-example" (pkgs.lib.cleanSource ./.) {});

  shell = addDepsToEnv simple extraDeps;

}
