local utils = require('custom.utils')

local M = utils.map_ft('http')({
  {
    'rest-nvim/rest.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
    config = function(_, opts)
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'json',
        callback = function()
          vim.bo.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
      })

      vim.api.nvim_create_user_command('Rr', 'Rest run', {})

      vim.g.rest_nvim = opts
    end,
  },
})

return M
