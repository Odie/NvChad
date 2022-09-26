-- A typical custom.mappings module should disable and define various
-- keybinds/keymaps.
--
-- However, we don't want to configure our keymaps this way.
-- Just build a map to remove *all* default keybinds. This lets us
-- start from a clean slate without any keybinds.
--
-- For some reason NvChad just sprinkles keybinds randomly.
-- Which-key becomes a bit useless, because there is no way to logically
-- explore and find the keybinds you want.
--
-- See "custom.plugins.config.whichkey" for the actual keybinds
--
local M = {}

local function disable_default_mappings_map()
  local merge_tb = vim.tbl_deep_extend
  local mappings = require("core.mappings")

  local disabled = {}
  for _, cmap in pairs(mappings) do
    disabled = merge_tb("force", disabled, cmap)
  end

  for _, modemap in pairs(disabled) do
    if(type(modemap) == "table") then
      for keybind, _ in pairs(modemap) do
        modemap[keybind] = ""
      end
    end
  end

  return disabled
end

M.disabled = disable_default_mappings_map()

return M
