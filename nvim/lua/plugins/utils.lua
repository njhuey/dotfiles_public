require("fzf-lua").setup({
  files = {
    -- exclude hidden files/dirs by omitting --hidden from fd
    cmd = "fd --color=never --type f --follow",
  },
})

require("mini.pairs").setup()

local wk = require("which-key")
wk.setup({ preset = "helix" })
wk.add({
  -- leader prefix groups
  { "<leader>b", group = "Buffer" },
  { "<leader>c", group = "Code" },
  { "<leader>f", group = "File" },
  { "<leader>g", group = "Git" },
  { "<leader>q", group = "Quit" },
  { "<leader>w", group = "Window" },
  -- bracket navigation groups
  { "]",         group = "Next" },
  { "[",         group = "Prev" },
})
