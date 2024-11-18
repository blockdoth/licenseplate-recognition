{
  description = "A Nix flake default template for a development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forEachSupportedSystem =
        f: nixpkgs.lib.genAttrs supportedSystems (system: f { pkgs = import nixpkgs { inherit system; }; });
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default = pkgs.mkShell {
            shellHook = "
            echo 'Entering a default shell template'
          ";
            packages = with pkgs; [
                 
            ] ++
            (with pkgs.python3Packages; [
              python
              jupyter
              numpy
              pillow
              imageio
              scipy
              matplotlib
              notebook
              scikit-image
              scikit-learn
              pandas
              opencv-python
            ]);
          };
        }
      );
    };
}

