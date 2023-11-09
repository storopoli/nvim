return {
  {
    "catppuccin/nvim", -- Set colorscheme to Catppuccin Theme
    name = "catppuccin",
    lazy = false,      -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,   -- make sure to load this before all
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        integrations = {
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
          },
          telescope = {
            enabled = true,
            -- style = "nvchad"
          },
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = true,
          fidget = true,
          flash = true,
          indent_blankline = true,
          noice = true,
          which_key = true,
        },
      })
      vim.o.termguicolors = true
      vim.cmd.colorscheme("catppuccin")
    end,
    keys = {
      { "<leader>l", "<CMD>Lazy<cr>", desc = "[L]azy" },
    },
  },
  {
    "nvim-lualine/lualine.nvim", -- Fancier statusline
    event = "VeryLazy",
    dependencies = { "catppuccin/nvim" },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = false,
          theme = "catppuccin",
          component_separators = "|",
          section_separators = "",
        },
      })
    end,
  },
}
