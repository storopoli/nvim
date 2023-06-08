return {
  "ellisonleao/carbon-now.nvim",
  opts = { open_cmd = "open" },
  cmd = "CarbonNow",
  event = "VeryLazy",
  keys = {
    { "<leader>ua", "<cmd>CarbonNow<cr>", desc = "CarbonNow", silent = true },
    { "<leader>ua", ":carbonnow<cr>", desc = "carbon now", silent = true, mode = "v" },
  },
}
