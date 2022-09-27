local cmd	= vim.cmd				-- execute Vim commands
local g		= vim.g					-- global variables

g.maplocalleader = ","    -- Local leader is comma

-- Use ; to enter ex command mode
cmd([[
	nnoremap ; :
	nnoremap : ;
	vnoremap ; :
	vnoremap : ;
]])

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

-- Load which-key and setup all the keybinds
-- This eventually causes "customs.plugins.config.whichkey" to be loaded
autocmd("VimEnter", {
  callback = function()
    require("which-key")
  end,
})
