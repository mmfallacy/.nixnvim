local M = {
  'supermaven-inc/supermaven-nvim',
  event = 'InsertEnter',
  opts = {},
}

function M.config(_, opts)
  require('supermaven-nvim').setup(opts)

  local api = require('supermaven-nvim.api')
  -- Stop by default, opts.condition doesn't seem to work!
  api.stop()
  -- Enable statusline highlights
  local utils = require('custom.plugins.ai.supermaven.utils')
  utils.enable_statusline_hl()

  vim.keymap.set({ 'n', 'v', 'i' }, '<S-Tab>', function()
    _G.supermaven_enabled = not _G.supermaven_enabled
    api.toggle()
    -- Manually dispose inlay!
    require('supermaven-nvim.completion_preview').on_dispose_inlay()
    vim.cmd('redrawstatus')
  end)
end

return M
