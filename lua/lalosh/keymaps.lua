local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Allow adding empty line before and after the current line
keymap("n", "<A-j>", ":set paste<CR>m`o<Esc>``:set nopaste<CR>", opts)
keymap("n", "<A-k>", ":set paste<CR>m`O<Esc>``:set nopaste<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-p>", ":BufferLinePick<CR>", opts)



-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- save already yanked text in memory, don't replace it with the text yanked over
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- save all files on space-s
keymap("n", "<leader>s", ":wa<CR>", opts);
keymap("n", "<BS>", "<C-^>", opts);




-- telescope
keymap("n", "<c-p>", "<cmd>lua require'telescope.builtin'.find_files({ hidden=true })<cr>", opts)
keymap("n", "<c-g>", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<c-y>", "<cmd>Telescope lsp_references<cr>", opts)
keymap("n", "<c-f>", "<cmd>Telescope grep_string<cr>", opts)
keymap("n", "<c-s>", "<cmd>Telescope lsp_document_symbols<cr>", opts)

-- tree
keymap("n", "<C-e>", ":NvimTreeToggle<cr>", opts)
keymap("n", "<C-t>", ":NvimTreeFindFile<cr>", opts)

keymap("n", "<F9>", ":Gitsigns next_hunk<cr>", opts)

-- quick fix list controls
keymap("n", "<F5>", ":copen<cr>", opts)
keymap("n", "<F6>", ":ccl<cr>", opts)
keymap("n", "<F7>", ":cn<cr>", opts)
keymap("n", "<F8>", ":cp<cr>", opts)

-- open quick fix list
keymap("n","<F4>","<cmd>lua vim.diagnostic.setqflist()<cr>",opts);
keymap("n","<F2>",":let @* = expand(\"%\")<cr>",opts);


keymap("n", "<leader>f", ":FormatWrite<CR>", opts);


keymap("n", "<F10>", ":TrailBlazerToggleTrailMarkList<CR>", opts);
keymap("n", "<F11>", ":TrailBlazerSwitchNextTrailMarkStack<CR>", opts);

-- codeium related
keymap("i", "<C-;>", "codeium#Accept()", { expr = true })

-- rename
keymap("n", "<leader>r", ":IncRename ", opts);

-- auto format on save
--vim.cmd [[ 
 -- augroup FormatAutogroup
--  autocmd!
--    autocmd BufWritePost * FormatWrite
 -- augroup END
--]]
