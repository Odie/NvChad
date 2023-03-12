local cmd	= vim.cmd				-- execute Vim commands
local g		= vim.g					-- global variables
local u   = require("custom.util")

g.maplocalleader = ","    -- Local leader is comma

-- Use ; to enter ex command mode
cmd([[
	nnoremap ; :
	nnoremap : ;
	vnoremap ; :
	vnoremap : ;
]])

u.nnoremap('<esc>', ':nohlsearch<return><esc>')

local autocmd = vim.api.nvim_create_autocmd

-- Remove all trailing spaces
autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("RemoveTrainlingSpaces", {clear = true}),
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Automatically set +x on shebang files
vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("AutoSetExeBit", {clear = true}),
	callback = function()
		local line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
		if (string.find(line, "^#!")) then
			vim.fn.jobstart({"chmod", "u+x", vim.fn.expand('%:p')})
		end
	end
})

-- Jump to last viewed location of the newly opened file
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Load which-key and setup all the keybinds
-- This eventually causes "customs.plugins.config.whichkey" to be loaded
autocmd("VimEnter", {
  callback = function()
    require("which-key")
  end,
})

local opt = vim.opt
opt.scrolloff = 8

-- Move blocks of code up and down using J and K in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-3<CR>gv=gv")

-- Keep the cursor in the middle of the screen after paging up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-y>", "<C-u>zz")

-- Jumping to next search term keeps cursor in the middle of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Enable pasting over current selection
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Quickfix shortcuts
vim.keymap.set("n", "<C-k>", "<CMD>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<CMD>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<CMD>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<CMD>lprev<CR>zz")
