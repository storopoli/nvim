return {
  -- add texlab custom options to lspconfig
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      -- texlab will be automatically installed with mason and loaded with lspconfig
      texlab = {
        settings = {
          texlab = {
            build = {
              executable = "tectonic",
              args = {
                "-X",
                "build",
              },
              onSave = true,
            },
            formatterLineLength = 80,
            latexFormatter = "texlab",
          },
        },
      },
    },
  },
}
