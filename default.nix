{ lib, buildGoModule, libgit2, pkg-config, }:

buildGoModule {
  pname = "splitsh-lite";
  version = "2.0.0";
  src = lib.cleanSource ./.;
  vendorHash = "sha256-Hk08mULIpuPR7Wyyfpd4P0Vrcp9Cu0slUzZXhzK9t0M";

  buildInputs = [ libgit2 ];
  nativeBuildInputs = [ pkg-config ];

  meta.mainProgram = "splitsh-lite";

  postInstall = ''
    mv $out/bin/lite $out/bin/splitsh-lite
  '';
}
