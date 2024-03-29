{
  description = ''
    Flake Basic Dev Environment Template

    $ nix develop  # activate devShell
    $ nix run      # build and run application
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    # warning: input 'flake-utils' has an override for a non-existent input 'nixpkgs'
    # flake-utils.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ] (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        buildInputs = [
          pkgs.hello
        ];
      in {
        devShell = pkgs.mkShell {
          buildInputs = buildInputs;
          shellHook = ''
            echo "Welcome to the Nix develop environment!"
            hello
          '';
        };
        packages.default = pkgs.stdenv.mkDerivation {
          name = "example_app";
          src = self;
          buildInputs = buildInputs;
          buildPhase = ''
            echo '#!/bin/bash' > example_app && echo 'echo "run example_app successfully"' >> example_app
            chmod +x example_app
          '';
          installPhase = ''
            mkdir -p $out/bin
            cp example_app $out/bin/
          '';
        };
      }
    );
}
