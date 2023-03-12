local M = {}

M.ui = {
  theme_toggle = { "gruvbox_material", "onedark"},
  theme = "onedark",
}

M.plugins = require "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
