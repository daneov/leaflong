{
  description = "General dev config";
  inputs.devConfig.url = "gitlab:dvanoverloop/nix-config?dir=flakes/vim&host=git.bethelservice.org&ref=vim";
  outputs = { self, nixpkgs, devConfig }: let 
    system = "x86_64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};
    sharedVim = devConfig.packages.${system}.default;
    structurize = with pkgs; callPackage ./docs/structurizr.nix {};
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = [ 
        sharedVim
        structurize
        pkgs.jdk22_headless
        pkgs.d2
      ];
    };
  };
}
