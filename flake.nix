{
  description = "AutoLayers - Cross-platform QMK layer management";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            python3
            python3Packages.pip
            python3Packages.setuptools
            python3Packages.wheel
            # System-specific dependencies
            (if stdenv.isDarwin then [
              darwin.apple_sdk.frameworks.CoreFoundation
              darwin.apple_sdk.frameworks.AppKit
            ] else [
              pkg-config
              libusb1
            ])
          ];

          shellHook = ''
            # Create virtual environment if it doesn't exist
            if [ ! -d "venv" ]; then
              python -m venv venv
            fi
            source venv/bin/activate

            # Install required packages
            pip install -r requirements.txt
          '';
        };

        packages.default = pkgs.python3Packages.buildPythonApplication {
          pname = "autolayers";
          version = "0.1.0";
          src = ./.;

          propagatedBuildInputs = with pkgs.python3Packages; [
            # Add your Python dependencies here
            pyusb
            # Add any other required packages
          ];

          # System-specific dependencies
          buildInputs = with pkgs; [
            (if stdenv.isDarwin then [
              darwin.apple_sdk.frameworks.CoreFoundation
              darwin.apple_sdk.frameworks.AppKit
            ] else [
              pkg-config
              libusb1
            ])
          ];
        };
      }
    );
} 