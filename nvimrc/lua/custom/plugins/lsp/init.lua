local M = {
  'neovim/nvim-lspconfig',
}

M.event = { 'BufReadPre', 'BufNewFile' }
M.dependencies = {
  { 'saghen/blink.cmp', optional = true },
  { 'hrsh7th/nvim-cmp', optional = true },
}

---@class Opts
---@field enabled string[]
M.opts = {
  enabled = {
    'lua_ls',
    'nil_ls',
    'nixd',
    'rust_analyzer',
    'zls',
    'bashls',
    'cssls',
    'jsonls',
    'emmet_language_server',
    'tailwindcss',
    'buf_ls',
    'harper_ls',
    'tinymist',
    'marksman',
    'gopls',
    'svelte',
    'postgres_lsp',
  },
}

M.config =
  ---@param opts Opts
  function(_, opts)
    local installed = {}

    vim.lsp.config('*', {
      capabilities = require('custom.plugins.lsp.default_capabilities')(),
      on_attach = require('custom.plugins.lsp.default_on_attach'),
    })

    for _, server in ipairs(opts.enabled) do
      if vim.fn.executable(vim.lsp.config[server].cmd[1]) == 1 then
        table.insert(installed, server)
        vim.lsp.enable(server)
      else
      end
    end
    vim.notify_once(vim.inspect(installed), vim.log.levels.INFO, { title = 'LSPs found and configured' })
  end

return M
