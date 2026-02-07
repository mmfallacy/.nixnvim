local M = {}

function M.enable_statusline_hl()
  local hl_normal = vim.api.nvim_get_hl(0, { name = 'MiniStatuslineModeNormal' })

  vim.api.nvim_set_hl(0, 'SupermavenOn', { fg = '#A3BE8C', bg = hl_normal.bg, bold = true }) -- green
  vim.api.nvim_set_hl(0, 'SupermavenOff', { fg = '#BF616A', bg = hl_normal.bg, bold = true }) -- red
end

function M.statusline_status()
  if _G.supermaven_enabled then
    return '%#SupermavenOn# 󰚩 %*'
  else
    return '%#SupermavenOff# 󱚧 %*'
  end
end

return M
