{
  description = "Example Python development environment";

  # Flake inputs
  inputs = {
    # Latest nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  # Flake outputs
  outputs =
    { self, nixpkgs }:
    let
      # Systems supported
      allSystems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];

      # Helper to provide system-specific attributes
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs allSystems (
          system:
          f {
            pkgs = import nixpkgs { inherit system; };
          }
        );
    in
    {
      # Development environment output
      devShells = forAllSystems (
        { pkgs }:
        {
          default =
            let
              # Use Python 3.13
              python = pkgs.python313;
            in
            pkgs.mkShell {
              # The Nix packages provided in the environment
              packages = [
                (with pkgs; [
                  python
                  uv
                ])

              ];
            };
        }
      );
    };
}
