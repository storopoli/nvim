return {
  "iamcco/markdown-preview.nvim",
  ft = "markdown",
  buid = function()
    vim.fn["mkdp#util#install"]()
  end,
  keys = {
    { "<leader>op", vim.cmd.MarkdownPreviewToggle, desc = "Markdown Preview" },
  },
}
