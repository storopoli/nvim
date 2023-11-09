return {
  "iamcco/markdown-preview.nvim",
  ft = "markdown",
  event = "VeryLazy",
  cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  keys = {
    { "<leader>m", "<CMD>MarkdownPreview<CR>", desc = "[M]arkdown Preview" },
  },
}
