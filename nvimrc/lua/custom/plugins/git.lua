local M = {
  'lewis6991/gitsigns.nvim',
  opts = {},
  event = 'VeryLazy',
}

local N = {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
  },
  cmd = { 'Neogit', 'G' },
  opts = function()
    -- Create :Git alias for :Neogit
    vim.api.nvim_create_user_command('G', 'Neogit', {})
    return {
      commit_editor = {
        kind = 'split_below',
        staged_diff_split_kind = 'vsplit',
      },
    }
  end,
}

local O = {
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
}

local P = {
  'clabby/difftastic.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'folke/snacks.nvim',
  },
  opts = {
    download = false,
    snacks_picker = {
      enabled = true,
    },
    vcs = 'git',
  },
  config = function(_, opts)
    require('difftastic-nvim').setup(opts)
    -- Prevent and disable updating difftastic via the plugin.
    vim.api.nvim_del_user_command('DifftUpdate')
  end,
  cmd = {
    'Difft',
    'DifftPick',
    'DifftPickRange',
    'DifftClose',
  },
}

local Q = {
  'pwntester/octo.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {},
  config = function(_, opts)
    vim.api.nvim_create_user_command('GP', 'Octo pr list', {})
    vim.api.nvim_create_user_command('GD', 'Octo discussion list', {})
    vim.api.nvim_create_user_command('GI', 'Octo issues list', {})

    return require('octo').setup(opts)
  end,
  cmd = {
    'GP',
    'GD',
    'GI',
  },
}

return {
  M,
  N,
  O,
  P,
  Q,
}
