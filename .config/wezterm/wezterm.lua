local wezterm = require("wezterm")

local config = wezterm.config_builder()

config = {
    automatically_reload_config = true,
    color_scheme = "rose-pine",
    default_cursor_style = "SteadyBlock",
    default_prog = { "/opt/homebrew/bin/zsh", "-l", "-c", "tmux a -t main || tmux new -t main" },
    enable_tab_bar = false,
    font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold", stretch = "Normal", style = "Normal" }),
    font_size = 14.0,
    macos_window_background_blur = 20,
    scrollback_lines = 10000,
    window_background_opacity = 0.95,
    window_close_confirmation = "NeverPrompt",
    window_decorations = "RESIZE",
    window_padding = {
        left = 5,
        right = 0,
        top = 5,
        bottom = 0,
    },
}

return config
