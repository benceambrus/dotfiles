return {
  -- Change the default terminal shell to pwsh.
  {
    "folke/snacks.nvim",
    ---@snacks.Config
    opts = {
      terminal = {
        shell = "pwsh",
      },
    },
  },
}
