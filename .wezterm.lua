local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Fonts
-- config.font = wezterm.font("MesloLGS Nerd Font Mono", { weight = "DemiBold" })
-- config.font = wezterm.font("JetBrains Mono", { weight = "Bold" })
config.font = wezterm.font("SF Mono", { weight = "DemiBold" })
config.font_size = 17
-- config.dpi = 96

-- Remove tab bar
config.enable_tab_bar = false

-- Remove top bar but allow resizing
config.window_decorations = "RESIZE"

-- Aesthetics
config.window_background_opacity = 0.8
config.macos_window_background_blur = 80
config.line_height = 1.2
config.window_padding = {
	top = 10,
	bottom = 0,
	left = 10,
	right = 10,
}
config.allow_square_glyphs_to_overflow_width = "Never"

-- coolnight theme from Josean Martinez (https://www.josean.com/posts/how-to-setup-wezterm-terminal)
config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

-- Disable quit warning
config.window_close_confirmation = "NeverPrompt"
config.keys = {
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
}

return config
