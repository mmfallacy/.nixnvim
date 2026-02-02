-- Enable Lazy Types
require('lazy.types')

---@type LazyPluginSpec
local M = {
  'ThePrimeagen/99',
  enabled = false,
  keys = {
    { '<leader>9f', mode = 'n' },
    { '<leader>9v', mode = 'v' },
    { '<leader>9s', mode = 'v' },
  },
}

function M.config()
  local _99 = require('99')

  _99.setup({
    logger = {
      level = _99.DEBUG,
      print_on_error = true,
    },
    completion = {
      source = 'cmp',
    },
    provider = _99.Providers.OpenCodeProvider,
    model = 'opencode/minimax-m2.1-free',
  })

  vim.keymap.set('n', '<leader>9f', _99.fill_in_function)
  vim.keymap.set('v', '<leader>9v', _99.visual)
  vim.keymap.set('v', '<leader>9s', _99.stop_all_requests)
end

return M
