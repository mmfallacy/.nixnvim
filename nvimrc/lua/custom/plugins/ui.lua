return {
  {
    'nvim-tree/nvim-web-devicons',
    opts = {},
    event = 'VeryLazy',
  },
  {
    'folke/snacks.nvim',
    -- According to its README, a couple plugins might require snacks.nvim to be setup early.
    lazy = false,
    opts = {
      indent = {},
      notifier = {
        enabled = true,
      },
      styles = {
        notification = {
          wo = {
            wrap = true,
          },
        },
      },
      image = {},
    },
    init = function()
      vim.api.nvim_create_user_command('NotifierHistory', function()
        Snacks.notifier.show_history()
      end, {})
    end,
  },
  {
    'kyza0d/xeno.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false,
      contrast = 0.1,
    },
    config = function(_, opts)
      local xeno = require('xeno')
      xeno.config(opts)

      xeno.new_theme('xeno-sample', {
        base = '#1e1e1e',
        accent = '#8cbe8c',
      })
    end,
  },
}
