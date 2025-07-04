-- Haskell support
-- Can remove after this PR is merged: https://github.com/LazyVim/LazyVim/pull/6230

return {
  {
    "mrcjkb/haskell-tools.nvim",
    version = false,
    lazy = false, -- This plugin is already lazy
    keys = {
      {
        "<leader>ce",
        ft = "haskell",
        "<cmd>HlsEvalAll<cr>",
        desc = "Haskell Evaluate All",
      },
      {
        "<leader>so",
        ft = "haskell",
        function()
          require("haskell-tools").hoogle.hoogle_signature()
        end,
        desc = "Hoogle (Function Signature)",
      },
      LazyVim.has("telescope.nvim") and {
        "<leader>sO",
        ft = "haskell",
        "<cmd>Telescope hoogle<cr>",
        desc = "Hoogle (Global)",
      } or nil,
      {
        "<leader>fl",
        ft = "haskell",
        function()
          require("haskell-tools").repl.toggle()
        end,
        desc = "GHCi REPL (Package)",
      },
      {
        "<leader>fL",
        ft = "haskell",
        function()
          require("haskell-tools").repl.toggle(vim.api.nvim_buf_get_name(0))
        end,
        desc = "GHCi REPL (Current File)",
      },
    },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        haskell = { "fourmolu" },
        cabal = { "cabal_fmt" },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        haskell = { "hlint" },
      },
    },
  },
}
