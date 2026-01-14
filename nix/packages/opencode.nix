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
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/share

    cp -r $src $out/share/

    makeWrapper ${opencode}/bin/opencode $out/bin/opencode \
      --set XDG_CONFIG_HOME "${xdgConfig}" \
      --set OPENCODE_DISABLE_LSP_DOWNLOAD true \
      --set OPENCODE_EXPERIMENTAL_LSP_TOOL true \
      ${lib.escapeShellArgs wrapperArgs}

    runHook postInstall
  '';
}
