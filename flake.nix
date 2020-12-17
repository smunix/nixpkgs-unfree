{
  description = "Flake utils demo";

  inputs.nixpkgs.url = "github:NixOs/nixpkgs/master";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  
  outputs = { self, nixpkgs, flake-utils }: {
    packages.x86_64-linux =
      with import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      {
        inherit (pkgs) google-chrome;
        inherit (pkgs) google-chrome-dev;
        inherit (pkgs) google-chrome-beta;
        inherit (pkgs) spotify;
        inherit (pkgs) zoom-us;
      };
  };
}
