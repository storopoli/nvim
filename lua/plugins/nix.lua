-- Use nixd

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "nix" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nixd = {
          mason = false,
        },
      },
    },
  },

  -- Can be removed after this PR is merged: https://github.com/LazyVim/LazyVim/pull/6244
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        nix = { "statix" },
      },
    },
  },

  {
    "mrcjkb/telescope-manix",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("manix")
    end,
    keys = {
      -- {
      --   "<leader>sn",
      --   ft = "nix",
      --   function ()
      --     require('telescope').extensions.manix.manix({cword = true})
      --   end,
      --   desc = "Nix Docs (Word)",
      -- },
      {
        "<leader>sN",
        ft = "nix",
        "<cmd>Telescope manix<cr>",
        desc = "Nix Docs",
      },
    },
  },
}
