local M = { 'echasnovski/mini.statusline', opts = { content = {} }, dependencies = {
  'nvim-tree/nvim-web-devicons',
} }

function filetype()
  local devicons = require('nvim-web-devicons')
  local filetype = vim.bo.filetype
  local icon = devicons.get_icon(vim.fn.expand('%:t'), nil, { default = true })
  return icon .. ' ' .. filetype
end

function M.opts.content.active()
  local ms = require('mini.statusline')

  local mode, mode_hl = ms.section_mode({ trunc_width = 120 })

  local filename = ms.section_filename({ trunc_width = 140 })
  local fileinfo = ms.section_fileinfo({ trunc_width = 120 })
  local git = ms.section_git({ trunc_width = 40 })

  local has_sm, _ = pcall(require, 'supermaven-nvim')
  local custom_sm = require('custom.plugins.ai.supermaven.utils')

  return ms.combine_groups({
    { hl = mode_hl, strings = { mode } },
    { hl = 'MiniStatuslineDevInfo', strings = { git } },
    '%<', -- truncate left if needed
    { hl = 'MiniStatuslineFilename', strings = { filename } },
    '%=', -- right align rest
    { hl = 'MiniStatuslineDevInfo', strings = { filetype() } },
    { strings = { has_sm and custom_sm.statusline_status() or '' } },
  })
end

return M
