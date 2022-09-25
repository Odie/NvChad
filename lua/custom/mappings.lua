local M = {}

-- M.disabled = {
--   n = {
--     ["<C-s>"] = "",
--
--     ["<leader>n"] = "",
--     ["<leader>rn"] = "",
--     ["<leader>uu"] = "",
--     ["<leader>b"] = "",
--
--
--   }
-- }

M.general = {
  n = {
    ["<leader>bd"] = {
      function()
        require('close_buffers').delete({ type = 'this' })
      end ,
      "new buffer" },

    ['/'] = {'<cmd>call esearch#init()<cr>', 'Search Project' },
  },

}

M.telescope = {
  n = {
    ["<C-p>"] = { "<cmd> Telescope find_files <CR>", "find files" },
    ["<leader>bb"] = { "<cmd>Telescope buffers<cr>" , "find buffer" },
  },
}

return M
