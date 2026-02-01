-- dd functionality on quickfix lists
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    vim.keymap.set('n', 'dd', function()
      local qf = vim.fn.getqflist()
      local idx = vim.fn.line('.')
      table.remove(qf, idx)
      vim.fn.setqflist(qf, 'r')
    end, { buffer = true })
  end,
})

-- .env*
vim.filetype.add({
  pattern = {
    ['.env.*'] = 'sh',
  },
})

return {
  { import = 'custom.plugins.filetype' },
}
