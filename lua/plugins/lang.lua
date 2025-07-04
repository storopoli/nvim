-- Disable Mason

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local ensure_installed = {
        -- astro = true,
        -- tailwindcss = true,
        -- unocss = true,
        -- volar = true,
        -- vtsls = true,
      }

      for server, server_opts in pairs(opts.servers) do
        if type(server_opts) == "table" and not ensure_installed[server] then
          server_opts.mason = false
        end
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = {
        -- "markdown-toc",
      }
    end,
  },
}
