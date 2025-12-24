{
  opencode,
  stdenvNoCC,
  makeWrapper,
  lib,
  wrapperArgs ? [ ],
  # Mock XDG_CONFIG_HOME to allow opencode to use ../../opencode as global overridable configuration.
  xdgConfig ? "${placeholder "out"}/share",
}:
stdenvNoCC.mkDerivation rec {
  name = "opencode-wrapped";
  buildInputs = [ makeWrapper ];

  src = ../../opencode;

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share

    cp -r $src $out/share/

    makeWrapper ${opencode}/bin/opencode $out/bin/opencode \
      --set XDG_CONFIG_HOME "${xdgConfig}" \
      ${lib.escapeShellArgs wrapperArgs}
  '';
}
