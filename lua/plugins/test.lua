return {
  "nvim-neotest/neotest",
  opts = { adapters = { "neotest-rust", "neotest-go", "neotest-python", "neotest-jest" } },
  dependencies = {
    "rouge8/neotest-rust",
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-jest",
  },
}
