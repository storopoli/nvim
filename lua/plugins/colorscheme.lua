return {
  {
    "folke/tokyonight.nvim", -- Set colorscheme to Gruvbox Theme
    lazy = false,            -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,         -- make sure to load this before all
    config = function()
      require("tokyonight").setup({
        transparent = true,
      })
      vim.o.termguicolors = true
      vim.cmd.colorscheme("tokyonight")
    end,
    keys = {
      { "<leader>l", "<CMD>Lazy<cr>", desc = "[L]azy" },
    },
  },
  {
    "nvim-lualine/lualine.nvim", -- Fancier statusline
    event = "VeryLazy",
    dependencies = { "folke/tokyonight.nvim" },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = false,
          theme = "tokyonight",
          component_separators = "|",
          section_separators = "",
        },
      })
    end,
  },
}
