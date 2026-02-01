local const = {
  hostname = vim.env.FLAKE_HOSTNAME,
  flake = vim.env.FLAKE,
}
---@type vim.lsp.Config
return const.hostname
    and const.flake
    and {
      settings = {
        nixd = {
          options = {
            nixos = {
              expr = '(builtins.getFlake "' .. const.flake .. '").nixosConfigurations.' .. const.hostname .. '.options',
            },
            home_manager = {
              expr = '(builtins.getFlake "'
                .. const.flake
                .. '").nixosConfigurations.'
                .. const.hostname
                .. '.options.home-manager.users.type.getSubOptions []',
            },
          },
        },
      },
    }
  or {}
