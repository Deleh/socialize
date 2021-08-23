{
  description = "Socialize web page";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:

    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {

          # Package
          packages.socialize =
            pkgs.stdenv.mkDerivation {
              name = "socialize";
              src = self;
              installPhase = ''
                install -m 444 -D index.html $out/index.html
                install -m 444 -D favicon.png $out/favicon.png
              '';
            };
          defaultPackage = self.packages.${system}.socialize;
        }

      );
}
