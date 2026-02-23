local filetypes = {
  "awk",
  "bash",
  "sh",
  "c",
  "diff",
  "go",
  "html",
  "javascript",
  "json",
  "lua",
  "luadoc",
  "luap",
  "markdown",
  "markdown_inline",
  "printf",
  "proto",
  "python",
  "query",
  "regex",
  "sql",
  "terraform",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
  "zsh",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  version = false,
  lazy = false,
  build = ":TSUpdate",
  opts = {
    indent = { enable = true },
    highlight = { enable = true },
    folds = { enable = true },
    ensure_installed = filetypes,
  },
  config = function(_, opts)
    local TS = require("nvim-treesitter")

    -- some quick sanity checks
    if not TS.get_installed then
      return Snacks.notify.error("Please use `:Lazy` and update `nvim-treesitter`")
    end

    TS.setup(opts)
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("lazyvim_treesitter", { clear = true }),
      pattern = filetypes,
      callback = function()
        vim.treesitter.start()
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
