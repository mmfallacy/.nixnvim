local utils = require('custom.plugins.ai.utils')
local system_prompt = require('custom.plugins.ai.codecompanion.system_prompt')

local N = {
  'ollimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'franco-ruggeri/codecompanion-spinner.nvim',
    'Davidyz/vectorcode.nvim',
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
      '<leader>a',
      '<cmd>CodeCompanionChat Add<CR>',
      desc = 'Add code to a chat buffer',
      mode = { 'v' },
    },
  },
}

N.opts = {
  opts = {
    system_prompt = system_prompt,
  },
  strategies = {
    chat = { adapter = 'gemini_cli_flash' },
    inline = { adapter = 'gemini_cli_flash' },
  },
  adapters = {
    http = { opts = { show_defaults = false } },
    acp = { opts = { show_defaults = false } },
  },
  extensions = {
    spinner = {},
  },
}

function N.config(_, opts)
  opts.adapters.http.gemini = function()
    return require('codecompanion.adapters').extend('gemini', {
      env = {
        api_key = vim.env.GEMINI_API_KEY,
      },
      schema = {
        model = {
          default = 'gemini-2.5-flash-lite',
        },
      },
    })
  end

  opts.adapters.acp.gemini_cli_flash = function()
    return require('codecompanion.adapters').extend('gemini_cli', {
      formatted_name = 'Gemini CLI 2.5 Flash',
      commands = {
        default = {
          'gemini',
          '-m',
          'gemini-2.5-flash',
          '--experimental-acp',
        },
      },
      defaults = {
        auth_method = 'gemini-api-key',
      },
      env = {
        GEMINI_API_KEY = vim.env.GEMINI_API_KEY,
      },
    })
  end

  opts.adapters.acp.gemini_cli_pro = function()
    return require('codecompanion.adapters').extend('gemini_cli', {
      formatted_name = 'Gemini CLI 2.5 Pro',
      commands = {
        default = {
          'gemini',
          '--experimental-acp',
        },
      },
      defaults = {
        auth_method = 'gemini-api-key',
      },
      env = {
        GEMINI_API_KEY = vim.env.GEMINI_API_KEY,
      },
    })
  end

  if utils.has_missing_key(opts.strategies.chat.adapter) or utils.has_missing_key(opts.strategies.inline.adapter) then
    return vim.notify([[codecompanion.nvim cannot find your API key!]], vim.log.levels.ERROR)
  end
  return require('codecompanion').setup(opts)
end

return N
