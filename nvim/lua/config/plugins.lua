-- vim.pack-based plugin management (Neovim 0.12+)

vim.pack.add({
  "https://github.com/catppuccin/nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/nanozuki/tabby.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/nvim-mini/mini.pairs",
  "https://github.com/folke/which-key.nvim",
  { src = "https://github.com/saghen/blink.cmp",                version = vim.version.range("^1") },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
})

-- Order matters: colorscheme first so the rest renders correctly,
-- then snacks (provides the global `Snacks` used by other modules).
require("plugins.colorscheme")
require("plugins.ui")
require("plugins.utils")
require("plugins.completion")
require("plugins.treesitter")
require("plugins.lsp")
