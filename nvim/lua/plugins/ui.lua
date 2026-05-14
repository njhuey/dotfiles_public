local map = vim.keymap.set

require("snacks").setup({
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
        { icon = " ",  key = "f", desc = "Find File",       action = ":lua Snacks.dashboard.pick('files')" },
        { icon = " ",  key = "n", desc = "New File",        action = ":ene | startinsert" },
        { icon = " ",  key = "g", desc = "Find Text",       action = ":lua Snacks.dashboard.pick('live_grep')" },
        { icon = " ",  key = "r", desc = "Recent Files",    action = ":lua Snacks.dashboard.pick('oldfiles')" },
        { icon = " ",  key = "s", desc = "Restore Session", section = "session" },
        { icon = " ",  key = "q", desc = "Quit",            action = ":qa" },
      },
    },
    -- Default sections include `startup`, which calls `require("lazy.stats")`.
    -- We use vim.pack, so override sections to drop it.
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
    },
  },
  explorer = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  notifier = { enabled = true, timeout = 10000 },
  notify = { enabled = true },
  picker = { enabled = true },
  scope = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
})

-- Snacks keymaps
map("n", "<leader>e", function() Snacks.explorer() end, { desc = "Explorer Snacks (root dir)" })
map("n", "<leader>E", function() Snacks.explorer() end, { desc = "Explorer Snacks (cwd)" })
map("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>/", function() require("fzf-lua").live_grep() end, { desc = "Grep (Root Dir)" })
map("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
map("n", "<leader><space>", function()
  local result = vim.fn.systemlist("git rev-parse --show-toplevel")
  local root = (vim.v.shell_error == 0 and result[1]) or vim.fn.getcwd()
  require("fzf-lua").files({ cwd = root })
end, { desc = "Fzf Files (root dir)" })
map("n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "Notification History" })
map("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff (hunks)" })
map("n", "<leader>gD", function() Snacks.picker.git_diff({ base = "origin", group = true }) end,
  { desc = "Git Diff (origin)" })
map("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
map("n", "<leader>gi", function() Snacks.picker.gh_issue() end, { desc = "GitHub Issues (open)" })

Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")

-- tabby
vim.o.showtabline = 1

require("tabby").setup({
  preset = "tab_only",
})

map("n", "<S-h>", "<cmd>tabprevious<cr>", { desc = "Prev Tab" })
map("n", "<S-l>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader>bj", function()
  vim.ui.select(vim.api.nvim_list_tabpages(), {
    prompt = "Pick Tab:",
    format_item = function(tabid)
      local winnr = vim.api.nvim_tabpage_get_win(tabid)
      local bufnr = vim.api.nvim_win_get_buf(winnr)
      local name = vim.api.nvim_buf_get_name(bufnr)
      return name ~= "" and vim.fn.fnamemodify(name, ":t") or "[No Name]"
    end,
  }, function(tabid)
    if tabid then vim.api.nvim_set_current_tabpage(tabid) end
  end)
end, { desc = "Pick Tab" })
