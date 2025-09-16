local M = {}

local utils = require('custom.plugins.ai.utils')

function M.check(opts)
  local providers = {
    opts.strategies.chat.adapter,
    opts.strategies.inline.adapter,
    opts.strategies.cmd.adapter,
  }

  for _, provider in ipairs(providers) do
    if utils.has_missing_key(provider) then
      return vim.notify(
        [[codecompanion.nvim cannot find your API key for provider ]] .. provider .. [[!]],
        vim.log.levels.ERROR
      )
    end

    -- If provider is an acp provider
    if opts.adapters.acp[provider] ~= nil then
      local provider_opts = opts.adapters.acp[provider]
      local commands = nil

      if type(provider_opts) == 'function' then
        commands = provider_opts().commands
      elseif type(provider_opts) == 'table' then
        commands = provider_opts.commands
      else
        return vim.notify(
          [[custom.plugins.ai.codecompanion.checks does not support non function or non table adapter opts]],
          vim.log.levels.ERROR
        )
      end

      for _, command in pairs(commands) do
        if vim.fn.executable(command[1]) ~= 1 then
          return vim.notify(
            [[codecompanion.nvim cannot find the required executable for  acp provider ]]
              .. provider
              .. [[:]]
              .. command[1]
              .. [[!]],
            vim.log.levels.ERROR
          )
        end
      end
    end
  end
end

return M
