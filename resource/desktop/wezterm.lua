local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.window_background_opacity = 0.7
config.font = wezterm.font_with_fallback {
    'Fira Code',
    'Noto Sans Mono CJK TC',
}

return config
