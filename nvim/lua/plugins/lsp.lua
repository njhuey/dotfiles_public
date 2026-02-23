-- Enable LSP servers
vim.lsp.enable({ "pyright", "ruff", "gopls", "lua_ls", "bashls" })

-- Per-server configuration
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      gofumpt = true,
    },
  },
})

-- Inline diagnostic indicators
vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
})

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-org/mason.nvim" },
    event = "LazyFile",
    config = function()
      -- LSP keymaps on buffer attach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local buf = event.buf
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
          end

          -- Go-to navigation (Snacks picker for multi-result UI)
          map("n", "gd", function() Snacks.picker.lsp_definitions() end, "Goto Definition")
          map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
          map("n", "gr", function() Snacks.picker.lsp_references() end, "References")
          map("n", "gI", function() Snacks.picker.lsp_implementations() end, "Goto Implementation")
          map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, "Goto Type Definition")

          -- Documentation
          map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
          map("n", "gK", vim.lsp.buf.signature_help, "Signature Help")

          -- Code actions and refactoring
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("n", "<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
          map({ "n", "v" }, "<leader>cf", function()
            vim.lsp.buf.format({ async = true })
          end, "Format")

          -- Diagnostics
          map("n", "<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")
          map("n", "]d", function() vim.diagnostic.goto_next() end, "Next Diagnostic")
          map("n", "[d", function() vim.diagnostic.goto_prev() end, "Prev Diagnostic")
          map("n", "]e", function()
            vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
          end, "Next Error")
          map("n", "[e", function()
            vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
          end, "Prev Error")
          map("n", "]w", function()
            vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
          end, "Next Warning")
          map("n", "[w", function()
            vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
          end, "Prev Warning")

          -- Symbols
          map("n", "<leader>cs", function() Snacks.picker.lsp_symbols() end, "Document Symbols")
          map("n", "<leader>cS", function() Snacks.picker.lsp_workspace_symbols() end, "Workspace Symbols")
        end,
      })

      -- Auto-format on save (respects vim.g.autoformat)
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function(event)
          if vim.g.autoformat and vim.bo[event.buf].filetype ~= "sh" then
            vim.lsp.buf.format({ async = false, bufnr = event.buf })
          end
        end,
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
    config = function(_, opts)
      require("mason").setup(opts)

      local ensure_installed = {
        "bash-language-server",
        "shellcheck",
        "gofumpt",
        "gopls",
        "pyright",
        "ruff",
        "shfmt",
        "stylua",
        "lua-language-server",
      }
      local mr = require("mason-registry")
      mr.refresh(function()
        for _, tool in ipairs(ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
}
