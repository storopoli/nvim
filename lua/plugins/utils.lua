return {
  "tpope/vim-sleuth",                         -- Detect tabstop and shiftwidth automatically
  { "windwp/nvim-autopairs", config = true }, -- Autopair stuff like ({["'
  {
    "kylechui/nvim-surround",                 -- Surround selections
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    version = "*",
    config = true,
  },
}
