local api = vim.api

local M = {}

function M.noremap(key, val)
	api.nvim_set_keymap('', key,  val, {noremap = true, silent = true})
end

function M.nnoremap(key, val)
	api.nvim_set_keymap('n', key,  val, {noremap = true, silent = true})
end

function M.vnoremap(key, val)
	api.nvim_set_keymap('v', key,  val, {noremap = true, silent = true})
end

function M.tnoremap(key, val)
	api.nvim_set_keymap('t', key,  val, {noremap = true, silent = true})
end

function M.tableConcat(t1, t2)
  for _,v in ipairs(t2) do
    t1[#t1+1] = v
  end
end

function M.unique(arr)
  local result = {}
  local hash = {}
  for _,v in ipairs(arr) do
     if (not hash[v]) then
         result[#result+1] = v -- you could print here instead of saving to result table if you wanted
         hash[v] = true
     end
  end
  return result
end

return M
