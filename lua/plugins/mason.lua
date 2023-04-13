return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      "stylua",
      "luacheck",
      "shellcheck",
      -- "deno",
      "shfmt",
      "black",
      "isort",
      "flake8",
    })
  end,
}
