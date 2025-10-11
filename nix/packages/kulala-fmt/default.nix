{
  lib,
  fetchFromGitHub,
  bun,
  stdenvNoCC,
  runtimeShell,
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

  nativeBuildInputs = [ bun ];

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

    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild

    mkdir -p $out
    # Use package.json build script (rollup) and pass extra args
    bun run build --compact
    cp -r . $out

    runHook postBuild
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
