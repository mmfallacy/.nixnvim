{
  opencode,
  stdenvNoCC,
  makeWrapper,
}:
stdenvNoCC.mkDerivation {
  name = "opencode-wrapped";
  buildInputs = [ makeWrapper ];
  src = ./.;

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/opencode

    cp -r $src/opencode.json $out/share/opencode

    makeWrapper ${opencode}/bin/opencode $out/bin/opencode \
      --set XDG_CONFIG_HOME "$out/share"
  '';
}
