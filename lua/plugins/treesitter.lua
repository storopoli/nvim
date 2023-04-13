return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ignore_install = { "help" }

      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "bash",
          "c",
          "cmake",
          "cpp",
          "css",
          "diff",
          "dockerfile",
          "git_config",
          "gitignore",
          "go",
          "graphql",
          "html",
          "http",
          "javascript",
          "jsdoc",
          "json",
          "julia",
          "latex",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "python",
          "regex",
          "rust",
          "scss",
          "sql",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        })
      end
      opts.matchup = {
        enable = true,
      }
      opts.highlight = { enable = true }
      opts.query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    config = true,
  },
}
