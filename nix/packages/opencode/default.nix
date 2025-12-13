{
  opencode,
  stdenvNoCC,
  makeWrapper,
  lib,
  wrapperArgs ? [ ],
}:
stdenvNoCC.mkDerivation {
  name = "opencode-wrapped";
  buildInputs = [ makeWrapper ];
  src = ./config;

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/opencode

    cp -r $src/. $out/share/opencode

    makeWrapper ${opencode}/bin/opencode $out/bin/opencode \
      --set XDG_CONFIG_HOME "$out/share" \
      ${lib.escapeShellArgs wrapperArgs}
  '';
}
