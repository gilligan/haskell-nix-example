#!/usr/bin/env nix-shell
#!nix-shell -i bash -p curl jq moreutils

set -e

getGithubUrl () {
    declare rev="$1"
    echo "https://github.com/NixOS/nixpkgs-channels/archive/${rev}.tar.gz"
}

echo "Fetching upstream revision and SHA from nixpkgs-unstable ..."
REV=$(curl --silent -L https://nixos.org/channels/nixpkgs-unstable/git-revision)
SHA=$(nix-prefetch-url --type sha256 --unpack $(getGithubUrl "$REV") 2>/dev/null)

echo "Updating revision and SHA in \"./nix/nixpkgs.json\" ..."
jq --indent 4 ".rev = \"$REV\" | .sha256 = \"$SHA\"" ./nix/nixpkgs.json | sponge ./nix/nixpkgs.json

echo "Done."
