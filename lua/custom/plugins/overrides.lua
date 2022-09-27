local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "typescript",
    "c",
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.telescope = {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = function(bufnr) require("telescope.actions").move_selection_next(bufnr) end,
        ["<C-k>"] = function(bufnr) require("telescope.actions").move_selection_previous(bufnr) end,
      }
    },
  },
  extensions = {
      fzy_native = {
          override_generic_sorter = false,
          override_file_sorter = true,
      }
  }
}

return M
