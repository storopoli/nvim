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
      "folke/neodev.nvim", -- Neovim development Lua utils
      "petertriho/cmp-git", -- nvim-cmp source for git
      "barreiroleo/ltex_extra.nvim", -- ltex-ls extra stuff: codeactions and language
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
      require("neodev").setup()
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
          vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references)
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
          vim.keymap.set(
            "n",
            "<leader>cwa",
            vim.lsp.buf.add_workspace_folder,
            { desc = "[A]dd Folder", buffer = ev.buf }
          )
          vim.keymap.set(
            "n",
            "<leader>cwr",
            vim.lsp.buf.remove_workspace_folder,
            { desc = "[R]emove Folder", buffer = ev.buf }
          )
          vim.keymap.set("n", "<leader>cwl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, { desc = "[L]ist Folders", buffer = ev.buf })
          -- Enable inlay hints
          local inlay_hint = vim.lsp.buf.inlayhints or vim.lsp.inlayhints
          if vim.fn.has("nvim-0.10.0") and inlay_hint then
            local client = vim.lsp.get_client_by_id(ev.data.client_id)
            if client.supports_method("textDocument/inlayHint") then
              vim.g.inlay_hints_visible = true
              vim.lsp.inlay_hint(ev.buf, true)
              -- set the keymap to toggle on/off
              vim.keymap.set("n", "<leader>ch", function()
                vim.lsp.inlay_hint(ev.buf, nil)
              end, { desc = "Toggle Inlay [H]ints", buffer = ev.buf })
            end
          end
          -- command to toggle inline diagnostics
          vim.api.nvim_create_user_command("DiagnosticsToggleVirtualText", function()
            local current_value = vim.diagnostic.config().virtual_text
            if current_value then
              vim.diagnostic.config({ virtual_text = false })
            else
              vim.diagnostic.config({ virtual_text = true })
            end
          end, {})
          vim.keymap.set(
            "n",
            "<leader>cd",
            "<CMD>DiagnosticsToggle<CR>",
            { desc = "[Disable [D]iagnostics]", buffer = ev.buf }
          )
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
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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
            elseif has_words_before() then
              cmp.complete()
              if #cmp.get_entries() == 1 then
                cmp.confirm({ select = true })
              end
            else
              fallback()
            end
          end, { "i", "s" }),
          -- Accept currently selected item.
          -- Set `select` to `false` to only confirm explicitly selected items.
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          -- Don't mess with my <CR>
          --[[
                    ["<CR>"] = cmp.mapping({
                        i = function(fallback)
                            if cmp.visible() and cmp.get_active_entry() then
                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                            else
                                fallback()
                            end
                        end,
                        s = cmp.mapping.confirm({ select = true }),
                        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                    }),
                    --]]
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
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
          { name = "copilot" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          -- { name = "buffer" },
          { name = "path" },
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
          { name = "git" },
          { name = "buffer" },
          { name = "copilot" },
        }),
      })
      cmp.setup.filetype({ "markdown", "text", "sql" }, {
        sources = cmp.config.sources({
          { name = "buffer" },
          { name = "copilot" },
        }),
      })
      -- Use buffer source for `/` and `?`
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      -- Use cmdline & path source for ':'
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
      -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
      lsp.ruff_lsp.setup({ -- requires ruff-lsp to be installed
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- disable hover in favor of pyright
          client.server_capabilities.hoverProvider = false
        end,
      })
      lsp.pyright.setup({ capabilities = capabilities }) -- requires pyright to be installed
      lsp.gopls.setup({ capabilities = capabilities }) -- requires gopls to be installed
      lsp.tsserver.setup({ -- requires typescript-language-server to be installed
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
      lsp.bashls.setup({ capabilities = capabilities }) -- requires bash-language-server to be installed
      lsp.html.setup({ capabilities = capabilities }) -- requires vscode-langservers-extracted to be installed
      lsp.cssls.setup({ capabilities = capabilities }) -- requires vscode-langservers-extracted to be installed
      lsp.jsonls.setup({ capabilities = capabilities }) -- requires vscode-langservers-extracted to be installed
      lsp.eslint.setup({ capabilities = capabilities }) -- requires vscode-langservers-extracted to be installed
      lsp.taplo.setup({ capabilities = capabilities }) -- requires taplo to be installed
      lsp.marksman.setup({ capabilities = capabilities }) -- requires marksman to be installed
      -- lsp.julials.setup({ capabilities = capabilities }) -- requires julia to be installed
      lsp.ltex.setup({ -- requires ltex-ls to be installed
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          require("ltex_extra").setup()
        end,
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
              ["kubernetes"] = "*.yaml",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.yaml",
              ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.yaml",
              ["https://json.schemastore.org/github-action.json"] = ".github/actions/*/action.yaml",
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
          },
        },
      })
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
