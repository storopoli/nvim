return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          -- Navigation
          vim.keymap.set("n", "]h", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, buffer = bufnr, desc = "Next [H]unk" })
          vim.keymap.set("n", "[h", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, buffer = bufnr, desc = "Previous [H]unk" })
          -- Actions
          vim.keymap.set(
            { "n", "v" },
            "<leader>hs",
            "<CMD>Gitsigns stage_hunk<CR>",
            { buffer = bufnr, desc = "[S]tage" }
          )
          vim.keymap.set(
            { "n", "v" },
            "<leader>hr",
            "<CMD>Gitsigns reset_hunk<CR>",
            { buffer = bufnr, desc = "[R]eset" }
          )
          vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr, desc = "[S]tage File" })
          vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "[U]ndo" })
          vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { buffer = bufnr, desc = "[R]eset File" })
          vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "[P]review" })
          vim.keymap.set("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end, { buffer = bufnr, desc = "[B]lame line" })
          vim.keymap.set(
            "n",
            "<leader>hB",
            gs.toggle_current_line_blame,
            { buffer = bufnr, desc = "Toggle [B]lame Line" }
          )
          vim.keymap.set("n", "<leader>hd", gs.diffthis, { buffer = bufnr, desc = "[D]iff This" })
          vim.keymap.set("n", "<leader>hD", function()
            gs.diffthis("~")
          end, { buffer = bufnr, desc = "[D]iff This ~" })
          vim.keymap.set("n", "<leader>ht", gs.toggle_deleted, { buffer = bufnr, desc = "[T]oggle Deleted" })
          -- Text object
          vim.keymap.set(
            { "o", "x" },
            "ih",
            "<CMD><C-U>Gitsigns select_hunk<CR>",
            { buffer = bufnr, desc = "GitSigns Select Hunk" }
          )
        end,
      })
    end,
  },
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    keys = {
      { "<leader>gi", "<CMD>Git<CR>",                 desc = "Fug[i]tive" },
      -- It allows me to easily set the branch I am pushing and any tracking
      { "<leader>gt", "<CMD>Git push -u origin <CR>", desc = "Git Push [T]agging" },
    },
    config = function()
      vim.api.nvim_create_autocmd({ "Filetype" }, {
        pattern = { "fugitive" },
        callback = function()
          -- Better commit remaps with no "enter" dialog
          vim.keymap.set("n", "cc", "<CMD>silent! Git commit --quiet<CR>", { silent = true, buffer = true })
          vim.keymap.set("n", "ca", "<CMD>silent! Git commit --quiet --amend<CR>", { silent = true, buffer = true })
          vim.keymap.set(
            "n",
            "ce",
            "<CMD>silent! Git commit --quiet --amend --no-edit<CR>",
            { silent = true, buffer = true }
          )
          -- Push and Pull
          vim.keymap.set("n", "p", "<CMD>silent! Git pull<CR>", { silent = true, buffer = true })
          vim.keymap.set("n", "P", "<CMD>silent! Git push<CR>", { silent = true, buffer = true })
        end,
      })
    end,
  },
  {
    "tpope/vim-rhubarb", -- Fugitive-companion to interact with github
    event = "VeryLazy",
    config = function()
      vim.api.nvim_create_autocmd({ "Filetype" }, {
        pattern = { "gitcommit" },
        callback = function()
          -- Autocompletion for @ and #
          vim.keymap.set("i", "@", "@<C-x><C-o>", { silent = true, buffer = true })
          vim.keymap.set("i", "#", "#<C-x><C-o>", { silent = true, buffer = true })
        end,
      })
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = { { "<leader>gg", "<CMD>LazyGit<CR>", desc = "Lazy[g]it" } },
  },
}
