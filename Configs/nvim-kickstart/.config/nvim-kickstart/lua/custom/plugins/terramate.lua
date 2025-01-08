return {
  "terramate-io/vim-terramate",
  lazy = false,
  keys = {
    { "<leader>M", name = "Terramate" },
    { "<leader>Mg", "<cmd>Terramate generate<cr>", desc = "Terramate generate" },
    { "<leader>Ml", "<cmd>Terramate list<cr>", desc = "Terramate list" },
    { "<leader>Mf", "<cmd>TerramateFmt<cr>", desc = "Run Terramatefmt on code" },
  },
}
