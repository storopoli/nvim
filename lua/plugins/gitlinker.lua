return {
  "linrongbin16/gitlinker.nvim",
  event = "VeryLazy",
  cmd = "GitLink",
  opts = {},
  keys = {
    { "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank Git link (GitLinker)" },
    { "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open Git link (GitLinker)" },
  },
}
