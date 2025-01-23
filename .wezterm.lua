local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Solarized Darcula'

-- make sure that windows don't change size and actually resize to the exact size I want
config.adjust_window_size_when_changing_font_size = false
config.use_resize_increments = false

config.audible_bell = "Disabled"

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

config.enable_scroll_bar = true
config.scrollback_lines = 1000000

config.selection_word_boundary = '{}[]()"\'`.,;: '

config.swallow_mouse_click_on_pane_focus = true
config.swallow_mouse_click_on_window_focus = true

config.default_prog = { '/opt/homebrew/bin/nu', '--login' }

return config