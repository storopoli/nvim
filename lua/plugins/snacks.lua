return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        git_log = {
          actions = {
            copy_sha = function(_, item)
              if item and item.commit then
                vim.fn.setreg(vim.v.register, item.commit)
                require("snacks").notify("Copied SHA: " .. item.commit, { title = "Git Browse" })
              end
            end,
            copy_url = function(_, item)
              if item and item.commit then
                local snacks = require("snacks")
                local cwd = snacks.git.get_root() or vim.fn.getcwd()
                local remote_url =
                  vim.fn.system("git -C " .. vim.fn.shellescape(cwd) .. " remote get-url origin"):gsub("\n", "")
                if remote_url and remote_url ~= "" then
                  local repo = snacks.gitbrowse.get_repo(remote_url)
                  local url = snacks.gitbrowse.get_url(repo, { commit = item.commit }, { what = "commit" })
                  vim.fn.setreg("+", url)
                  snacks.notify("Copied URL: " .. url, { title = "Git Browse" })
                end
              end
            end,
          },
          win = {
            input = {
              keys = {
                ["<c-e>"] = { "copy_sha", mode = { "n", "i" } },
                ["<c-y>"] = { "copy_url", mode = { "n", "i" } },
              },
            },
            list = {
              keys = {
                ["<c-e>"] = "copy_sha",
                ["<c-y>"] = "copy_url",
              },
            },
          },
        },
        git_log_file = {
          actions = {
            copy_sha = function(_, item)
              if item and item.commit then
                vim.fn.setreg(vim.v.register, item.commit)
                require("snacks").notify("Copied SHA: " .. item.commit, { title = "Git Browse" })
              end
            end,
            copy_url = function(_, item)
              if item and item.commit then
                local snacks = require("snacks")
                local cwd = snacks.git.get_root() or vim.fn.getcwd()
                local remote_url =
                  vim.fn.system("git -C " .. vim.fn.shellescape(cwd) .. " remote get-url origin"):gsub("\n", "")
                if remote_url and remote_url ~= "" then
                  local repo = snacks.gitbrowse.get_repo(remote_url)
                  local url = snacks.gitbrowse.get_url(repo, { commit = item.commit }, { what = "commit" })
                  vim.fn.setreg("+", url)
                  snacks.notify("Copied URL: " .. url, { title = "Git Browse" })
                end
              end
            end,
          },
          win = {
            input = {
              keys = {
                ["<c-e>"] = { "copy_sha", mode = { "n", "i" } },
                ["<c-y>"] = { "copy_url", mode = { "n", "i" } },
              },
            },
            list = {
              keys = {
                ["<c-e>"] = "copy_sha",
                ["<c-y>"] = "copy_url",
              },
            },
          },
        },
        git_log_line = {
          actions = {
            copy_sha = function(_, item)
              if item and item.commit then
                vim.fn.setreg(vim.v.register, item.commit)
                require("snacks").notify("Copied SHA: " .. item.commit, { title = "Git Browse" })
              end
            end,
            copy_url = function(_, item)
              if item and item.commit then
                local snacks = require("snacks")
                local cwd = snacks.git.get_root() or vim.fn.getcwd()
                local remote_url =
                  vim.fn.system("git -C " .. vim.fn.shellescape(cwd) .. " remote get-url origin"):gsub("\n", "")
                if remote_url and remote_url ~= "" then
                  local repo = snacks.gitbrowse.get_repo(remote_url)
                  local url = snacks.gitbrowse.get_url(repo, { commit = item.commit }, { what = "commit" })
                  vim.fn.setreg("+", url)
                  snacks.notify("Copied URL: " .. url, { title = "Git Browse" })
                end
              end
            end,
          },
          win = {
            input = {
              keys = {
                ["<c-e>"] = { "copy_sha", mode = { "n", "i" } },
                ["<c-y>"] = { "copy_url", mode = { "n", "i" } },
              },
            },
            list = {
              keys = {
                ["<c-e>"] = "copy_sha",
                ["<c-y>"] = "copy_url",
              },
            },
          },
        },
        git_branches = {
          actions = {
            copy_sha = function(_, item)
              if item and item.commit then
                vim.fn.setreg(vim.v.register, item.commit)
                require("snacks").notify("Copied SHA: " .. item.commit, { title = "Git Browse" })
              end
            end,
            copy_url = function(_, item)
              if item and item.commit then
                local snacks = require("snacks")
                local cwd = snacks.git.get_root() or vim.fn.getcwd()
                local remote_url =
                  vim.fn.system("git -C " .. vim.fn.shellescape(cwd) .. " remote get-url origin"):gsub("\n", "")
                if remote_url and remote_url ~= "" then
                  local repo = snacks.gitbrowse.get_repo(remote_url)
                  local url = snacks.gitbrowse.get_url(repo, { commit = item.commit }, { what = "commit" })
                  vim.fn.setreg("+", url)
                  snacks.notify(("Copied to register `+`:\n```\n%s\n```"):format(url), { title = "Snacks Picker" })
                end
              end
            end,
          },
          win = {
            input = {
              keys = {
                ["<c-e>"] = { "copy_sha", mode = { "n", "i" } },
                ["<c-y>"] = { "copy_url", mode = { "n", "i" } },
              },
            },
            list = {
              keys = {
                ["<c-e>"] = "copy_sha",
                ["<c-y>"] = "copy_url",
              },
            },
          },
        },
      },
    },
  },
}
