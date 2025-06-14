-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- General
config.automatically_reload_config = true
config.default_prog = { "pwsh.exe", "-NoLogo" }
config.max_fps = 144
config.animation_fps = 60

-- Launcher menu
config.launch_menu = {
	{
		args = { "C:/Programs/QMK_MSYS/shell_connector.cmd" },
		label = "QMK MSYS",
	},
}

-- Color Scheme
-- Change automatically based on OS mode
function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Gruvbox dark, medium (base16)"
	else
		return "Gruvbox light, medium (base16)"
	end
end
config.color_scheme = scheme_for_appearance(get_appearance())

-- Font settings
config.font_size = 14
config.line_height = 1.3
config.font = wezterm.font("Inconsolata Nerd Font", { weight = "Bold", italic = false })

-- Window appearance
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

-- Keybinds
config.leader = { mods = "CTRL", key = "a", timeout_milliseconds = 2000 }
config.keys = {
	-- Launcher
	{ mods = "LEADER", key = "l", action = wezterm.action.ShowLauncher },

	-- Command palette
	{ mods = "LEADER", key = "p", action = wezterm.action.ActivateCommandPalette },

	-- Tabs
	{ mods = "LEADER", key = "c", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ mods = "LEADER", key = "n", action = wezterm.action.ActivateTabRelative(1) },
	{ mods = "LEADER", key = "b", action = wezterm.action.ActivateTabRelative(-1) },
	{ mods = "LEADER", key = "1", action = wezterm.action.ActivateTab(0) },
	{ mods = "LEADER", key = "2", action = wezterm.action.ActivateTab(1) },
	{ mods = "LEADER", key = "3", action = wezterm.action.ActivateTab(2) },
	{ mods = "LEADER", key = "4", action = wezterm.action.ActivateTab(3) },
	{ mods = "LEADER", key = "5", action = wezterm.action.ActivateTab(4) },

	-- Panes
	{ mods = "LEADER", key = "|", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ mods = "LEADER", key = "-", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ mods = "LEADER", key = "h", action = wezterm.action.ActivatePaneDirection("Left") },
	{ mods = "LEADER", key = "j", action = wezterm.action.ActivatePaneDirection("Down") },
	{ mods = "LEADER", key = "k", action = wezterm.action.ActivatePaneDirection("Up") },
	{ mods = "LEADER", key = "l", action = wezterm.action.ActivatePaneDirection("Right") },
	{ mods = "LEADER", key = "x", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
}

-- Finally, return the configuration to wezterm:
return config
