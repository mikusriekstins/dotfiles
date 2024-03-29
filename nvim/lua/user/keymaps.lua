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

-- Open nvim configs
keymap("n", "<leader>rc", ":e ~/.config/nvim/lua/user/<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -4<CR>", opts)
keymap("n", "<C-Down>", ":resize +4<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -4<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +4<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-1<CR>==gi", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
keymap("t", "<Esc>", "<C-\\><C-n>", term_opts)

-- Harpoon --
keymap("n", "<leader>m", ":lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<C-q>", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
keymap("n", "<F1>", ":lua require('harpoon.ui').nav_file(1)<CR>", opts)
keymap("n", "<F2>", ":lua require('harpoon.ui').nav_file(2)<CR>", opts)
keymap("n", "<F3>", ":lua require('harpoon.ui').nav_file(3)<CR>", opts)
keymap("n", "<F4>", ":lua require('harpoon.ui').nav_file(4)<CR>", opts)

