-- luacheck: globals vim
return {
  {
    "folke/which-key.nvim", -- popup with possible key bindings of the command you started typing
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto", _ = "which_key_ignore" },
        ["]"] = { name = "+next", _ = "which_key_ignore" },
        ["["] = { name = "+prev", _ = "which_key_ignore" },
        ["<leader>c"] = { name = "+code", _ = "which_key_ignore" },
        ["<leader>cw"] = { name = "+workspace", _ = "which_key_ignore" },
        ["<leader>g"] = { name = "+git", _ = "which_key_ignore" },
        ["<leader>h"] = { name = "+hunks", _ = "which_key_ignore" },
        ["<leader>s"] = { name = "+search", _ = "which_key_ignore" },
        ["<leader>n"] = { name = "+noice", _ = "which_key_ignore" },
        ["<leader>x"] = { name = "+trouble", _ = "which_key_ignore" },
        ["<leader>t"] = { name = "+session", _ = "which_key_ignore" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim", -- Indent guides
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "netrw",
          "Trouble",
          "lazy",
          "notify",
        },
      },
    },
  },
  {
    "folke/todo-comments.nvim", -- Highlight TODO, NOTE, FIX, WARN, HACK, PERF, and TEST
    dependencies = "nvim-lua/plenary.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = { signs = false },
    -- stylua: ignore
    keys = {
        { "<leader>st", "<CMD>TodoTelescope<CR>",                        desc = "[T]odo" },
        { "<leader>K",  "<CMD>TodoLocList<CR>",                          desc = "Todo: List" },
        { "<leader>[t", "<CMD>require('todo-comments').jump_prev()<CR>", desc = "Previous [T]odo" },
        { "<leader>]t", "<CMD>require('todo-comments').jump_next()<CR>", desc = "Next [T]odo" },
    },
  },
  {
    "folke/noice.nvim", -- Better UI
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("telescope").load_extension("noice")
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that cmp and other plugins use Treesitter
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = false, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
      })
    end,
        -- stylua: ignore
        keys = {
            { "<leader>sn", "<CMD>Telescope noice<CR>",                     desc = "[N]oice" },
            {
                "<leader>nl",
                function() require("noice").cmd("last") end,
                desc =
                "[L]ast Message"
            },
            { "<leader>nh", function() require("noice").cmd("history") end, desc = "[H]istory" },
            { "<leader>na", function() require("noice").cmd("all") end,     desc = "[A]ll" },
            {
                "<leader>nd",
                function() require("noice").cmd("dismiss") end,
                desc =
                "[D]ismiss All"
            },
            {
                "<C-f>",
                function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
                silent = true,
                expr = true,
                desc =
                "Scroll [F]orward",
                mode = { "i", "n", "s" }
            },
            {
                "<C-b>",
                function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
                silent = true,
                expr = true,
                desc =
                "Scroll [B]ackward",
                mode = { "i", "n", "s" }
            },
        },
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local logo_table = {
        "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
        "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
        "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
        "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
        "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
        "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
        "                                                  ",
      }
      local logo = table.concat(logo_table, "\n")
      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
                    -- stylua: ignore
                    center = {
                        { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
                        { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
                        { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
                        { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
                        { action = 'lua require("lazygit").lazygit()', desc = " Git", icon = " ", key = "i" },
                        { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
                        { action = "Lazy", desc = " Plugins", icon = "󰒲 ", key = "l" },
                        { action = "qa", desc = " Quit", icon = " ", key = "q" },
                    },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return {
              "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
            }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = vim.opt.sessionoptions:get() },
        -- stylua: ignore
        keys = {
            { "<leader>ts", function() require("persistence").load() end,                desc = "Restore Session" },
            { "<leader>tl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
            { "<leader>td", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
        },
  },
}
