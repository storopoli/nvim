return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      "stylua",
      "luacheck",
      "shellcheck",
      "rustfmt",
      "prettierd",
      "shfmt",
      "black",
      "isort",
      "flake8",
      "ruff",
      "markdownlint",
      "proselint",
      "write-good",
      "alex",
    })
  end,
}
