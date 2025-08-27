local utils = require('custom.plugins.ai.utils')

local M = {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = false,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',

    -- File selector picker
    'nvim-telescope/telescope.nvim',
    -- Rendering Avante Files
    'MeanderingProgrammer/render-markdown.nvim',
    -- TODO: Image pasting dependency
  },
}

function M.config(_, opts)
  -- ENV KEY checking prior to staring avante
  if utils.has_missing_key(opts.provider) then
    return vim.notify(
      [[avante.nvim cannot find your API key for "]] .. opts.provider .. [[" provider!]],
      vim.log.levels.ERROR
    )
  else
    require('avante').setup(opts)
  end
end

M.opts = {
  provider = 'gemini',
}

return M
