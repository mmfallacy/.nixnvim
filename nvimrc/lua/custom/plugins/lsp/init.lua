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
    'vtsls',
    'eslint',
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

function get_lsp_config(server)
  local paths = vim.api.nvim_get_runtime_file(('lsp/%s.lua'):format(server), true)
  return vim
    .iter(paths)
    :rev()
    :map(function(file)
      -- propagate failure
      return assert(loadfile(file))()
    end)
    :fold({}, function(acc, frag)
      return vim.tbl_deep_extend('force', acc, frag)
    end)
end

function lsp_can_start(config)
  if type(config.cmd) == 'string' then
    return vim.fn.executable(config.cmd) == 1
  elseif type(config.cmd) == 'table' then
    return vim.fn.executable(config.cmd[1]) == 1
  elseif type(config.cmd) == 'function' then
    return pcall(config.cmd)
  end
end

M.config =
  ---@param opts Opts
  function(_, opts)
    local installed = {}

    vim.lsp.config('*', {
      capabilities = require('custom.plugins.lsp.default_capabilities')(),
      on_attach = require('custom.plugins.lsp.default_on_attach'),
    })

    for _, server in ipairs(opts.enabled) do
      local ok, config = pcall(get_lsp_config, server)

      if not ok then
        vim.notify('cannot get config for server ' .. server .. ':' .. config, vim.log.levels.ERROR)
        goto continue
      end

      if lsp_can_start(config) then
        table.insert(installed, server)
        vim.lsp.enable(server)
      end
      ::continue::
    end
    vim.notify_once(vim.inspect(installed), vim.log.levels.INFO, { title = 'LSPs found and configured' })
  end

return M
