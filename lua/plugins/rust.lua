-- Hack to enable proc macro support in Rust.

return {
  "mrcjkb/rustaceanvim",
  config = function()
    vim.g.rustaceanvim = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            procMacro = {
              ignored = {
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
                ["async-trait"] = vim.NIL,
              },
            },
          },
        },
      },
    }
  end,
}
