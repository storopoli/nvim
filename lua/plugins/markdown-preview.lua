return {
  "iamcco/markdown-preview.nvim",
  ft = "markdown",
  buid = function()
    vim.fn["mkdp#util#install"]()
  end,
  keys = {
    { "<leader>up", vim.cmd.MarkdownPreviewToggle, desc = "Markdown Preview" },
  },
}
