{
  description = "Example Rust development environment";

  # Flake inputs
  inputs = {
    # Latest stable Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # A helper library for Rust + Nix
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  # Flake outputs
  outputs =
    {
      self,
      nixpkgs,
      rust-overlay,
    }:
    let
      # Overlays enable you to customize the Nixpkgs attribute set
      overlays = [
        # Makes a `rust-bin` attribute available in Nixpkgs
        (import rust-overlay)
        # Provides a `rustToolchain` attribute for Nixpkgs that we can use to
        # create a Rust environment
        (final: prev: {
          rustToolchain = prev.rust-bin.stable.latest.default;
        })
      ];

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
            pkgs = import nixpkgs { inherit overlays system; };
          }
        );
    in
    {
      # Development environment output
      devShells = forAllSystems (
        { pkgs }:
        {
          default = pkgs.mkShell {
            # This is so that rust-analyzer can find the source code
            RUST_SRC_PATH = "${
              pkgs.rust-bin.stable.latest.default.override {
                extensions = [ "rust-src" ];
              }
            }/lib/rustlib/src/rust/library";

            # The Nix packages provided in the environment
            packages =
              (with pkgs; [
                # The package provided by our custom overlay. Includes cargo, Clippy, cargo-fmt,
                # rustdoc, rustfmt, and other tools.
                rustToolchain
              ])
              ++ pkgs.lib.optionals pkgs.stdenv.isDarwin (with pkgs; [ libiconv ]);
          };
        }
      );
    };
}
