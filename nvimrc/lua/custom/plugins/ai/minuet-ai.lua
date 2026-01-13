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
    api_key = 'GROK_API_KEY',
    end_point = 'https://api.x.ai/v1/chat/completions',
    model = 'grok-4-1-fast-non-reasoning',
    name = 'Grok Code Fast 1',
    optional = {
      temperature = 0.5,
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
