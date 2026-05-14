require("blink.cmp").setup({
  keymap = {
    ["<CR>"]      = { "accept", "fallback" },
    ["<C-e>"]     = { "hide", "fallback" },
    ["<C-Space>"] = { "show", "fallback" },
  },
  appearance = {
    nerd_font_variant = "mono",
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
  },
})
