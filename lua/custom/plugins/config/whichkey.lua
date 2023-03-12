local wk = require("which-key")

local function grapple_toggle()
  local grapple = require("grapple")

  if grapple.exists() then
    grapple.untag()
    print("File untagged")
  else
    grapple.tag()
    print("File tagged")
  end

end

-- Jump the the 2nd to last most recently used and listed buffer
local function jump_to_last_buffer()
  local api = vim.api

  -- Grab a list of all buffers
  local buffers = vim.fn.getbufinfo({buflisted=1})
  if #buffers < 2 then
    print("No buffers to jump to")
    return
  end

  -- Sort by last used time
  table.sort(buffers, function(a, b)
    return a.lastused > b.lastused
  end)

  -- Switch to the previous buffer used
  api.nvim_win_set_buf(0, buffers[2].bufnr)
end

local function buffer_delete_other()
  local curBufnr = vim.fn.bufnr()

  local buffers = vim.fn.getbufinfo({buflisted=1})
  for _, buf in ipairs(buffers) do
    local nr = buf['bufnr']
    if nr ~= curBufnr then
      vim.api.nvim_buf_delete(nr, {})
    end
  end
end

local function git_root()
  return vim.fn.system("git rev-parse --show-toplevel")
end

local function git_repo_relative_filepath(filepath)
  local root = git_root()
  print("root: ", root)
  print(#root)
  if not root then
    return filepath
  end

  return string.sub(filepath, #root)
end

wk.register({
  -- switch between windows
  ["<C-h>"] = { "<C-w>h", "window left" },
  ["<C-l>"] = { "<C-w>l", "window right" },
  ["<C-j>"] = { "<C-w>j", "window down" },
  ["<C-k>"] = { "<C-w>k", "window up" },

  -- Copy whole buffer
  ["<C-c>"] = { "<cmd> %y+ <CR>", "copy whole file" },

  ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "File tree" },
  ["<C-p>"] = { "<cmd> Telescope find_files <CR>", "Find File"},
  ["<C-[>"] = { "<cmd> Telescope find_files <CR>", "Find File"},

  ["[b"] = {'<cmd>bprev<cr>', 'Next buffer'},
  ["]b"] = {'<cmd>bnext<cr>', 'Prev buffer'},

  -- lsp
  ["gD"] = { function() vim.lsp.buf.declaration() end, "lsp declaration" },
  ["gd"] = { function() vim.lsp.buf.definition() end, "lsp definition" },
  ["gi"] = { function() vim.lsp.buf.implementation() end, "lsp implementation" },
  ['gl'] = { function() vim.diagnostic.open_float({scope="line"}) end, "line diagnostics" },
  ["gr"] = { function() vim.lsp.buf.references() end, "lsp references" },

  ["K"] = { function() vim.lsp.buf.hover() end, "lsp hover" },

  ["[d"] = { function() vim.diagnostic.goto_prev() end, "prev diagnostic" },
  ["]d"] = { function() vim.diagnostic.goto_next() end, "next diagnostic" },

  ["n"] = {
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    "search - next"
  },

  ["N"] = {
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    "search - prev"
  },

  ["*"] = [[*<Cmd>lua require('hlslens').start()<CR>]],
  ["#"] = [[#<Cmd>lua require('hlslens').start()<CR>]],

}, {prefix=""})

wk.register({

  a = {function() git_root() end, "run test"},
  ['/'] = { '<cmd> call esearch#init() <CR>', 'Search Project' },

  ['<TAB>'] = { function() jump_to_last_buffer() end, 'Last Buffer' },

  ['<SPACE>'] = {

    ['1'] = { function() require('grapple').select({ key = 1 }) end, "Grapple file 1" },
    ['2'] = { function() require('grapple').select({ key = 2 }) end, "Grapple file 2" },
    ['3'] = { function() require('grapple').select({ key = 3 }) end, "Grapple file 3" },
    ['4'] = { function() require('grapple').select({ key = 4 }) end, "Grapple file 4" },

    g = { function() require('grapple').popup_tags() end, "Grapple menu"},
    t = { function() grapple_toggle() end, "Grapple Toggle" },
    ['<TAB>'] = { function() require('grapple').cycle_backward() end, "Grapple backwards"},
    ['\\'] = { function() require('grapple').cycle_forward() end, "Grapple forward"},
  },

  b = {
    name = "buffer",
    b = { '<cmd>Telescope buffers<cr>', 'Buffers' },

    d = { function() require('close_buffers').delete({ type = 'this' }) end, 'Delete Buffer' },
    D = { function() buffer_delete_other() end, "Delete other buffers" },

    -- D = {'<cmd>BufferClose!<cr>', 'Delete Buffer (force)'},
    p = { '<cmd>bprev<cr>', 'Next buffer' },
    n = { '<cmd>bnext<cr>', 'Prev buffer' },

    m = { function() require('grapple').popup_tags() end, "Grapple menu"},
    t = { function() grapple_toggle() end, "Grapple Toggle" },
  },

  d = {
    name = 'diagnostics',
    t = { '<cmd>TroubleToggle<cr>', 'trouble' },
    w = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'workspace' },
    d = { '<cmd>TroubleToggle document_diagnostics<cr>', 'document' },
    q = { '<cmd>TroubleToggle quickfix<cr>', 'quickfix' },
    l = { '<cmd>TroubleToggle loclist<cr>', 'loclist' },
    r = { '<cmd>TroubleToggle lsp_references<cr>', 'references' },
  },

  f = {
    name = 'files',

    e = {
      name = 'editor',
      d = { "<cmd>e $MYVIMRC<cr>", "Open Config File" },
      r = { '<cmd>:source $MYVIMRC<cr><cmd>echom "Sourced vimrc"<cr>', "Reload config file" },
    },

    a = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find All" },
    f = { "<cmd> Telescope find_files <CR>", "Find File" },
    g = { "<cmd> Telescope live_grep <CR>", "Live Grep" },
    r = { "<cmd> Telescope oldfiles <CR>", "Recent Files" },

    -- t = {'<cmd>NvimTreeToggle<cr>', 'File tree'},
    t = { '<cmd>NvimTreeFindFile<cr>', 'File tree' },
    -- t = {'<cmd>NvimTreeFindFileToggle<cr>', 'File tree'},
    -- n = { ":echo expand('%:p')<cr>", "Show filename" }
    n = { function() print(git_repo_relative_filepath(vim.fn.expand('%:p'))) end, "Show filename" }
  },

  g = {
    name = "git",
    b = { "<cmd> Telescope git_branches <CR>", "Switch Branch" },
    -- B = {'<cmd>Gblame<cr>', "Git Blame"},
    s = { "<cmd> Gitabra <CR>", "Gitabra" },
    -- d = {'<cmd>Gdiff<cr>', "Git Diff"},
    -- l = {'<cmd>Glog<cr>', "Git Log"},
    -- c = {'<cmd>Gcommit<cr>', "Git Commit"},
    -- p = {'<cmd>Gpush<cr>', "Git Push"},
  },

  h = {
    name = 'help',
    t = { "<cmd> Telescope help_tags <CR>", "Help page" },
    k = { "<cmd> Telescope keymaps <CR>", "Show keys" },
  },

  l = {
    name = "lsp",
    a = {
      name = "action",
      r = { function() require("nvchad_ui.renamer").open() end, "Rename" },
      a = { function() vim.lsp.buf.code_action() end, "Code action" },
    },
    d = { function() vim.diagnostic.open_float() end, "diagnostic window" },
    D = { function() vim.lsp.buf.type_definition() end, "Type definition" },
    f = { function() vim.lsp.buf.formatting {} end, "lsp formatting" },
    s = { function() vim.lsp.buf.signature_help() end, "Signature help" },

    w = {
      name = "workspace",
      a = { function() vim.lsp.buf.add_workspace_folder() end, "add workspace folder" },
      r = { function() vim.lsp.buf.remove_workspace_folder() end, "remove workspace folder" },
      l = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "list workspace folders" },
    }
  },

  p = {
    name = "pick (telescope)",
    s = { function() require'telescope.builtin'.lsp_dynamic_workspace_symbols{} end, "Find workspace symbol"},
  },

  t = {
    name = "toggle",
    i = {'<cmd> IndentBlanklineToggle <CR>', 'Indent guide'},
    L = {'<cmd> set wrap! <cr>', 'Line wrap'},
    l = {'<cmd> set list! <cr>', 'List invisible characters'},
    n = { "<cmd> set nu! <CR>", "Line number" },
    N = { "<cmd> set rnu! <CR>", "Relative number" },

    t = {
      function()
        require("base46").toggle_theme()
      end,
      "Theme",
    },

    T = { "<cmd> Telescope themes <CR>", "Theme Picker" },
  },

  -- q = {'<cmd>close<cr>', 'Close window'},
  q = { function() require("nvchad_ui.tabufline").close_buffer() end, "Close buffer" },

  w = {
    name = "window",
    n = {"<C-w><C-w>", "window next"}
  }

}, { prefix = "<leader>" })
