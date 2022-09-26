local wk = require("which-key")

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

  ["[b"] = {'<cmd>bprev<cr>', 'Next buffer'},
  ["]b"] = {'<cmd>bnext<cr>', 'Prev buffer'},

  -- lsp
  ["gD"] = {
    function()
      vim.lsp.buf.declaration()
    end,
    "lsp declaration",
  },

  ["gd"] = {
    function()
      vim.lsp.buf.definition()
    end,
    "lsp definition",
  },

  ["K"] = {
    function()
      vim.lsp.buf.hover()
    end,
    "lsp hover",
  },

  ["gi"] = {
    function()
      vim.lsp.buf.implementation()
    end,
    "lsp implementation",
  },


  ["gr"] = {
    function()
      vim.lsp.buf.references()
    end,
    "lsp references",
  },


  ["[d"] = {
    function()
      vim.diagnostic.goto_prev()
    end,
    "prev diagnostic",
  },

  ["d]"] = {
    function()
      vim.diagnostic.goto_next()
    end,
    "next diagnostic",
  },

  -- ["<leader>q"] = {
  --   function()
  --     vim.diagnostic.setloclist()
  --   end,
  --   "diagnostic setloclist",
  -- },


  ["<leader>wa"] = {
    function()
      vim.lsp.buf.add_workspace_folder()
    end,
    "add workspace folder",
  },

  ["<leader>wr"] = {
    function()
      vim.lsp.buf.remove_workspace_folder()
    end,
    "remove workspace folder",
  },

  ["<leader>wl"] = {
    function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end,
    "list workspace folders",
  },
}, {prefix=""})

wk.register({

  ['/'] = { '<cmd> call esearch#init() <CR>', 'Search Project' },

  ['<TAB>'] = { '<c-^>','Last Buffer' },

  b = {
    name = "buffer",
    b = { '<cmd>Telescope buffers<cr>', 'Buffers' },

    d = { function() require('close_buffers').delete({ type = 'this' }) end, 'Delete Buffer' },

    -- D = {'<cmd>BufferClose!<cr>', 'Delete Buffer (force)'},
    p = { '<cmd>bprev<cr>', 'Next buffer' },
    n = { '<cmd>bnext<cr>', 'Prev buffer' },
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
    n = { ":echo expand('%:p')<cr>", "Show filename" }
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
    n = {"<C-w><C-w>", "next"}
  }

}, { prefix = "<leader>" })
