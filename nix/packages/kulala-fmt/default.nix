{
  lib,
  fetchFromGitHub,
  bun,
  stdenvNoCC,
  runtimeShell,
  stdenv,
  makeWrapper,
}:
let
  pin = lib.importTOML ./pin.toml;

  src = fetchFromGitHub {
    owner = "mistweaverco";
    repo = "kulala-fmt";
    rev = "v${pin.src.version}";
    hash = pin.src.hash;
  };

  dependencies = stdenvNoCC.mkDerivation {
    pname = "kulala-fmt-node_modules";
    inherit src;
    version = pin.src.version;

    # Set up network access for bun install
    impureEnvVars = lib.fetchers.proxyImpureEnvVars ++ [
      "GIT_PROXY_COMMAND"
      "SOCKS_SERVER"
    ];

    nativeBuildInputs = [
      bun
    ];
    buildPhase = ''
      runHook preBuild

      export BUN_INSTALL_CACHE_DIR=$(mktemp -d)

      bun install \
        --no-progress \
        --frozen-lockfile \
        --force \
        --ignore-scripts \

        # --ignore-script to prevent node-gyp-build from running when installing @mistweaverco/tree-sitter-kulala

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/node_modules
      cp -R ./node_modules $out

      runHook postInstall
    '';

    outputHash = pin.dependencies.${stdenvNoCC.system}.hash;
    outputHashAlgo = "sha256";
    outputHashMode = "recursive";
  };
in
# Use finalAttrs to respect overrides
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "kulala-fmt";
  version = pin.src.version;
  inherit src;

  node_modules = dependencies;

  nativeBuildInputs = [
    bun
    makeWrapper
  ];

  # Bun will be used in $out/bin/kulala-fmt
  propagatedBuildInputs = [ bun ];

  configurePhase = ''
    runHook preConfigure

    # Copy dependencies and make modifiable for patching shebangs
    cp -R ${finalAttrs.node_modules}/node_modules .
    chmod -R u+w node_modules

    # Since bun should be a drop-in replacement for node,
    # Create a shim that uses `bun` as `node` so patchShebangs uses `bun`
    # without a need to pull in the nodejs runtime.
    mkdir -p shims/bin
    pushd shims/bin

    cat > node <<'EOF'
    #!${runtimeShell}
    exec ${bun}/bin/bun "$@"
    EOF

    chmod +x node 
    export PATH="$PATH:$PWD"

    popd

    # Patch shebangs to use shim
    patchShebangs node_modules

    # Run install scripts of dependencies
    # NOTE: THIS DOES NOT WORK
    # Unfortunately, `bun install --include-scripts` does not work like `npm rebuild`
    bun install \
      --no-progress\
      --production \
      --include-scripts

    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild
    # Use package.json build script (rollup) and pass extra args
    bun run build --compact

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp package.json $out
    cp -R dist $out/dist
    cp -R shims $out/shims
    cp -R node_modules $out/node_modules

    mkdir -p $out/bin
    pushd $out/bin

    cat > kulala-fmt <<EOF 
    #!${runtimeShell}
    exec ${bun}/bin/bun $out/dist/cli.cjs "\$@"
    EOF
    chmod +x kulala-fmt

    popd

    runHook postInstall
  '';

  postFixup = ''
    wrapProgram $out/bin/kulala-fmt --set LD_LIBRARY_PATH "${lib.makeLibraryPath [ stdenv.cc.cc.lib ]}"
  '';

  meta = {
    description = "Opinionated .http and .rest files linter and formatter";
    homepage = "https://github.com/mistweaverco/kulala-fmt";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "kulala-fmt";
    platforms = lib.platforms.all;
  };
})
