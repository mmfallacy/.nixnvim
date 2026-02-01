---@type vim.lsp.Config
return {
  on_attach = function(_, bufnr)
    -- Disable cssls in place of tailwindcss
    vim.lsp.get_clients({ bufnr = bufnr, name = 'cssls' })[1].stop()
  end,
}
