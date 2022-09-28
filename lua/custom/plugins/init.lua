local overrides = require "custom.plugins.overrides"

return {

  -- Re-enable some default plugins
  ["folke/which-key.nvim"] = {
    disable = false,
    -- loaded = true,
    opt = false,
    key = {},
    config = function()
      require "plugins.configs.whichkey"
      require "custom.plugins.config.whichkey"
    end,
  },

  ['goolord/alpha-nvim'] = { disable = false },

  -- Override plugin definition options
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },

  -- overrde plugin configs
  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = overrides.treesitter,
  },

  ["williamboman/mason.nvim"] = {
    override_options = overrides.mason,
  },

  ["kyazdani42/nvim-tree.lua"] = {
    override_options = overrides.nvimtree,
  },

  ["nvim-telescope/telescope.nvim"] = {
    override_options = overrides.telescope,
  },

  -- code formatting, linting etc
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },

  ["~/dev/vim/gitabra"] = {
		cmd = {"Gitabra"},
		setup = function()
			vim.g.gitabra_dev = 1
		end
	},

  ["folke/trouble.nvim"] = {
		cmd = {"TroubleToggle"},
		requires = {"kyazdani42/nvim-web-devicons", 'folke/lsp-colors.nvim'},
		config = function()
			require("trouble").setup {}
		end
	},

  ['airblade/vim-rooter'] = {
		'airblade/vim-rooter',
		config = function()
			vim.g.rooter_silent_chdir = 1
			vim.g.rooter_resolve_links = 1
		end
  },

  ['kazhala/close-buffers.nvim'] = {
    module="close_buffers",
    config = function()
      require('close_buffers').setup({
        preserve_window_layout = { 'this' , 'nameless'},
      })
    end
  },

  ['eugen0329/vim-esearch'] = {
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

  ["hrsh7th/cmp-cmdline"] = {
    after = "cmp-buffer",
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

 ["hkupty/iron.nvim"] = {
    module = {"iron", "iron.core"},
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

  ['kevinhwang91/nvim-hlslens'] = {
    module = "hlslens",
    config = function()
      require('hlslens').setup({
        nearest_only = true,
      })
    end
  },

  ['nvim-telescope/telescope-fzy-native.nvim'] = {
    after = "telescope.nvim",
    config = function()
      require('telescope').load_extension('fzy_native')
    end
  },
}
