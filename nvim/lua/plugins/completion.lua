return {
  {
    "github/copilot.vim",
    event = "InsertEnter",
    init = function()
      vim.g.copilot_no_tab_map = true
    end,
    keys = {
      {
        "<leader>cp",
        function()
          if vim.fn["copilot#Enabled"]() == 1 then
            vim.cmd("Copilot disable")
            vim.notify("Copilot disabled")
          else
            vim.cmd("Copilot enable")
            vim.notify("Copilot enabled")
          end
        end,
        desc = "Toggle Copilot",
      },
    },
  },
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    version = "*",
    opts = {
      keymap = {
        ["<Tab>"] = {
          function()
            local key = vim.fn["copilot#Accept"]("")
            if key ~= "" then
              vim.api.nvim_feedkeys(key, "n", true)
              return true
            end
          end,
          "fallback",
        },
        ["<S-Tab>"]   = { "fallback" },
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
    },
  },
}
