local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

config.color_scheme = "Catppuccin Macchiato"
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
	timeout_milliseconds = 1000,
}

config.keys = {
	{ key = "h", mods = "LEADER", action = act({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = "LEADER", action = act({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "LEADER", action = act({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "LEADER", action = act({ ActivatePaneDirection = "Right" }) },
	{ key = "b", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
	{ key = "o", mods = "LEADER", action = act.PaneSelect },
	{ key = "[", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
	{ key = "R", mods = "LEADER", action = act.ReloadConfiguration },
}

local copy_mode = wezterm.gui.default_key_tables().copy_mode
local custom_copy_mode = {
	{ key = "Escape", mods = "NONE", action = wezterm.action({ CopyMode = "Close" }) },
	{ key = "H", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
	{ key = "L", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
	{ key = "/", mods = "NONE", action = wezterm.action({ Search = { CaseSensitiveString = "" } }) },
	{ key = "n", mods = "NONE", action = wezterm.action({ CopyMode = "NextMatch" }) },
	{ key = "N", mods = "SHIFT", action = wezterm.action({ CopyMode = "PriorMatch" }) },
}

for _, v in ipairs(custom_copy_mode) do
	table.insert(copy_mode, v)
end

config.key_tables = {
	copy_mode = copy_mode,
	search_mode = {
		{ key = "Escape", mods = "NONE", action = wezterm.action({ CopyMode = "Close" }) },
		{ key = "Enter", mods = "NONE", action = "ActivateCopyMode" },
	},
}

return config
