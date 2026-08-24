return {
  {
    'folke/snacks.nvim',
    opts = {
      bigfile = {
        setup = function(ctx)
          vim.bo[ctx.buf].syntax = ''

          vim.opt_local.foldmethod = 'manual'
          vim.opt_local.foldenable = false
          vim.opt_local.foldexpr = '0'

          vim.opt_local.statuscolumn = ''
          vim.opt_local.signcolumn = 'no'
          vim.opt_local.cursorline = false
          vim.opt_local.cursorcolumn = false
          vim.opt_local.wrap = false

          vim.b[ctx.buf].bigfile = true
          vim.b[ctx.buf].completion = false
          vim.b[ctx.buf].minianimate_disable = true
          vim.b[ctx.buf].minihipatterns_disable = true

          vim.b[ctx.buf].gitsigns_disable = true
          vim.diagnostic.enable(false, { bufnr = ctx.buf })
        end,
      },
    },
  },
}
