-- Based on https://github.com/nvim-mini/mini.nvim/discussions/500
-- TODO: create_hsl_matcher for multiple patterns!
-- Learn how hsl_to_rgb work
local function hsl_to_rgb(h, s, l)
  h, s, l = h % 360, s / 100, l / 100
  if h < 0 then
    h = h + 360
  end
  local function f(n)
    local k = (n + h / 30) % 12
    local a = s * math.min(l, 1 - l)
    return l - a * math.max(-1, math.min(k - 3, 9 - k, 1))
  end
  return f(0) * 255, f(8) * 255, f(4) * 255
end

function create_hsl_matcher(pattern)
  if pattern == nil then
    error('no pattern provided')
  end

  return function(_, match)
    local hipatterns = require('mini.hipatterns')

    local style = 'bg'
    local hue, saturation, lightness = match:match(pattern)

    local red, green, blue = hsl_to_rgb(hue, saturation, lightness)
    local hex = string.format('#%02x%02x%02x', red, green, blue)
    return hipatterns.compute_hex_color_group(hex, style)
  end
end

local M = {
  'echasnovski/mini.hipatterns',
  opts = {
    highlighters = {
      fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
      hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
      todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
      note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
      hsl_color = {
        pattern = 'hsl%(%d+ ?%d+%% ?%d+%%%)',
        group = create_hsl_matcher('hsl%((%d+) ?(%d+)%% ?(%d+)%%%)'),
      },
      hsl_color_comma = {
        pattern = 'hsl%(%d+, ?%d+%%, ?%d+%%%)',
        group = create_hsl_matcher('hsl%((%d+), ?(%d+)%%, ?(%d+)%%%)'),
      },
    },
  },
}

function M.config(_, opts)
  local hipatterns = require('mini.hipatterns')

  opts.highlighters.hex_color = hipatterns.gen_highlighter.hex_color()
  hipatterns.setup(opts)
end

return M
