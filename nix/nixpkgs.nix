let
  _pkgs = import <nixpkgs> {};
in
  import (_pkgs.fetchFromGitHub (builtins.fromJSON (builtins.readFile ./nixpkgs.json))) { }
