return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    enabled = true,
    opts = {
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
          ]],
          keys = {
            {
              icon = " ",
              key = "f",
              desc = "Find File",
              action = ":lua Snacks.dashboard.pick('files')",
            },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            {
              icon = " ",
              key = "g",
              desc = "Find Text",
              action = ":lua Snacks.dashboard.pick('live_grep')",
            },
            {
              icon = " ",
              key = "r",
              desc = "Recent Files",
              action = ":lua Snacks.dashboard.pick('oldfiles')",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            {
              icon = "󰒲 ",
              key = "L",
              desc = "Lazy",
              action = ":Lazy",
              enabled = package.loaded.lazy ~= nil,
            },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
      explorer = { enabled = true },
      image = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true, timeout = 10000 },
      notify = { enabled = true },
      picker = { enabled = true },
      scope = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      -- explorer
      { "<leader>e",       function() Snacks.explorer() end,                                         desc = "Explorer Snacks (root dir)" },
      { "<leader>E",       function() Snacks.explorer() end,                                         desc = "Explorer Snacks (cwd)" },
      -- picker
      { "<leader>,",       function() Snacks.picker.buffers() end,                                   desc = "Buffers" },
      { "<leader>/",       function() require("fzf-lua").live_grep() end,                            desc = "Grep (Root Dir)" },
      { "<leader>:",       function() Snacks.picker.command_history() end,                           desc = "Command History" },
      { "<leader><space>", function() require("fzf-lua").files() end,                                desc = "Fzf Files" },
      { "<leader>n",       function() Snacks.picker.notifications() end,                             desc = "Notification History" },
      -- git
      { "<leader>gd",      function() Snacks.picker.git_diff() end,                                  desc = "Git Diff (hunks)" },
      { "<leader>gD",      function() Snacks.picker.git_diff({ base = "origin", group = true }) end, desc = "Git Diff (origin)" },
      { "<leader>gs",      function() Snacks.picker.git_status() end,                                desc = "Git Status" },
      { "<leader>gi",      function() Snacks.picker.gh_issue() end,                                  desc = "GitHub Issues (open)" },
    },
  },
}
