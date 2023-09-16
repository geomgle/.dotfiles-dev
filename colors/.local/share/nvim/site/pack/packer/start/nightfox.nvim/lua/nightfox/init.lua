local util = require("nightfox.util")

local M = {}

local function construct(colors)
  colors.harsh = colors.white
  colors.subtle = colors.black
  return colors
end

-- Loads colorscheme and applies the highlight groups.
-- If a name is passed it will override what was set in the configuration setup.
-- @param name string
function M.load()
  local colors = construct(require("nightfox.colors.nightfox").load())
  local theme = require("nightfox.theme").apply(colors)

  util.load(theme, false)
end

return M
