return {
  -- Temporarily pin mason plugins to avoid bug in version bump.
  { "mason-org/mason.nvim", version = "^1.0.0" },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      -- Remove clangd and omnisharp from auto-install list
      opts.ensure_installed = vim.tbl_filter(function(server)
        return server ~= "clangd" and server ~= "omnisharp"
      end, opts.ensure_installed or {})
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = false,
        omnisharp = false,
        gopls = false,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "black", --python
        "ruff", --python
        "isort", --python
        "pyright", --python
      },
    },
  },
}
