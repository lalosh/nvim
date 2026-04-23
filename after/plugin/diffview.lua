local status_ok, diffview = pcall(require, "diffview")
if not status_ok then
  return
end

diffview.setup({
  use_icons = true,
  view = {
    default = {
      layout = "diff2_horizontal",
    },
    merge_tool = {
      layout = "diff3_horizontal",
    },
    file_history = {
      layout = "diff2_horizontal",
    },
  },
  file_panel = {
    listing_style = "tree",
    win_config = {
      position = "left",
      width = 35,
    },
  },
})

local opts = { noremap = true, silent = true }

-- Open diffview (all uncommitted changes)
vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", opts)

-- File history for current file
vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", opts)

-- File history for the whole repo
vim.keymap.set("n", "<leader>gl", "<cmd>DiffviewFileHistory<cr>", opts)

-- Close diffview
vim.keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<cr>", opts)
