local cmd	= vim.cmd				-- execute Vim commands

-- Use ; to enter ex command mode
cmd([[
	nnoremap ; :
	nnoremap : ;
	vnoremap ; :
	vnoremap : ;
]])

-- Remove all trailing spaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
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

