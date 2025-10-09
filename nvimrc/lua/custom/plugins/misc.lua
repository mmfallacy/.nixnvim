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
    'StackInTheWild/headhunter.nvim',
    opts = {
      register_keymaps = false, -- Disable internal keymaps if using lazy.nvim keys
    },
    keys = {
      { ']g', '<cmd>HeadhunterNext<cr>', desc = 'Go to next Conflict' },
      { '[g', '<cmd>HeadhunterPrevious<cr>', desc = 'Go to previous Conflict' },
      { '<leader>gh', '<cmd>HeadhunterTakeHead<cr>', desc = 'Take changes from HEAD' },
      { '<leader>go', '<cmd>HeadhunterTakeOrigin<cr>', desc = 'Take changes from origin' },
      { '<leader>gb', '<cmd>HeadhunterTakeBoth<cr>', desc = 'Take both changes' },
    },
  },
}
