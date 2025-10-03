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
        [[Cannot find your API key for provider ]] .. provider .. [[!]],
        vim.log.levels.ERROR,
        { title = 'codecompanion.nvim' }
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
          [[Non-function or non-table adapter opts not supported]],
          vim.log.levels.ERROR,
          { title = 'custom.plugins.ai.codecompanion.checks' }
        )
      end

      for _, command in pairs(commands) do
        if vim.fn.executable(command[1]) ~= 1 then
          return vim.notify(
            [[Cannot find the required executable for ACP provider ]] .. provider .. [[:]] .. command[1] .. [[!]],
            vim.log.levels.ERROR,
            { title = 'codecompanion.nvim' }
          )
        end
      end
    end
  end
end

return M
