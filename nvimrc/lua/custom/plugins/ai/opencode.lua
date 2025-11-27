return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    {
      'folke/snacks.nvim',
      opts = {
        input = {},
        picker = {},
        terminal = {},
        styles = {
          terminal = {
            keys = {
              term_normal = {
                '<esc><esc>',
                function()
                  return '<C-\\><C-n>'
                end,
                mode = 't',
                expr = true,
                desc = 'Double escape to normal mode',
              },
            },
          },
        },
      },
    },
  },
  event = 'VeryLazy',
  keys = {
    {
      '<C-a>',
      function()
        require('opencode').ask('@this: ', { submit = true })
      end,
      mode = { 'n', 'x' },
      desc = 'Ask opencode',
    },
    {
      '<C-x>',
      function()
        require('opencode').select()
      end,
      mode = { 'n', 'x' },
      desc = 'Execute opencode action',
    },
    {
      'ga',
      function()
        require('opencode').prompt('@this')
      end,
      mode = { 'n', 'x' },
      desc = 'Add to opencode',
    },
    {
      '<C-.>',
      function()
        require('opencode').toggle()
      end,
      mode = { 'n', 't' },
      desc = 'Toggle opencode',
    },
    {
      '<S-C-u>',
      function()
        require('opencode').command('session.half.page.up')
      end,
      mode = 'n',
      desc = 'opencode half page up',
    },
    {
      '<S-C-d>',
      function()
        require('opencode').command('session.half.page.down')
      end,
      mode = 'n',
      desc = 'opencode half page down',
    },
  },
  config = function(_, opts)
    vim.g.opencode_opts = opts
    vim.o.autoread = true
    -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above  otherwise consider "<leader>o".
    vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
    vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })
  end,
  opts = {},
}
