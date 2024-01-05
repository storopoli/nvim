return {
  {
    "nvim-telescope/telescope.nvim", -- Telescope
    branch = "0.1.x",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>?",       "<CMD>Telescope oldfiles<CR>", desc = "[?] Find recently opened files" },
      { "<leader><space>", "<CMD>Telescope buffers<CR>",  desc = "[ ] Find existing buffers" },
      {
        "<leader>/",
        "<CMD>Telescope current_buffer_fuzzy_find<CR>",
        desc = "[/] Fuzzily search in current buffer]",
      },
      { "<leader>sr", "<CMD>Telescope resume<CR>",       desc = "[R]esume Previous Seasch" },
      { "<leader>sf", "<CMD>Telescope git_files<CR>",    desc = "[F]iles" },
      { "<leader>sF", "<CMD>Telescope find_files<CR>",   desc = "[F]iles All" },
      { "<leader>sh", "<CMD>Telescope help_tags<CR>",    desc = "[H]elp" },
      { "<leader>sw", "<CMD>Telescope grep_string<CR>",  desc = "Current [W]ord" },
      { "<leader>sg", "<CMD>Telescope live_grep<CR>",    desc = "[G]rep" },
      { "<leader>sd", "<CMD>Telescope diagnostics<CR>",  desc = "[D]iagnostics" },
      { "<leader>sm", "<CMD>Telescope marks<CR>",        desc = "[M]arks" },
      { "<leader>sc", "<CMD>Telescope git_bcommits<CR>", desc = "[C]omits File" },
      { "<leader>sC", "<CMD>Telescope git_commits<CR>",  desc = "[C]omits" },
      { "<leader>ss", "<CMD>Telescope git_status<CR>",   desc = "[S]tatus" },
      { "<leader>sS", "<CMD>Telescope git_stash<CR>",    desc = "[S]tash" },
      { "<leader>sT", "<CMD>Telescope git_stash<CR>",    desc = "[T]reesitter" },
    },
    config = function()
      -- See `:help telescope` and `:help telescope.setup()`
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-n>"] = "move_selection_next",
              ["<C-p>"] = "move_selection_previous",
              ["<C-u>"] = false,
              ["<C-d>"] = false,
              ["<C-Down>"] = function(...)
                return actions.cycle_history_next(...)
              end,
              ["<C-Up>"] = function(...)
                return actions.cycle_history_prev(...)
              end,
              ["<C-f>"] = function(...)
                return actions.preview_scrolling_down(...)
              end,
              ["<C-b>"] = function(...)
                return actions.preview_scrolling_up(...)
              end,
            },
            n = {
              ["q"] = function(...)
                return actions.close(...)
              end,
            },
          },
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = vim.fn.executable("make") == 1,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    config = function()
      -- You don't need to set any of these options.
      -- IMPORTANT!: this is only a showcase of how you can set default options!
      require("telescope").setup({
        extensions = {
          file_browser = {
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
          },
        },
      })
      -- To get telescope-file-browser loaded and working with telescope,
      -- you need to call load_extension, somewhere after setup function:
      require("telescope").load_extension("file_browser")
    end,
    keys = {
      { "<leader>sb", "<CMD>Telescope file_browser<CR>", desc = "File [B]rowser" },
      {
        "<leader>sB",
        "<CMD>Telescope file_browser path=%:p:h select_buffer=true<CR>",
        desc = "File [B]rowser Current Buffer",
      },
    },
  },
}
