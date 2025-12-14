{
  opencode,
  stdenvNoCC,
  makeWrapper,
  lib,
  wrapperArgs ? [ ],
  cfgLocation ? "${placeholder "out"}/share",
}:
stdenvNoCC.mkDerivation {
  name = "opencode-wrapped";
  buildInputs = [ makeWrapper ];

  src = ../../opencode;

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share

    cp -r $src $out/share/

    makeWrapper ${opencode}/bin/opencode $out/bin/opencode \
      --set XDG_CONFIG_HOME "${cfgLocation}" \
      ${lib.escapeShellArgs wrapperArgs} \
      --run 'echo "$XDG_CACHE_HOME"'
  '';
}
