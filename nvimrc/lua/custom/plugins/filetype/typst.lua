local utils = require('custom.utils')

local M = utils.map_ft('typst')({

  {
    'chomosuke/typst-preview.nvim',
    opts = {
      open_cmd = 'chromium --app=%s 2> /dev/null ',

      dependencies_bin = {
        ['tinymist'] = 'tinymist',
        ['websocat'] = 'websocat',
      },
    },

    config = function(_, opts)
      if vim.fn.executable('tinymist') == 0 then
        return vim.notify('failed to find tinymist', vim.log.levels.WARN, { title = 'typst-preview: ' })
      end

      if vim.fn.executable('websocat') == 0 then
        return vim.notify('failed to find websocat', vim.log.levels.WARN, { title = 'typst-preview: ' })
      end

      require('typst-preview').setup(opts)
    end,
  },
})

return M
