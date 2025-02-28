-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = " "

-- save, quit
vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("n", "<leader>c", ":q<cr>")

-- ignore capitalization mistakes
vim.cmd("ca W w")
vim.cmd("ca Q q")
vim.cmd("ca WQ wq")
vim.cmd("ca Wq wq")

-- buffers
vim.keymap.set("n", "<leader>n", ":bn<cr>")
vim.keymap.set("n", "<leader>p", ":bp<cr>")
vim.keymap.set("n", "<leader>x", ":bd<cr>")
vim.keymap.set("n", "<leader>ml", ":b#<cr>")

-- unhilight
vim.keymap.set("n", "<leader>h", ":noh<cr>")

-- move a blocks of text up/down with K/J in visual mode
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })

-- Center the screen after scrolling up/down with Ctrl-u/d
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Center the screen on the next/prev search result with n/N
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste in visual mode without yanking replaced text
vim.keymap.set("x", "p", [["_dP]])

-- yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- yank line to clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- delete without yanking
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- map Ctrl-c to Escape
vim.keymap.set("i", "<C-c>", "<Esc>")

-- move 5 lines up/down with arrow keys
vim.keymap.set("n", "<Down>", "5j")
vim.keymap.set("n", "<Up>", "5k")

-- decrement integers with Ctrl-b
vim.keymap.set("n", "<C-b>", "<C-a>")

-- search and replace the word under cursor in the file with <leader>s
vim.keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fs", builtin.current_buffer_fuzzy_find, { desc = "Search in current file" })
