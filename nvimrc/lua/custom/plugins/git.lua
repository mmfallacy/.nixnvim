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
      -- NOTE: Neogit currently doesn't support SSH signing.
      -- All commits are signed via the git config option `commit.gpgSign = true`
      -- Do note that signing can still work without gpg being present if `gpg.format = "ssh"`
      -- commit_view = {verify_commit = nil,},
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

return {
  M,
  N,
  O,
}
