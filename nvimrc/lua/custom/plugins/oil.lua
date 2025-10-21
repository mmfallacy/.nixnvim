local M = {
  'stevearc/oil.nvim',
  lazy = false,
  opts = {
    delete_to_trash = true,
    view_options = {
      show_hidden = true,
    },
    watch_for_changes = true,

    keymaps = {
      ['gy'] = 'actions.copy_to_system_clipboard',
      ['gp'] = 'actions.paste_from_system_clipboard',
    },
  },
}

function M.config(_, opts)
  require('oil').setup(opts)

  vim.api.nvim_create_user_command('E', 'Oil', {})
  vim.api.nvim_create_user_command('Re', 'Oil .', {})
  vim.api.nvim_create_user_command('Ve', function()
    vim.cmd.vsplit({ mods = { split = 'botright' } })
    vim.cmd('Oil')
  end, {})

  vim.api.nvim_create_user_command('Hexplore', function()
    vim.cmd.split({ mods = { split = 'botright' } })
    vim.cmd('Oil')
  end, {})
end

return M
