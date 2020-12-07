{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/master";
  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  };
}
