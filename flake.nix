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
        packages = flake-utils.lib.flattenTree ( with pkgs; recurseIntoAttrs {
          web = recurseIntoAttrs {
            chrome = recurseIntoAttrs {
              stable = google-chrome;
              beta = google-chrome-beta;
              unstable = google-chrome-dev;
            };
          };
          music = recurseIntoAttrs {
            inherit
              spotify
            ;
          };
          office = recurseIntoAttrs {
            inherit
              wpsoffice
            ;
          };
          talk = recurseIntoAttrs {
            inherit
              zoom-us
            ;
          };
          remote = recurseIntoAttrs {
            inherit
              citrix_workspace
            ;
          };
          dev = recurseIntoAttrs {
            ide = recurseIntoAttrs {
              code = recurseIntoAttrs {
                inherit vscode;
                inherit (vscode-extensions.alanz) vscode-hie-server;
                inherit (vscode-extensions.haskell) haskell;
                inherit (vscode-extensions.ms-vscode) cpptools;
                inherit (vscode-extensions.ms-vsliveshare) vsliveshare;
              };
            };
          };
          # inherit gitAndTools;
        });
      }
    );
}

