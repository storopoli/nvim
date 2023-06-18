return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "alex",
        "bash-language-server",
        "black",
        "clangd",
        "css-lsp",
        "dockerfile-language-server",
        "eslint-lsp",
        "flake8",
        "gopls",
        "html-lsp",
        "isort",
        "js-debug-adapter",
        "json-lsp",
        "julia-lsp",
        "lua-language-server",
        "luacheck",
        "markdownlint",
        "marksman",
        "prettierd",
        "proselint",
        "pyright",
        "ruff",
        "rust-analyzer",
        "rustfmt",
        "shellcheck",
        "shellharden",
        "shfmt",
        "stylua",
        "texlab",
        "typescript-language-server",
        "typst-lsp",
        "write-good",
        "yaml-language-server",
      })
    end,
  },
  {
    "goolord/alpha-nvim",
    opts = function(_, dashboard)
      -- alpha button table
      local tbl = dashboard.section.buttons.val

      -- Mason button
      local mason_button = dashboard.button("m", " " .. " Mason", ":Mason <CR>")
      mason_button.opts.hl = "AlphaButtons"
      mason_button.opts.hl_shortcut = "AlphaShortcut"

      -- Calculate the index of the second to last position
      local idx = #tbl -- (#tbl gives the size of the table)

      -- Insert the Mason button at the second to last position
      table.insert(dashboard.section.buttons.val, idx, mason_button)
    end,
  },
}
