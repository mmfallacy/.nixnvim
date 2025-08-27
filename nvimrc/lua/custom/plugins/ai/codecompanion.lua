local utils = require('custom.plugins.ai.utils')

local N = {
  'ollimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },
  keys = {
    {
      '<leader>a',
      '<cmd>CodeCompanionChat Toggle<CR>',
      desc = 'Toggle a chat buffer',
      mode = { 'n', 'v' },
    },
    {
      '<leader><S-A>',
      '<cmd>CodeCompanionChat Add<CR>',
      desc = 'Add code to a chat buffer',
      mode = { 'v' },
    },
  },
}

N.opts = {

  strategies = {
    chat = { adapter = 'gemini' },
    inline = { adapter = 'gemini' },
  },
  adapters = {},
}

function N.config(_, opts)
  opts.adapters.gemini = function()
    return require('codecompanion.adapters').extend('gemini', {
      env = {
        api_key = vim.env.GEMINI_API_KEY,
      },
    })
  end

  if utils.has_missing_key(opts.strategies.chat.adapter) or utils.has_missing_key(opts.strategies.inline.adapter) then
    return vim.notify([[codecompanion.nvim cannot find your API key!]], vim.log.levels.ERROR)
  end
  return require('codecompanion').setup(opts)
end

return N
