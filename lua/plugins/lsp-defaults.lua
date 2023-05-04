return {
  "neovim/nvim-lspconfig",
  opts = {
    ---@type lspconfig.options
    servers = {
      bashls = {},
      clangd = {},
      cssls = {},
      dockerls = {},
      julials = {},
      html = {},
      gopls = {},
      marksman = {},
      pyright = {},
      typst_lsp = {},
      yamlls = {},
    },
  },
}
