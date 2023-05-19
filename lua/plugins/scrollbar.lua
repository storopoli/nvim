return {
  {
    -- requires neovim nightly
    "lewis6991/satellite.nvim",
    event = "VeryLazy",
    config = true,
    enabled = false,
  },
  {
    "echasnovski/mini.map",
    main = "mini.map",
    event = "VeryLazy",
    enabled = false,
    config = function()
      local map = require("mini.map")
      map.setup({
        integrations = {
          map.gen_integration.builtin_search(),
          map.gen_integration.gitsigns(),
          map.gen_integration.diagnostic(),
        },
      })
      map.open()
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    enabled = false,
    config = function()
      local scrollbar = require("scrollbar")
      local colors = require("tokyonight.colors").setup()
      scrollbar.setup({
        handle = { color = colors.bg_highlight },
        excluded_filetypes = { "prompt", "TelescopePrompt", "noice", "notify" },
        marks = {
          Search = { color = colors.orange },
          Error = { color = colors.error },
          Warn = { color = colors.warning },
          Info = { color = colors.info },
          Hint = { color = colors.hint },
          Misc = { color = colors.purple },
        },
      })
    end,
  },
}
