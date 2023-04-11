-- override nvim-cmp and add cmp-emoji and cmp-latex-symbols
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-emoji",
    "kdheepak/cmp-latex-symbols",
  },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
    opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
      {
        name = "latex_symbols",
        option = {
          strategy = 1, -- julia
        },
      },
    }))
  end,
}
