-- Fixing the powershell_es config to work on Windows
-- The init_optons > enableProfileLoading setting has to be turned off to
-- have code actions and docs. available.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        powershell_es = {
          init_options = {
            enableProfileLoading = false,
          },
        },
      },
    },
  },
}
