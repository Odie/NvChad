local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Themes
  {'navarasu/onedark.nvim'},
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    config = function()
      -- require("catppuccin").setup({})
      vim.cmd.colorscheme "gruvbox-material"
    end,
  },

  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },
  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- Uncomment if you want to re-enable which-key
  -- {
  --   "folke/which-key.nvim",
  --   enabled = true,
  -- },
  --
  -- Re-enable some default plugins
  {
    "folke/which-key.nvim",
    enabled = true,
    lazy = false,
    config = function()
      -- require "plugins.configs.whichkey"
      require "custom.configs.whichkey"
    end,
  },

  -- FIXME!!! This doesn't seem to work
  {
    dir = "~/dev/vim/gitabra",
		cmd = {"Gitabra"},
		setup = function()
			vim.g.gitabra_dev = 1
		end
	},

  {
    "tpope/vim-fugitive",
		cmd = {"Git", "Gdiffsplit", "GBrowse"},
	},

  {
    "folke/trouble.nvim",
		cmd = {"TroubleToggle"},
    dependencies = {"nvim-tree/nvim-web-devicons", 'folke/lsp-colors.nvim'},
		config = function()
			require("trouble").setup {}
		end
	},

  {
    'notjedi/nvim-rooter.lua',
    lazy = false,
		config = function()
      require'nvim-rooter'.setup({
        rooter_patterns = { '.git', '.hg', '.svn', 'package.json', 'pyproject.toml'},
        update_cwd = true,
        update_focused_file = {
          enable = true,
          update_cwd = true
        },
        -- trigger_patterns = { '*' },
        -- manual = false,
      })
		end
  },

  {
    'kazhala/close-buffers.nvim',
    config = function()
      require('close_buffers').setup({
        preserve_window_layout = { 'this' , 'nameless'},
      })
    end
  },

  {
    'eugen0329/vim-esearch',
    keys = {
      {"<leader>/", '<cmd> call esearch#init() <CR>', desc = 'Search Project' },
    },

    config = function()
      vim.g.esearch = {
        default_mappings = 0,
        win_map = {
          {'n',  'R',		 '<plug>(esearch-win-reload)',					 },
          {'n',  't',		 '<plug>(esearch-win-tabopen)',					 },
          {'n',  'T',		 '<plug>(esearch-win-tabopen:stay)',		 },
          {'n',  'o',		 '<plug>(esearch-win-split)',						 },
          {'n',  'O',		 '<plug>(esearch-win-split:reuse:stay)', },
          {'n',  's',		 '<plug>(esearch-win-vsplit)',					 },
          {'n',  'S',		 '<plug>(esearch-win-vsplit:reuse:stay)',},
          {'n',  '<cr>', '<plug>(esearch-win-open)',						 },
          {'n',  'p',		 '<plug>(esearch-win-preview)',					 },
          {'n',  'P',		 '100<plug>(esearch-win-preview:enter)', },
          {'n',  '<esc>','<plug>(esearch-win-preview:close)',		 },
          {' ',  'J',		 '<plug>(esearch-win-jump:entry:down)'	 },
          {' ',  'K',		 '<plug>(esearch-win-jump:entry:up)'		 },
          {' ',  '}',		 '<plug>(esearch-win-jump:filename:down)'},
          {' ',  '{',		 '<plug>(esearch-win-jump:filename:up)'  },
          {' ',  ')',		 '<plug>(esearch-win-jump:dirname:down)' },
          {' ',  '(',		 '<plug>(esearch-win-jump:dirname:up)'	 },
          {'ov', 'im',	 '<plug>(textobj-esearch-match-i)',			 },
          {'ov', 'am',	 '<plug>(textobj-esearch-match-a)',			 },
          {'ic', '<cr>', '<plug>(esearch-cr)', {nowait= 1}			 },
          {'n',  'I',		 '<plug>(esearch-I)'										 },
          {'x',  'x',		 '<plug>(esearch-d)'										 },
          {'nx', 'd',		 '<plug>(esearch-d)'										 },
          {'n',  'dd',	 '<plug>(esearch-dd)'										 },
          {'nx', 'c',		 '<plug>(esearch-c)'										 },
          {'n',  'cc',	 '<plug>(esearch-cc)'										 },
          {'nx', 'C',		 '<plug>(esearch-C)'										 },
          {'nx', 'D',		 '<plug>(esearch-D)'										 },
          {'x',  's',		 '<plug>(esearch-c)'										 },
          {'n',  '.',		 '<plug>(esearch-.)'										 },
          {'n',  '@:',	 '<plug>(esearch-@:)'										 },
          {'n', 'za',		 '<plug>(esearch-za)'										 },
          {'n', 'zc',		 '<plug>(esearch-zc)'										 },
          {'n', 'zM',		 '<plug>(esearch-zM)'										 },
        }
      }
    end
	},

  {
    "hrsh7th/cmp-cmdline",
    dependencies = {"cmp-buffer"},
    event = 'CmdlineEnter',
    config = function()
      local cmp = require("cmp")
      cmp.setup.cmdline(':', {
        sources = cmp.config.sources(
        {
          { name = 'path' }
        },
        {
          { name = 'cmdline' }
        })
      })
    end
  },

  {
    "hkupty/iron.nvim",
		config = function()
      require("iron.core").setup {
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            sh = {
              command = {"zsh"}
            },

            -- Use ptpython for the repl
            python = require("iron.fts.python").ptpython
          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = require('iron.view').right("40%"),
        },
        -- Iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        keymaps = {
          -- send_motion = ",sc",
          -- visual_send = ",ev",
          -- send_file = ",ef",
          -- send_line = ",el",
          -- send_mark = ",em",
          -- mark_motion = ",mc",
          -- mark_visual = ",mc",
          -- remove_mark = ",md",
          -- cr = ",s<cr>",
          -- interrupt = ",s<space>",
          -- exit = ",sq",
          -- clear = ",cl",
        },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
          italic = true
        }
			}
		end
  },

  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require('hlslens').setup({
        nearest_only = true,
      })
    end
  },


  {
    'ggandor/leap.nvim',
    keys = "s",
    config = function()
      require('leap').set_default_keymaps()
    end
  },

  {
    'andymass/vim-matchup',
    event = "VeryLazy",
  },

  {
    'nvim-treesitter/nvim-treesitter-context',
    event = "VeryLazy",
    config = function()
      require('treesitter-context').setup{enable = true}
    end
  },

  {
    'cbochs/grapple.nvim',
    -- requires = { "nvim-lua/plenary.nvim" },
  },

  {
    'shortcuts/no-neck-pain.nvim',
    version = "*"
  },

  {
    'kylechui/nvim-surround',
    version = '*',
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },

  {
    "tpope/vim-eunuch",
    cmd = {"Move", "Remove", "Delete", "Move", "Chmod",
           "Mkdir", "Cfind", "Clocate", "Lfind", "Llocate", "Wall",
           "SudoWrite", "SudoEdit"}
  },
  {
    'stevearc/aerial.nvim',
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  }

}

return plugins
