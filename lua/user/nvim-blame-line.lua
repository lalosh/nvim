 --local status_ok, blamExtension = pcall(require, "tveskag/nvim-blame-line")
 --if not status_ok then
--    vim.notify("tveskag/nvim-blame-line plugin is not installed")
--    return
-- end

local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap


keymap("n", "<C-b>", ":ToggleBlameLine<CR>", opts)


-- not committed line message
vim.api.nvim_set_var('blameLineMessageWhenNotYetCommited', '')
