local utils = require('custom.utils')

local FileMinis = utils.map_event('BufReadPost', 'BufNewFile')({
  { 'echasnovski/mini.ai', opts = {} },
  { 'echasnovski/mini.cursorword', opts = {} },
  { 'echasnovski/mini.surround', opts = {} },
  require('custom.plugins.mini.highlight'),
})

local VeryLazyMinis = utils.map_event('VeryLazy')({
  require('custom.plugins.mini.statusline'),
})

return {
  {
    'echasnovski/mini.pairs',
    opts = {},
    event = { 'InsertEnter' },
  },
  {
    'echasnovski/mini.files',
    opts = {
      options = {
        use_as_default_explorer = false,
      },
    },
    lazy = false,
  },
  {
    'echasnovski/mini.splitjoin',
    opts = {},
    keys = { 'gS' },
  },
  {
    'echasnovski/mini.base16',
    lazy = false,
  },
  FileMinis,
  VeryLazyMinis,
}
