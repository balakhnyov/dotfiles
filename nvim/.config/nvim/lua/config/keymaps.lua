-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

vim.g.mapleader = " "

-- -- Save and Quit --
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
vim.keymap.set("n", "<leader>c", "<cmd>q<cr>", { desc = "Quit" })

-- -- Command Abbreviations --
-- Handle capitalization mistakes (cnoreabbrev prevents recursive expansion)
local abbreviations = { W = "w", Q = "q", WQ = "wq", Wq = "wq" }
for trigger, replacement in pairs(abbreviations) do
  vim.cmd("cnoreabbrev " .. trigger .. " " .. replacement)
end

-- -- Buffers --
vim.keymap.set("n", "<leader>n", "<cmd>bn<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>p", "<cmd>bp<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<leader>x", "<cmd>bd<cr>", { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>ml", "<cmd>b#<cr>", { desc = "Last Buffer" })

-- -- UI / Visual --
vim.keymap.set("n", "<leader>h", "<cmd>noh<cr>", { desc = "Clear Highlights" })

-- Move blocks of text in visual mode
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })

-- Center screen after scrolling
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Center screen on next/prev search result
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- -- Editing --
-- Paste in visual mode without yanking replaced text
vim.keymap.set("x", "p", [["_dP]])

-- Clipboard operations
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to Clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to Clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without Yanking" })

-- Map Ctrl-c to Escape
vim.keymap.set("i", "<C-c>", "<Esc>")

-- -- Navigation --
-- Move 5 lines with arrow keys
vim.keymap.set("n", "<Down>", "5j")
vim.keymap.set("n", "<Up>", "5k")

-- Decrement integers (Fix conflict with tmux C-a)
vim.keymap.set("n", "<C-b>", "<C-a>")

-- -- Search and Replace --
vim.keymap.set(
  "n",
  "<leader>sr",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word under cursor" }
)

-- Note: Telescope keymaps live in plugins/telescope.lua for lazy-loading
