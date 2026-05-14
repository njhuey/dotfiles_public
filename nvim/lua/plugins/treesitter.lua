local filetypes = {
  "awk",
  "bash",
  "c",
  "diff",
  "go",
  "html",
  "javascript",
  "json",
  "lua",
  "luadoc",
  "hcl",
  "luap",
  "markdown",
  "markdown_inline",
  "printf",
  "proto",
  "python",
  "query",
  "regex",
  "rust",
  "sql",
  "starlark",
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

local TS = require("nvim-treesitter")
TS.setup()

-- main branch removed ensure_installed from setup(); install on demand
-- via :TSEnsure rather than at startup, so parser fetches/compiles are explicit.
vim.api.nvim_create_user_command("TSEnsure", function()
  local installed = TS.get_installed and TS.get_installed() or {}
  local installed_set = {}
  for _, p in ipairs(installed) do installed_set[p] = true end
  local missing = vim.tbl_filter(function(ft) return not installed_set[ft] end, filetypes)
  if #missing > 0 then
    TS.install(missing)
  end
end, { desc = "Install missing treesitter parsers from filetypes list" })

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("config_treesitter", { clear = true }),
  pattern = filetypes,
  callback = function()
    -- parser may not be installed yet if install() is still running async
    local ok = pcall(vim.treesitter.start)
    if ok then
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo[0][0].foldmethod = 'expr'
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
