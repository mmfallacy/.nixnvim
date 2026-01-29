local utils = require('custom.utils')

local M = utils.map_ft('lua')({
  {
    'folke/lazydev.nvim',
    opts = {},
    -- Autodisables when .luarc.json is available for other lua projects
  },
})

return M
