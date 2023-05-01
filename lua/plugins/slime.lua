return {
  "jpalardy/vim-slime",
  lazy = false,
  config = function()
    -- vim.g.slime_target = "kitty"
    vim.g.slime_target = "tmux"
    vim.g.slime_default_config = { socket_name = "default", target_pane = "{left-of}" }
  end,
}
