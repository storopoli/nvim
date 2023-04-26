return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    table.insert(opts.ensure_installed, {
      "stylua",
      "luacheck",
      "shellcheck",
      -- "deno",
      "shfmt",
      "black",
      "isort",
      "flake8",
      "markdownlint",
      "proselint",
      "write-good",
      "alex",
    })
  end,
}
