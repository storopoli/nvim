return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    table.insert(opts.ensure_installed, {
      "stylua",
      "luacheck",
      "shellcheck",
      "rustfmt",
      -- "deno",
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
