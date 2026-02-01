---@param override lsp.ClientCapabilities|nil
local function get_lsp_capabilities(override)
  local has_cmp, cmp = pcall(require, 'cmp')
  local has_blink, blink = pcall(require, 'blink.cmp')

  local caps = vim.lsp.protocol.make_client_capabilities()

  if override ~= nil then
    caps = vim.tbl_deep_extend('force', caps, override)
  end

  if has_cmp then
    ---@type lsp.ClientCapabilities
    return require('cmp_nvim_lsp').default_capabilities(caps)
  end

  if has_blink then
    -- See https://github.com/neovim/nvim-lspconfig/issues/3494; https://cmp.saghen.dev/installation.html
    ---@type lsp.ClientCapabilities
    return blink.get_lsp_capabilities(caps)
  end

  vim.notify(
    [[ No registered completion engine found! Defaulting to vim LSP Client Capabilities. ]],
    vim.log.levels.WARN,
    { title = 'custom.plugins.lsp.setup' }
  )
  return caps
end

return get_lsp_capabilities
