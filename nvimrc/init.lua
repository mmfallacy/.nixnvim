if mnw == nil then
  return vim.notify(
    [[ You are currently running this configuration
    outside the .nixnvim flake! This configuration
    does not support a non mnw environment ]],
    vim.log.levels.ERROR
  )
end
vim.opt.rtp:prepend(mnw.configDir .. '/pack/mnw/start/lazy.nvim')
-- This contains the overrides for opts to make lazy.nvim work with nix
local opts = {
  dev = {
    -- Handle plugin installation from nix, point lazy to lazy-plugins linkfarm
    path = mnw.configDir .. '/pack/mnw/opt',
    -- Match all plugins for local lazy-plugins sourcing
    patterns = { '' },
    -- Do not fallback to git as the linkfarm is readonly (location inside /nix/store )
    fallback = false,
  },

  performance = {
    reset_packapath = false,
    rtp = {
      reset = false,
    },
  },

  install = {
    -- Disable installation of missing plugins (probably a redundancy as opts.dev.fallback is already false)
    missing = false,
  },
}

-- This contains the overrides for spec to make lazy.nvim work with nix.
local spec = {
  {
    'nvim-treesitter/nvim-treesitter',
    optional = true,
    opts = {
      ensure_installed = {},
    },
  },
  {
    'echasnovski/mini.base16',
    opts = {
      palette = {
        base00 = '#1e1e2e', -- background
        base01 = '#313244', -- lighter bg
        base02 = '#45475a', -- selection bg
        base03 = '#585b70', -- comments, invisibles
        base04 = '#6c7086', -- dark foreground
        base05 = '#cdd6f4', -- default foreground
        base06 = '#f5e0dc', -- light foreground
        base07 = '#b4befe', -- lightest foreground
        base08 = '#f38ba8', -- red (errors)
        base09 = '#fab387', -- orange (warnings)
        base0A = '#f9e2af', -- yellow (annotations)
        base0B = '#a6e3a1', -- green (diff add)
        base0C = '#94e2d5', -- aqua (virtual text)
        base0D = '#89b4fa', -- blue (keywords, links)
        base0E = '#cba6f7', -- purple (functions)
        base0F = '#f2cdcd', -- pink (special, builtin)
      },
    },
  },
}

-- Set lazy.nvim up using custom wrapper
require('custom.lazy').setup(spec, opts)
