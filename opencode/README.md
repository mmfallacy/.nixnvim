# .nixnvim/opencode

This directory holds my configuration files for `opencode`. Also, `opencode` is made to treat this directory as `$XDG_CONFIG_HOME/opencode` which allows me to specify global overridable configuration.

The package `.nixnvim/nix/packages/opencode.nix` takes in `cfgLocation` as a parameter to enable out-of-store configuration linking. That is, it allows us to mock `$XDG_CONFIG_HOME`, which the `opencode` package will look for global configuration and global plugins.
