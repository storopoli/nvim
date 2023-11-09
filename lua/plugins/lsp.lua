return {
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- LSP source for nvim-cmp
      "hrsh7th/nvim-cmp",         -- Autocompletion plugin
      "hrsh7th/cmp-buffer",       -- nvim-cmp source for buffer words
      "hrsh7th/cmp-path",         -- nvim-cmp source for filesystem paths
      "hrsh7th/cmp-nvim-lua",     -- nvim-cmp source for neovim Lua API
      "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
      "L3MON4D3/LuaSnip",         -- Snippets plugin
      "folke/neodev.nvim",        -- Neovim development Lua utils
      "petertriho/cmp-git",       -- nvim-cmp source for git
      -- Copilot
      {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        opts = {
          suggestion = { enabled = false },
          panel = { enabled = false },
          filetypes = {
            markdown = true,
            help = true,
          },
        },
        keys = {
          {
            "<leader>cp",
            function()
              if require("copilot.client").is_disabled() then
                vim.cmd("Copilot enable")
              else
                vim.cmd("Copilot disable")
              end
            end,
            desc = "Co[p]ilot Toggle",
          },
        },
      },
      {
        "zbirenbaum/copilot-cmp",
        dependencies = "copilot.lua",
        config = true,
      },
    },
    config = function()
      -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
      require("neodev").setup({
        library = { plugins = { "neotest" }, types = true },
      })
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
          vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "[R]ename" })
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code [A]ction" })
          -- Definitions
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
          vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references)
          vim.keymap.set(
            "n",
            "<leader>sD",
            require("telescope.builtin").lsp_document_symbols,
            { desc = "[D]ocument [S]symbols" }
          )
          vim.keymap.set(
            "n",
            "<leader>sy",
            require("telescope.builtin").lsp_dynamic_workspace_symbols,
            { desc = "S[y]mbols" }
          )
          -- See `:help K` for why this keymap
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
          vim.keymap.set("n", "gS", vim.lsp.buf.signature_help, { desc = "[S]ignature Documentation" })
          -- Lesser used LSP functionality
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type [D]efinition" })
          vim.keymap.set("n", "<leader>cwa", vim.lsp.buf.add_workspace_folder, { desc = "[A]dd Folder" })
          vim.keymap.set("n", "<leader>cwr", vim.lsp.buf.remove_workspace_folder, { desc = "[R]emove Folder" })
          vim.keymap.set("n", "<leader>cwl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, { desc = "[L]ist Folders" })
          -- Enable inlay hints
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client.supports_method("textDocument/inlayHint") then
            vim.g.inlay_hints_visible = true
            vim.lsp.inlay_hint(ev.buf, true)
            -- set the keymap to toggle on/off
            vim.keymap.set("n", "<leader>ch", function()
              vim.lsp.inlay_hint(ev.buf, nil)
            end, { desc = "Toggle Inlay [H]ints" })
          end
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
      -- tab fix for copilot
      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
          return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
      end
      cmp.setup({
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        enabled = function()
          -- disable completion in comments
          local context = require("cmp.config.context")
          -- keep command mode completion enabled when cursor is in a comment
          if vim.api.nvim_get_mode().mode == "c" then
            return true
          else
            return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
          end
        end,
        mapping = cmp.mapping.preset.insert({
          ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
          ["<C-d>"] = cmp.mapping.scroll_docs(4),  -- Down
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<Tab>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            elseif luasnip.jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "copilot",  group_index = 2 },
          { name = "nvim_lsp", group_index = 2 },
          { name = "luasnip",  group_index = 2 },
          -- { name = "buffer", group_index = 2 },
          { name = "path",     group_index = 2 },
        },
        sorting = { -- copilot_cmp suggestion
          priority_weight = 2,
          comparators = {
            require("copilot_cmp.comparators").prioritize,
            -- Below is the default comparator list and order for nvim-cmp
            cmp.config.compare.offset,
            -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      })
      -- If you want insert `(` after select function or method item
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      -- Set configuration for specific filetype.
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git",     group_index = 2 },
          { name = "buffer",  group_index = 2 },
          { name = "copilot", group_index = 2 },
        }),
      })
      cmp.setup.filetype({ "markdown", "text", "sql" }, {
        sources = cmp.config.sources({
          { name = "buffer",  group_index = 2 },
          { name = "copilot", group_index = 2 },
        }),
      })
      -- Use buffer source for `/` and `?`
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer", group_index = 2 },
        },
      })
      -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
      lsp.ruff_lsp.setup({ capabilities = capabilities }) -- requires ruff-lsp to be installed
      lsp.gopls.setup({ capabilities = capabilities })    -- requires gopls to be installed
      lsp.tsserver.setup({                                -- requires typescript-language-server to be installed
        capabilities = capabilities,
        -- taken from https://github.com/typescript-language-server/typescript-language-server#workspacedidchangeconfiguration
        javascript = {
          inlayHints = {
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayVariableTypeHints = true,
          },
        },
        typescript = {
          inlayHints = {
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayVariableTypeHints = true,
          },
        },
      })
      lsp.bashls.setup({ capabilities = capabilities })   -- requires bash-language-server to be installed
      lsp.html.setup({ capabilities = capabilities })     -- requires vscode-langservers-extracted to be installed
      lsp.cssls.setup({ capabilities = capabilities })    -- requires vscode-langservers-extracted to be installed
      lsp.jsonls.setup({ capabilities = capabilities })   -- requires vscode-langservers-extracted to be installed
      lsp.eslint.setup({ capabilities = capabilities })   -- requires vscode-langservers-extracted to be installed
      lsp.nil_ls.setup({ capabilities = capabilities })   -- requires nil-lsp to be installed
      lsp.taplo.setup({ capabilities = capabilities })    -- requires taplo to be installed
      lsp.marksman.setup({ capabilities = capabilities }) -- requires marksman to be installed
      lsp.julials.setup({ capabilities = capabilities })  -- requires julia to be installed
      lsp.ltex.setup({                                    -- requires ltex-ls to be installed
        capabilities = capabilities,
        settings = {
          ltex = {
            enabled = {
              "bibtex",
              "gitcommit",
              "context",
              "context.tex",
              "html",
              "latex",
              "markdown",
              "pandoc",
              "typst",
              "org",
              "restructuredtext",
              "rsweave",
            },
            language = "en-US",
            disabledRules = { ["en-US"] = { "PROFANITY" } },
            dictionary = { ["en-US"] = { "builtin" } },
          },
        },
        filetypes = {
          "bib",
          "gitcommit",
          "markdown",
          "org",
          "plaintex",
          "rst",
          "rnoweb",
          "tex",
          "pandoc",
          "quarto",
          "rmd",
          "typst",
       },
      })
      lsp.lua_ls.setup({ -- requires lua-language-server to be installed
        capabilities = capabilities,
        settings = {
          Lua = {
            telemetry = { enable = false },
            hint = { enable = true },
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
      lsp.rust_analyzer.setup({ -- requires rust-analyzer to be installed
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            checkOnSave = true,
            -- Add clippy lints for Rust
            check = {
              allFeatures = true,
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            imports = {
              granularity = {
                enforce = true,
                group = "create",
              },
            },
          },
        },
      })
      lsp.yamlls.setup({ -- requires yaml-language-server to be installed
        capabilities = capabilities,
        settings = {
          yamlls = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["https://raw.githubusercontent.com/ansible-community/schemas/main/f/ansible-tasks.json"] = "roles/{tasks,handlers}/*.{yml,yaml}",
            },
          },
        },
      })
      lsp.texlab.setup({ -- requires texlab to be installed
        capabilities = capabilities,
        settings = {
          build = {
            executable = "tectonic",
            args = { "-X", "build", "--keep-logs", "--keep-intermediates" },
            latexFormatter = "texlab",
            forwardSearchAfter = false,
            onSave = false,
          }
        },
      })
      lsp.typst_lsp.setup({ capabilities = capabilities }) -- requires typst-lsp to be installed
    end,
  },
  {
    "j-hui/fidget.nvim", -- Status for LSP stuff
    tag = "legacy",
    event = "LspAttach",
    config = true,
  },
}
