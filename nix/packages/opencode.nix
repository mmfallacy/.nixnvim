{
  opencode,
  stdenvNoCC,
  symlinkJoin,
  makeWrapper,
  lib,
  wrapperArgs ? [ ],
  # Mock XDG_CONFIG_HOME to allow opencode to use ../../opencode as global overridable configuration.
  xdgConfig ? "${placeholder "out"}/share",
  runtimeDeps ? [ ],
}:
let
  opencode-wrapped = stdenvNoCC.mkDerivation {
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
        --prefix PATH : ${lib.makeBinPath runtimeDeps}
        ${lib.escapeShellArgs wrapperArgs}

      runHook postInstall
    '';

    dontCheckForBrokenSymlinks = true;
  };
in
symlinkJoin {
  name = "opencode-with-rtk";

  paths = [
    opencode-wrapped
  ]
  ++ runtimeDeps;
}
