--#############################################################################
-- Pale White & Charcoal
--#############################################################################

theme = {}

theme.font          = "terminus 8"

theme.bg_normal     = "#272822"
theme.bg_focus      = "#f8f8f2"
theme.bg_urgent     = "#f8f8f2"
theme.bg_minimize   = "#f8f8f2"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#f8f8f2"
theme.fg_focus      = "#272822"
theme.fg_urgent     = "#272822"
theme.fg_minimize   = "#272822"

theme.border_width  = 2
theme.border_normal = "#272822"
theme.border_focus  = "#49483e"
theme.border_marked = "#91231c"

theme.layout_floating = "/home/nil/.config/awesome/themes/nil/layouts/floating.png"
theme.layout_tile = "/home/nil/.config/awesome/themes/nil/layouts/tile.png"
theme.layout_tileleft = "/home/nil/.config/awesome/themes/nil/layouts/tileleft.png"
--theme.layout_floating = " ⮛ "
--theme.layout_tile = " ⮘ "
--theme.layout_tileleft = " ⮙ "

theme.menu_submenu_icon = "/home/nil/.config/awesome/themes/nil/submenu.png"
theme.menu_height = 15
theme.menu_width  = 100

theme.wallpaper1 = "/home/nil/.config/awesome/themes/nil/wallpaper.jpg"
theme.icon_theme = nil

-- Extras to add in.
theme.tag_font  = "terminus 8"
theme.bold      = "#adadad"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
