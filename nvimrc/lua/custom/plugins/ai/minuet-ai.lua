local M = {
  'milanglacier/minuet-ai.nvim',
  main = 'minuet',
  event = 'InsertEnter',
}

M.opts = {
  virtualtext = {
    auto_trigger_ft = { '*' },
    keymap = {
      accept = '<C-y>',
      accept_line = '<C-S-y>',
      prev = '<C-p>',
      next = '<C-n>',
      dismiss = '<C-x>',
    },
  },
  provider = 'openai_compatible',
}

M.opts.provider_options = {
  openai_compatible = {
    api_key = 'MIMO_API_KEY',
    end_point = 'https://api.xiaomimimo.com/v1/chat/completions',
    model = 'mimo-v2-flash',
    name = 'MiMo V2 Flash',
    optional = {
      temperature = 0.2,
      max_output_tokens = 256,
      reasoning = {
        effort = 'minimal',
      },
    },
  },

  gemini = {
    -- Unfortunately, gemini-2.0-flash is out of the free tier, and to be deprecated by Feb 2026
    model = 'gemma-3-4b',
    api_key = 'GEMINI_FREE_API_KEY',
    optional = {
      generationConfig = {
        maxOutputTokens = 256,
        thinkingConfig = {
          thinkingBudget = 0,
        },
      },
    },
  },
}

return M
