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
  local has_cmp, cmp = pcall(require, 'cmp')

  vim.keymap.set({ 'n', 'v', 'i' }, '<S-Tab>', function()
    if _G.supermaven_enabled then
      _G.supermaven_enabled = false
      _G.cmp_enabled = true
      api.stop()
      -- Manually dispose inlay!
      require('supermaven-nvim.completion_preview').on_dispose_inlay()
    else
      _G.supermaven_enabled = true
      _G.cmp_enabled = false

      -- Single line if statement 😆
      _ = has_cmp and cmp.abort()
      api.start()
    end
    vim.cmd('redrawstatus')
  end)
end

return M
