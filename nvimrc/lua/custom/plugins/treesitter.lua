local M = {
  'nvim-treesitter/nvim-treesitter',
  dependencies = { 'nvim-treesitter/nvim-treesitter-context' },
}

local N = {
  'nvim-treesitter/nvim-treesitter-context',
  opts = {},
}

M.keys = {
  {
    'c[',
    function()
      require('treesitter-context').go_to_context()
    end,
  },
}

M.event = { 'BufReadPost', 'BufNewFile' }

M.opts = {
  indent = {
    enable = true,
  },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  context_commentstring = {
    enable = true,
  },
}

local ensure_installed = {
  -- Based on LazyVim's default ensure_installed.
  'bash',
  'c',
  'diff',
  'html',
  'javascript',
  'jsdoc',
  'json',
  'lua',
  'luadoc',
  'luap',
  'markdown',
  'markdown_inline',
  'printf',
  'python',
  'query',
  'regex',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'xml',
  'yaml',
  -- Self
  'nix',
  'http',
  -- Go
  'go',
  'gomod',
  'gosum',
  -- Svelte
  'svelte',
}

-- This function checks if ensure_installed matches the available parsers. If not, it warns the user.
local function check_parsers()
  -- form set of installed parsers
  local installed = vim.iter(vim.api.nvim_get_runtime_file('parser/*.so', true)):fold({}, function(set, path)
    local parser = vim.fn.fnamemodify(path, ':t:r')
    set[parser] = true
    return set
  end)

  -- calculate and notify diff of ensured_installed
  local diff = vim
    .iter(ensure_installed)
    :filter(function(parser)
      return not installed[parser]
    end)
    :totable()

  if #diff > 0 then
    vim.notify_once(
      'ensured_installed parsers not met. ' .. vim.inspect(diff) .. ' are missing!',
      vim.log.levels.WARN,
      { title = 'plugins/treesitter.lua: ' }
    )
  end
end

function M.config(_, opts)
  require('nvim-treesitter').setup(opts)
  check_parsers()

  vim.api.nvim_create_autocmd({ 'FileType' }, {
    callback = function()
      local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
      local has_parser = vim.treesitter.language.add(lang or vim.bo.filetype)
      if has_parser then
        vim.opt.foldmethod = 'expr'
        vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      else
        vim.opt.foldmethod = 'syntax'
      end
      vim.opt.foldenable = true
    end,
  })
end

return {
  N,
  M,
}
