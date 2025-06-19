return {
  -- Temporarily pin mason plugins to avoid bug in version bump.
  { "mason-org/mason.nvim", version = "^1.0.0" },
  { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua", --lua
        "shfmt", --bash/zsh
        "black", --python
        "ruff", --python
        "isort", --python
        "clangd", --c
        "clang-format", --c
        "sqlfluff", --SQL
        "gopls", --go
        "omnisharp", --c#
      },
    },
  },
}
