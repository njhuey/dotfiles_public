return {
  {
    "ibhagwan/fzf-lua",
    name = "fzf-lua",
    cmd = "FzfLua",
  },
  {
    "nvim-mini/mini.pairs",
    event = "InsertEnter",
    config = function()
      require("mini.pairs").setup()
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
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
    end,
  },
}
