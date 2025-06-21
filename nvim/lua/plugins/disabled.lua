return {
  {
    "folke/noice.nvim",
    enabled = false,
  },
  {
    "folke/trouble.nvim",
    enabled = false,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff_lsp = {
          mason = false,
          enabled = false,
        },
      },
    },
  },
}
