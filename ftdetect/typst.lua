-- translate this to lua
-- autocmd! BufRead,BufNewFile *.typ set filetype=typst
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.typ", "*.typst" },
  command = "set filetype=typst",
})
