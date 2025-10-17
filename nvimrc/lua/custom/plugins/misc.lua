return {
  { 'tpope/vim-sleuth', event = { 'BufReadPost', 'BufNewFile' } },
  {
    'folke/flash.nvim',
    -- stylua: ignore
    keys = {
        { "f" },
        { "F" },
        { "t" },
        { "T" },
        { "/" },
        { "<c-s>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  } ,
    opts = {
      modes = {
        char = {
          jump_labels = true,
          multiline = false,
        },
      },
    },

    config = function(_, opts)
      require('flash').setup(opts)
      require('flash').toggle(true)
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    cond = false,
    dependencies = {
      { 'franco-ruggeri/codecompanion-lualine.nvim', opts = {} },
    },
    opts = {
      sections = {
        lualine_x = {
          {
            'codecompanion',
            icon = ' ',
            spinner_symbols = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
            done_symbol = '✓',
          },
        },
      },
    },
    event = 'VeryLazy',
  },
}
