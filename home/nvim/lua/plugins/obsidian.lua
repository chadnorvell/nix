return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- uses latest release, not latest commit

  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "notes",
        path = "~/notes",
      },
    },
  },
  keys = {
    { "<leader>oo", "<cmd>Obsidian<cr>", desc = "menu" },
    { "<leader>og", "<cmd>Obsidian search<cr>", desc = "search" },
    { "<leader>on", "<cmd>Obsidian new<cr>", desc = "new" },
    { "<leader>ot", "<cmd>Obsidian today<cr>", desc = "today" },
    { "<leader>oT", "<cmd>Obsidian tomorrow<cr>", desc = "tomorrow" },
    { "<leader>oy", "<cmd>Obsidian yesterday<cr>", desc = "yesterday" },
  },
}
