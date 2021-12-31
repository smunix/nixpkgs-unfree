{
  description = "Nixpkgs / allowUnfree ";

  inputs.nixpkgs.url = "github:NixOs/nixpkgs/master";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.emacs.url = "github:nix-community/emacs-overlay?ref=master";

  outputs = { self, nixpkgs, flake-utils, emacs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            permittedInsecurePackages = [ "xpdf-4.02" ];
          };
	  overlays = [ emacs.overlay ];
        };
      in rec {
        packages = flake-utils.lib.flattenTree (with pkgs;
          recurseIntoAttrs {
            web = recurseIntoAttrs {
              chrome = recurseIntoAttrs {
                stable = google-chrome;
                beta = google-chrome-beta;
                unstable = google-chrome-dev;
              };
            };
            music = recurseIntoAttrs { inherit spotify; };
            office = recurseIntoAttrs { inherit wpsoffice emacsGcc emacsGit; };
            talk = recurseIntoAttrs { inherit discord zoom-us; };
            remote = recurseIntoAttrs { inherit citrix_workspace; };
            dev = recurseIntoAttrs {
              ide = recurseIntoAttrs {
                code = recurseIntoAttrs {
                  inherit vscode;
                  inherit vscode-fhs;
                  inherit (vscode-extensions.alanz) vscode-hie-server;
                  inherit (vscode-extensions.haskell) haskell;
                  inherit (vscode-extensions.ms-vscode) cpptools;
                  inherit (vscode-extensions.ms-vsliveshare) vsliveshare;
                };
              };
            };
            # inherit gitAndTools;
          });
      });
}
