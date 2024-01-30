Usr_colorscheme = "catppuccin"
local colorscheme_avail, _ = pcall(require, Usr_colorscheme)
if colorscheme_avail then
  colorscheme = Usr_colorscheme
end

local config = {
  -- Set colorscheme
  colorscheme = Usr_colorscheme,
}

return config
