---@type vim.lsp.Config
return {
  init_options = {
    syntaxProfiles = {
      html = {
        ['self_closing_tags'] = 'xhtml',
      },
    },
  },
}
