return {
  {
    "folke/which-key.nvim", -- popup with possible key bindings of the command you started typing
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>cw"] = { name = "+workspace" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>h"] = { name = "+hunks" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>n"] = { name = "+noice" },
        ["<leader>t"] = { name = "+test" },
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
      indent = {
        char = "│",
        tab_char = "│",
      },
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
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = true,
    -- stylua: ignore
    keys = {
      { "<>st",       "<CMD>TodoTelescope<CR>",                        desc = "[T]odo" },
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
          bottom_search = false,        -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true,        -- add a border to hover docs and signature help
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
        mode = {
          "i", "n", "s" }
      },
      {
        "<C-b>",
        function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
        silent = true,
        expr = true,
        desc =
        "Scroll [B]ackward",
        mode = {
          "i", "n", "s" }
      },
    },
  },
}
