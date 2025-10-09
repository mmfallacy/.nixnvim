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
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  } ,
    opts = {
      modes = {
        char = {
          jump_labels = true,
          multiline = false,
        },
      },
    },
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

  {
    'Eutrius/Otree.nvim',
    lazy = false,
    dependencies = {
      'stevearc/oil.nvim',
    },
    config = function()
      require('Otree').setup()
    end,
  },
}
