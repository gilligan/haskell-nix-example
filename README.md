### simple haskell nix stuff

This is a basically the very simple setup that i am using to work on haskell stuff with nix.

To build the app ...

```
$ nix-build -A simple
```

To get the shell ..
```
$ nix-shell
```

By default ghc843 will be used but you can also specify a different version:
```
$ nix-shell --argstr ghcVersion "ghc822" default.nix -A shell
$ nix-build --argstr ghcVersion "ghc822" default.nix -A simple
```

The nixpkgs version is pinned via nix/nixpkgs.json and can be updated to
the most recent version of the nixpkgs-unstable channel:

```
$ ./scripts/update-nixpkgs.sh
```
