local mappings = {
  n = {
    ["<Tab>"] = { "<cmd>bnext<cr>", desc = "Switch to next tab" },
    ["<S-Tab>"] = { "<cmd>bprevious<cr>", desc = "Switch to previous tab" },
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "Create new tab" },
    ["<leader>bx"] = { "<cmd>tabclose<cr>", desc = "Close current tab" },
  }
}

return mappings
