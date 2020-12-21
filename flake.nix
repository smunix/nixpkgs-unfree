{
  description = "Nixpkgs / allowUnfree ";

  inputs.nixpkgs.url = "github:NixOs/nixpkgs/master";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
            inherit system;
            config = {
              allowUnfree = true;
              permittedInsecurePackages = [
                "xpdf-4.02"
              ];
            };
          };
      in rec {
        packages = flake-utils.lib.flattenTree {
          inherit (pkgs) hello;
          inherit (pkgs) citrix_workspace;
          inherit (pkgs) google-chrome;
          inherit (pkgs) google-chrome-dev;
          inherit (pkgs) google-chrome-beta;
          inherit (pkgs) spotify;
          inherit (pkgs) zoom-us;
          # inherit (pkgs) gitAndTools;
        };
        defaultPackage = packages.hello;
        apps.hello = flake-utils.lib.mkApp { drv = packages.hello; };
        defaultApp = apps.hello;
      }
    );
}

