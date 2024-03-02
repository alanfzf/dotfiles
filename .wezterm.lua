local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

config.color_scheme = "Dracula"
config.font_size = 14
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.80
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.audible_bell = "Disabled"

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "pwsh.exe" }
	config.win32_system_backdrop = "Acrylic"
end

-- keybinds
config.leader = {
	key = "q",
	mods = "CTRL",
	timeout_milliseconds = 500,
}

config.keys = {
	{ key = "h", mods = "LEADER", action = act({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = "LEADER", action = act({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "LEADER", action = act({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "LEADER", action = act({ ActivatePaneDirection = "Right" }) },
	{ key = "b", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
	{ key = "p", mods = "LEADER", action = act({ PasteFrom = "Clipboard" }) },
	{ key = "y", mods = "LEADER", action = act({ CopyTo = "Clipboard" }) },
	{ key = "o", mods = "LEADER", action = act.PaneSelect },
	{ key = "f", mods = "SHIFT|CTRL", action = act.Search({ CaseInSensitiveString = "" }) },
	-- activate copy mode shift ctrl x
}

return config
