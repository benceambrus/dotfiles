local mappings = {
  n = {
    ["<Tab>"] = { "<cmd>bnext<cr>", desc = "Switch to next tab" },
    ["<S-Tab>"] = { "<cmd>bprevious<cr>", desc = "Switch to previous tab" },
    ["<leader>bn"] = { "<cmd>tabnew<cr>", name = "Buffers", desc = "Create new tab" },
  }
}

return mappings
