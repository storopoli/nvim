return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "luacheck",
        "shellcheck",
        "shellharden",
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
        "typst-lsp",
        -- "nil", -- fails on macOS
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
