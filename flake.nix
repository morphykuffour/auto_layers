{
  description = "AutoLayers Python Application";

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
        packages.default = pkgs.python3Packages.buildPythonApplication {
          pname = "autolayers";
          version = "0.1.0";
          src = ./.;

          nativeBuildInputs = with pkgs; [
            pkg-config
          ];

          buildInputs = with pkgs; [
            hidapi
            libusb1
          ];

          propagatedBuildInputs = with pkgs.python3Packages; [
            psutil
            pyusb
            hid
          ];

          doCheck = false;

          # Make sure Python can find the package
          postInstall = ''
            pythonPath="$out/${pkgs.python3.sitePackages}"
            mkdir -p $pythonPath
            cp -r autolayers $pythonPath/
          '';
        };

        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/autolayers";
        };
      }
    );
} 