return {
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
      "hrsh7th/nvim-cmp", -- Autocompletion plugin
      "hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words
      "hrsh7th/cmp-path", -- nvim-cmp source for filesystem paths
      "hrsh7th/cmp-nvim-lua", -- nvim-cmp source for neovim Lua API
      "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
      "L3MON4D3/LuaSnip", -- Snippets plugin
      "barreiroleo/ltex_extra.nvim", -- ltex-ls extra stuff: codeactions and language
      "zbirenbaum/copilot-cmp", -- copilot
    },
    config = function()
      local lsp = require("lspconfig")
      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous [D]iagnostics" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next [D]iagnostics" })
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "[D]iagnostics: Op[e]n Float" })
      vim.keymap.set("n", "<leader>k", vim.diagnostic.setloclist, { desc = "[D]iagnostics: List" })
      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          -- Code Actions
          vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "[R]ename", buffer = ev.buf })
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code [A]ction", buffer = ev.buf })
          -- Definitions
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition", buffer = ev.buf })
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation", buffer = ev.buf })
          vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { desc = "[R]eferences" })
          vim.keymap.set(
            "n",
            "<leader>sD",
            require("telescope.builtin").lsp_document_symbols,
            { desc = "[D]ocument [S]symbols", buffer = ev.buf }
          )
          vim.keymap.set(
            "n",
            "<leader>sy",
            require("telescope.builtin").lsp_dynamic_workspace_symbols,
            { desc = "S[y]mbols", buffer = ev.buf }
          )
          -- See `:help K` for why this keymap
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation", buffer = ev.buf })
          vim.keymap.set("n", "gS", vim.lsp.buf.signature_help, { desc = "[S]ignature Documentation", buffer = ev.buf })
          -- Lesser used LSP functionality
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration", buffer = ev.buf })
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type [D]efinition", buffer = ev.buf })
        end,
      })
      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      -- Add additional capabilities supported by nvim-cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- nvim-cmp setup
      local cmp = require("cmp")
      -- luasnip setup
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      luasnip.config.setup({})
      cmp.setup({
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if #cmp.get_entries() == 1 then
                cmp.confirm({ select = true })
              else
                cmp.select_next_item()
              end
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "copilot" },
        },
      })

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git" },
          { name = "path" },
        }, {
          { name = "buffer", keyword_length = 3 },
        }),
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline({
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<Tab>"] = cmp.mapping.select_next_item(),
        }),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      require("cmp_git").setup()

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      -- LSPs
      lsp.pyright.setup({ capabilities = capabilities }) -- requires pyright to be installed
      lsp.gopls.setup({ capabilities = capabilities }) -- requires gopls to be installed
      lsp.tsserver.setup({ capabilities = capabilities }) -- requires typescript-language-server to be installed
      lsp.bashls.setup({ capabilities = capabilities }) -- requires bash-language-server to be installed
      lsp.html.setup({ capabilities = capabilities }) -- requires vscode-langservers-extracted to be installed
      lsp.cssls.setup({ capabilities = capabilities }) -- requires vscode-langservers-extracted to be installed
      lsp.jsonls.setup({ capabilities = capabilities }) -- requires vscode-langservers-extracted to be installed
      lsp.eslint.setup({ capabilities = capabilities }) -- requires vscode-langservers-extracted to be installed
      lsp.tailwindss.setup({ capabilities = capabilities }) -- requires tailwindcss-language-server to be installed
      lsp.nil_ls.setup({ capabilities = capabilities }) -- requires nil-lsp to be installed
      lsp.taplo.setup({ capabilities = capabilities }) -- requires taplo to be installed
      lsp.marksman.setup({ capabilities = capabilities }) -- requires marksman to be installed
      lsp.lua_ls.setup({ capabilities = capabilities }) -- requires lua-language-server to be installed
      lsp.rust_analyzer.setup({ capabilities = capabilities }) -- requires rust-analyzer to be installed
      lsp.yamlls.setup({ capabilities = capabilities }) -- requires yaml-language-server to be installed
      lsp.typst_lsp.setup({ capabilities = capabilities }) -- requires typst-lsp to be installed
    end,
  },
  {
    "j-hui/fidget.nvim", -- Status for LSP stuff
    tag = "legacy",
    event = "LspAttach",
    config = function()
      require("fidget").setup({
        window = {
          blend = 0,
        },
      })
    end,
  },
}
