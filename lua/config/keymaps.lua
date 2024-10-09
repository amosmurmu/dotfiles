-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Map 'jk' to act as Escape
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

vim.keymap.set("i", "kj", "<Esc>", { noremap = true, silent = true })

-- Keymaps for saving and quitting
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })

-- Use Tab to cycle through buffers (next)
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { silent = true })

-- Use Shift+Tab to cycle through buffers (previous)
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", { silent = true })

-- Use for Buffers
vim.keymap.set("n", "<C-b>", ":Telescope buffers<CR>", { silent = true })

-- Create or edit a new file using Ctrl + o
vim.keymap.set("n", "<C-o>", ":e ", { silent = false })

-- Create a new tab with Ctrl + t
vim.keymap.set("n", "<C-t>", ":tabnew<CR>", { silent = true })

vim.cmd([[
  vnoremap <C-c> :w !wl-copy<CR><CR>  " Copy selected text to clipboard
  nnoremap <C-v> :r !wl-paste<CR>    " Paste from clipboard
]])

vim.keymap.set("t", "<C-o>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Add persistence.nvim keymaps
vim.keymap.set("n", "<C-s>", function()
  require("persistence").load()
end, { silent = true, desc = "Restore last session" })

vim.keymap.set("n", "<C-S-s>", function()
  require("persistence").load({ last = true })
end, { silent = true, desc = "Restore session from current directory" })

vim.keymap.set("n", "<C-q>", function()
  require("persistence").stop()
end, { silent = true, desc = "Stop session tracking" })

-- return {
--   "folke/persistence.nvim",
--   event = "BufReadPre", -- Automatically load the session before reading buffers
--   opts = {
--     -- Options for session management
--     dir = vim.fn.stdpath("data") .. "/sessions/", -- Save session files here
--   keys = {
--     -- Keybindings to save and load sessions
--     {
--       "<leader>qs",
--       function()
--         require("persistence").load()
--       end,
--       desc = "Restore Session",
--     },
--     {
--       "<leader>ql",
--       function()
--         require("persistence").load({ last = true })
--       end,
--       desc = "Restore Last Session",
--     },
--     {
--       "<leader>qd",
--       function()
--         require("persistence").stop()
--       end,
--       desc = "Stop Session",
--     },
--     {
--       "<leader>qw",
--       function()
--         require("persistence").save()
--       end,
--       desc = "Save Session",
--     },
--   },
-- }
