--#############################################################################
-- Pale White & Charcoal
--#############################################################################

theme = {}

theme.font          = "terminus 8"

theme.bg_normal     = "#f9f9f9"
theme.bg_focus      = "#707070"
theme.bg_urgent     = "#707070"
theme.bg_minimize   = "#707070"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#707070"
theme.fg_focus      = "#f9f9f9"
theme.fg_urgent     = "#f9f9f9"
theme.fg_minimize   = "#f9f9f9"

theme.border_width  = 2
theme.border_normal = "#e0e0e0"
theme.border_focus  = "#707070"
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

theme.wallpaper1 = "/home/nil/.config/awesome/themes/nil/strawberry_morning_desktop-unwatermarked.jpg"
--theme.wallpaper2 = "/home/nil/nil/Media/Pictures/Wallpapers/fiftyfootshadows/still_spring_desktop_unwatermarked.jpg"
theme.icon_theme = nil

-- Extras to add in.
theme.tag_font  = "terminus 8"
theme.bold      = "#adadad"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
