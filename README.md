# `.nixnvim`

This repository hosts my neovim configuration using Nix and [`mnw`](https://github.com/Gerg-L/mnw).

## How to run?

`nix run github:mmfallacy/.nixnvim`

> [!NOTE]
> Ensure that `nix-command` and `flakes` experimental features are enabled!
> Do this by creating `~/.config/nix/nix.conf` containing
>
> ```
> experimental-features = nix-command flakes
> ```
>
> or adding the flag `--extra-experimental-features 'nix-command flakes'`

```

```

## TODO

- [ ] Investigate why placing treesitter parsers as part of `mnw.plugins.opt` works as intended, while treesitter doesn't see the parsers when placed in `mnw.plugins.start`.
