local mappings = {
  n = {
    ["<Tab>"] = { "<cmd>bnext<cr>", desc = "Switch to next tab" },
    ["<S-Tab>"] = { "<cmd>bprevious<cr>", desc = "Switch to previous tab" },
  }
}

return mappings
