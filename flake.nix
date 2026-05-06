{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems =
        [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];

      perSystem = { pkgs, self', ... }: {
        devShells.default =
          pkgs.mkShell { inputsFrom = [ self'.packages.default ]; };

        packages.default = pkgs.buildGoModule {
          pname = "splitsh-lite";
          version = "2.0.0";
          src = ./.;
          vendorHash = "sha256-Hk08mULIpuPR7Wyyfpd4P0Vrcp9Cu0slUzZXhzK9t0M";

          buildInputs = with pkgs; [ libgit2 ];
          nativeBuildInputs = with pkgs; [ pkg-config ];

          meta.mainProgram = "splitsh-lite";

          postInstall = ''
            mv $out/bin/lite $out/bin/splitsh-lite
          '';
        };

        formatter = pkgs.nixfmt;
      };
    };
}
