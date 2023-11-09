return {
  "folke/flash.nvim", -- Amazing movements
  event = { "BufReadPre", "BufNewFile" },
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end,              desc = "Flash" },
    -- { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" }, -- conflicts with nvim.surround `S`.
    { "r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  },
}
