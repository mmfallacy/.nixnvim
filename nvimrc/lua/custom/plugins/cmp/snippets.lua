local M = {}

local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

function M.load()
  ls.add_snippets('all', {
    s({
      trig = 'dtutc',
      desc = 'Current UTC datetime in ISO format',
    }, {
      i(1, os.date('%Y-%m-%dT%H:%M:%SZ')),
    }),
  })
end

return M
