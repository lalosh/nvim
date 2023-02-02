local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }


-- blame line
keymap("n", "<A-b>", ":ToggleBlameLine<CR>", opts)
