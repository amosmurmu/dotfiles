-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- Add your ~/.config/nvim/snippets folder to Neovim's runtimepath

vim.opt.rtp:append(vim.fn.stdpath("config") .. "/snippets")
