--#############################################################################
-- Pale White & Charcoal
--#############################################################################

theme = {}

theme.font          = "nu 9"

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

theme.layout_floating = "/home/dvt/.config/awesome/themes/dvt/layouts/floating.png"
theme.layout_tile = "/home/dvt/.config/awesome/themes/dvt/layouts/tile.png"
theme.layout_tileleft = "/home/dvt/.config/awesome/themes/dvt/layouts/tileleft.png"
--theme.layout_floating = " ⮛ "
--theme.layout_tile = " ⮘ "
--theme.layout_tileleft = " ⮙ "

theme.menu_submenu_icon = "/home/dvt/.config/awesome/themes/dvt/submenu.png"
theme.menu_height = 15
theme.menu_width  = 100

theme.wallpaper1 = "/home/dvt/.config/awesome/themes/dvt/wallpaper.jpg"
theme.icon_theme = dvt

-- Extras to add in.
--theme.tag_font  = "lemon"
--theme.bold      = "#adadad"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
