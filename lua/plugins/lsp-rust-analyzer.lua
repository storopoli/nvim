return {
  -- add texlab custom options to lspconfig
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      -- texlab will be automatically installed with mason and loaded with lspconfig
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            procMacro = { enable = true },
            cargo = { allFeatures = true },
            checkOnSave = {
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
          },
        },
      },
    },
  },
}
