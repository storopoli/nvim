return {
  "sindrets/diffview.nvim",
  lazy = false,
  opts = {
    keymaps = {
      view = {
        {
          "n",
          "q",
          "<cmd>DiffviewClose<cr>",
          { desc = "Close Diffview" },
        },
      },
      file_panel = {
        {
          "n",
          "q",
          "<cmd>DiffviewClose<cr>",
          { desc = "Close Diffview" },
        },
      },
      file_history_panel = {
        {
          "n",
          "q",
          "<cmd>DiffviewClose<cr>",
          { desc = "Close Diffview" },
        },
      },
    },
  },
  keys = {
    { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
    { "<leader>gV", "<cmd>DiffviewFileHistory<cr>", mode = { "n", "v" }, desc = "Open Diffview File History" },
  },
}
