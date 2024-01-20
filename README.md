# flake-templates

Nix Flake Templates

## How to use

```console
$ nix flake init -t github:ko-da-k/flake-templates#basic
```

## How to debug

```console
$ cd basic
$ nix develop --no-write-lock-file  # debug devShell
$ nix run --no-write-lock-file      # debug mkDerivation
```
