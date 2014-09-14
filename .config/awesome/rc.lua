--
-- Awesome dotfile
-- ~/.config/awesome/rc.lua
-- Name: nil
--
-- Initial Settings {{{
-------------------------------------------------------------------------------

--#############################################################################
-- Libraries
--#############################################################################

local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local bashets = require("bashets")
local center = require("center")
require("eminent")
local vicious = require("vicious")

--#############################################################################
-- Error Handling
--#############################################################################

if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end

--#############################################################################
-- Variable Definitions
--#############################################################################

terminal = "urxvt -name term"
modkey = "Mod1"
modkey2 = "Mod4"

-- }}}
-- Dialogs {{{
-------------------------------------------------------------------------------

--#############################################################################
-- Tags, Layouts, & Wallpapers
--#############################################################################

local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
}

tags = {
    --names1  = { "i", "ii", "iii", "iv", "v", "vi", "vii", "viii", "ix", "x" },
    --layout1 = { layouts[1], layouts[2], layouts[2], layouts[2], layouts[1],
    --          layouts[1], layouts[1], layouts[1], layouts[1], layouts[1] },
    --names2  = { "i", "ii", "iii", "iv", "v" },
    --layout2 = { layouts[1], layouts[1], layouts[1], layouts[1], layouts[1]}
    names1  = { "i", "ii", "iii", "iv", "v", "vi", "vii", "viii", "ix", "x" },
    layout1 = { layouts[1], layouts[1], layouts[1], layouts[1], layouts[1],
              layouts[1], layouts[1], layouts[1], layouts[1], layouts[1] },
}

beautiful.init("/home/nil/.config/awesome/themes/nil/theme.lua")

for s = 1, screen.count() do
    --if (s == 1) then
            tags[s] = awful.tag(tags.names1, s, tags.layout1)
            gears.wallpaper.maximized(beautiful.wallpaper1, s, true)
    --else
    --        tags[s] = awful.tag(tags.names2, s, tags.layout2)
    --        gears.wallpaper.maximized(beautiful.wallpaper2, s, true)
    --end
end

--#############################################################################
-- Menus
--#############################################################################

system = {
   { "poweroff", "sudo poweroff" },
   { "reboot", "sudo reboot" },
   { "suspend", "sudo pm-suspend-hybrid" },
   { "display off", "xset dpms force off" }
}

mymainmenu = awful.menu({ items = {
     { "⮪ system", system, beautiful.awesome_icon },
     { "⮩ urxvt", terminal },
     { "⮤ scrot", "scrot /home/nil/nil/media/pictures/screencaps/scrot/%Y-%m-%d-%T.png" },
     { "⮤ byzanz", "byzanz-record -c -d 10 nil.gif" },
     }
})

-- }}}
-- Wibox {{{
-------------------------------------------------------------------------------

--#############################################################################
-- Bashets Widgets: Battery, Clock, Irssi Notification, Mail Notification, mpv
--#############################################################################

bashets.set_script_path("/home/nil/.config/awesome/widgets/")
batwidget = wibox.widget.textbox()
clockwidget = wibox.widget.textbox()
irssiwidget = wibox.widget.textbox()
mailwidget = wibox.widget.textbox()
mpdwidget = wibox.widget.textbox()
mpvwidget = wibox.widget.textbox()
bashets.register("battery.sh", {
    widget = batwidget,
    format = '<span font="terminus 8">$1 <span color="#adadad">$2</span> $3</span>',
    --if $2 | grep < 20
    --format = '<span font="terminus 8" color=#FF96A3">$1',
    update_time = 1,
    separator = " | "})
bashets.register("clock.sh", {
    widget = clockwidget,
    format = '<span font="terminus 8">$1</span>',
    update_time = 60, separator = "nil"})
bashets.register("irssi-notify.sh", {
    widget = irssiwidget,
    format = '<span font="terminus 8" color="#FF96A3">$1</span>',
    update_time = 1,
    separator = "nil"})
--bashets.register("mail-notify.sh", {
    --widget = mailwidget,
    --format = '<span font="terminus 8" color="#FF96A3">$1</span>',
    --update_time = 90,
    --separator = "nil"})
bashets.register("now-playing-mpd.sh", {
    widget = mpdwidget,
    format = '<span font="terminus 8">$1 <span color="#adadad">$2</span> $3 <span color="#adadad">$4</span> $5</span>',
    --if $2 | grep stopped
    --format = '<span font="terminus 8">  $1<span color="#adadad">$2</span>$3</span>',
    update_time = 1,
    separator = " | "})
bashets.register("now-playing-mpv.sh", {
    widget = mpvwidget,
    format = '<span font="terminus 8">$1</span>',
    update_time = 1,
    separator = "nil"})
bashets.start()

--#############################################################################
-- Volume Widget
--#############################################################################

--volwidget = wibox.widget.textbox()
--vicious.register(volwidget, vicious.widgets.volume,
--function (widget, args)
--  if (args[2] ~= "♩" ) then
--            if tonumber(args[1]) > 99 then
--volbar = "<span color='#adadad'>----------</span><span color='#707070'> </span>"
--elseif tonumber(args[1]) > 90 then
--                volbar = "<span color='#adadad'>---------</span><span color='#707070'>- </span>"
--            elseif tonumber(args[1]) > 80 then
--                volbar = "<span color='#adadad'>--------</span><span color='#707070'>-- </span>"
--            elseif tonumber(args[1]) > 70 then
--                volbar = "<span color='#adadad'>-------</span><span color='#707070'>--- </span>"
--            elseif tonumber(args[1]) > 60 then
--                volbar = "<span color='#adadad'>------</span><span color='#707070'>---- </span>"
--            elseif tonumber(args[1]) > 50 then
--                volbar = "<span color='#adadad'>-----</span><span color='#707070'>----- </span>"
--            elseif tonumber(args[1]) > 40 then
--                volbar = "<span color='#adadad'>----</span><span color='#707070'>------ </span>"
--            elseif tonumber(args[1]) > 30 then
--                volbar = "<span color='#adadad'>---</span><span color='#707070'>------- </span>"
--            elseif tonumber(args[1]) > 20 then
--                volbar = "<span color='#adadad'>--</span><span color='#707070'>-------- </span>"
--            elseif tonumber(args[1]) > 10 then
--                volbar = "<span color='#adadad'>-</span><span color='#707070'>--------- </span>"
--else
--volbar = "<span color='#adadad'></span><span color='#707070'>---------- </span>"
--            end
--     return '⮜ '.. volbar ..' '
--  else
--     return '⮜ [<span color="#adadad">mute</span>]'
--  end
--
--end, 1, "Master")

--#############################################################################
-- Tag List & Layout Widgets
--#############################################################################

mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mylayoutbox = {}

--#############################################################################
-- Widget Creation
--#############################################################################

mywibox = {}
for s = 1, screen.count() do
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    --if (s == 1) then
    --    local left_layout = wibox.layout.fixed.horizontal()
    --    left_layout:add(mytaglist[s])
    --    left_layout:add(mylayoutbox[s])
    --
    --    local right_layout = wibox.layout.fixed.horizontal()
    --    --right_layout:add(volwidget)
    --    --right_layout:add(mailwidget)
    --    right_layout:add(irssiwidget)
    --
    --    -- [L] Use this if you only have laptop display.
    --    --right_layout:add(mpvwidget)
    --    --right_layout:add(mpdwidget)
    --
    --    right_layout:add(batwidget)
    --
    --    layout = center.horizontal()
    --    layout:set_left(left_layout)
    --    layout:set_middle(clockwidget)
    --    layout:set_right(right_layout)
    --else
    --    local left_layout = wibox.layout.fixed.horizontal()
    --    left_layout:add(mytaglist[s])
    --    left_layout:add(mylayoutbox[s])
    --
    --    local right_layout = wibox.layout.fixed.horizontal()
    --    right_layout:add(mpvwidget)
    --    right_layout:add(mpdwidget)
    --
    --    layout = center.horizontal()
    --    layout:set_left(left_layout)
    --    layout:set_middle(clockwidget)
    --    layout:set_right(right_layout)
    --end

    --temp
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(mytaglist[s])
        left_layout:add(mylayoutbox[s])

        local right_layout = wibox.layout.fixed.horizontal()
        --right_layout:add(volwidget)
        --right_layout:add(mailwidget)
        right_layout:add(irssiwidget)
        right_layout:add(mpvwidget)
        right_layout:add(mpdwidget)
        right_layout:add(batwidget)

        layout = center.horizontal()
        layout:set_left(left_layout)
        layout:set_middle(clockwidget)
        layout:set_right(right_layout)
    mywibox[s]:set_widget(layout)
end

-- }}}
-- Mappings {{{
-------------------------------------------------------------------------------

--#############################################################################
-- Mouse
--#############################################################################

root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end)
))

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize)
)

--#############################################################################
-- Keybindings: Awesome & Layout Manipulation
--#############################################################################

globalkeys = awful.util.table.join(
    awful.key({ modkey, "Shift" }, "r", awesome.restart),
    awful.key({ modkey, "Shift" }, "q", awesome.quit),
    awful.key({ modkey,         }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift" }, "space", function () awful.layout.inc(layouts, -1) end),

--#############################################################################
-- Keybindings: Directional Focusing, Manual Window Movement, & Resizing
--#############################################################################

    awful.key({ modkey }, "n", function () awful.client.focus.bydirection("down")
        if client.focus then client.focus:raise() end end),
    awful.key({ modkey }, "e", function () awful.client.focus.bydirection("up")
        if client.focus then client.focus:raise() end end),
    awful.key({ modkey }, "s", function () awful.client.focus.bydirection("left")
        if client.focus then client.focus:raise() end end),
    awful.key({ modkey }, "t", function () awful.client.focus.bydirection("right")
        if client.focus then client.focus:raise() end end),

    awful.key({ modkey, "Shift"   }, "n",     function () awful.client.moveresize(  0,  20,   0,   0) end),
    awful.key({ modkey, "Shift"   }, "e",     function () awful.client.moveresize(  0, -20,   0,   0) end),
    awful.key({ modkey, "Shift"   }, "s",     function () awful.client.moveresize(-20,   0,   0,   0) end),
    awful.key({ modkey, "Shift"   }, "t",     function () awful.client.moveresize( 20,   0,   0,   0) end),
    awful.key({ modkey, "Shift"   }, "Down",  function () awful.client.moveresize(  0,  20,   0,   0) end),
    awful.key({ modkey, "Shift"   }, "Up",    function () awful.client.moveresize(  0, -20,   0,   0) end),
    awful.key({ modkey, "Shift"   }, "Left",  function () awful.client.moveresize(-20,   0,   0,   0) end),
    awful.key({ modkey, "Shift"   }, "Right", function () awful.client.moveresize( 20,   0,   0,   0) end),
    awful.key({ modkey, "Control" }, "n",     function () awful.client.moveresize(  0,   1,   0,   0) end),
    awful.key({ modkey, "Control" }, "e",     function () awful.client.moveresize(  0,  -1,   0,   0) end),
    awful.key({ modkey, "Control" }, "s",     function () awful.client.moveresize( -1,   0,   0,   0) end),
    awful.key({ modkey, "Control" }, "t",     function () awful.client.moveresize(  1,   0,   0,   0) end),

    awful.key({ modkey            }, "Down",  function () awful.client.moveresize(  0,   0,   0,  20) end),
    awful.key({ modkey            }, "Up",    function () awful.client.moveresize(  0,   0,   0, -20) end),
    awful.key({ modkey            }, "Left",  function () awful.client.moveresize(  0,   0, -20,   0) end),
    awful.key({ modkey            }, "Right", function () awful.client.moveresize(  0,   0,  20,   0) end),
    awful.key({ modkey, "Control" }, "Down",  function () awful.client.moveresize(  0,   0,   0,   1) end),
    awful.key({ modkey, "Control" }, "Up",    function () awful.client.moveresize(  0,   0,   0,  -1) end),
    awful.key({ modkey, "Control" }, "Left",  function () awful.client.moveresize(  0,   0,  -1,   0) end),
    awful.key({ modkey, "Control" }, "Right", function () awful.client.moveresize(  0,   0,   1,   0) end),

--#############################################################################
-- Keybindings: Application Focusing & Spawning
--#############################################################################

    awful.key({ modkey }, "Return", function () awful.util.spawn(terminal)                end),
    awful.key({ modkey }, "l", function () run_or_raise(terminal,  { instance = "term" }) end),
    awful.key({ modkey }, "v", function () run_or_raise("gvim",    { class = "Gvim"    }) end),
    awful.key({ modkey }, "a", function () run_or_raise("urxvt -name tcli -g 127x18 -e nil-transmission-remote-cli", { instance = "tcli" }) end),
    --awful.key({ modkey }, "a", function () run_or_raise("urxvt -name tcli -font 'xft:uushi' -boldFont 'xft:uushi' -g 127x18 -e nil-transmission-remote-cli", { instance = "tcli" }) end),
    awful.key({ modkey }, "f", function () run_or_raise("firefox", { class = "Firefox" }) end),
    awful.key({ modkey }, "b", function () run_or_raise("libreoffice /home/nil/Dropbox/nil/interests/macros.ods", { instance = "VCLSalFrame" }) end),
    awful.key({ modkey }, "k", function () run_or_raise("skype",    { class = "Skype"    }) end),

    -- [L+E] Use this if you have both laptop and external display.
    --awful.key({ modkey }, "u", function () run_or_raise("urxvt -name nil -font 'xft:uushi' -boldFont 'xft:uushi' -g 85x24", { instance = "nil" }) end),
    --awful.key({ modkey }, "i", function () run_or_raise("urxvt -name irssi -font 'xft:uushi' -boldFont 'xft:uushi' -g 85x31 -e irssi", { instance = "irssi" }) end),
    --awful.key({ modkey }, "p", function () run_or_raise("urxvt -name ncmpcpp -font 'xft:uushi' -boldFont 'xft:uushi' -g 85x9 -e ncmpcpp", { instance = "ncmpcpp" }) end),
    --awful.key({ modkey }, "f", function () run_or_raise("urxvt -name ranger -font 'xft:uushi' -boldFont 'xft:uushi' -g 85x19 -e ranger", { instance = "ranger" }) end),

    -- [L] Use this if you only have laptop display.
    awful.key({ modkey }, "u", function () run_or_raise("urxvt -name nil -g 85x24", { instance = "nil" }) end),
    awful.key({ modkey }, "i", function () run_or_raise("urxvt -name irssi -g 102x35 -e irssi", { instance = "irssi" }) end),
    awful.key({ modkey }, "p", function () run_or_raise("urxvt -name ncmpcpp -g 102x10 -e ncmpcpp", { instance = "ncmpcpp" }) end),
    awful.key({ modkey }, "r", function () run_or_raise("urxvt -name ranger -g 102x21 -e ranger", { instance = "ranger" }) end),

    awful.key({ modkey }, "m", function () run_or_raise("", { class = "Calibre-ebook-viewer" }, { class = "feh" }, { class = "Mcomix" }, { class = "mpv" }) end),
    awful.key({ modkey }, "z", function () run_or_raise("", { class = "Zathura" }) end),

--#############################################################################
-- Keybindings: Widget Dialogs
--#############################################################################

    awful.key({ modkey,         }, "c", function () awful.util.spawn("calendar-toggle") end),
    awful.key({ modkey, "Shift" }, "i", function () awful.util.spawn_with_shell("echo >> /home/nil/.irssi/logs/fnotify") end),
    --awful.key({ modkey }, "v", function () awful.util.spawn_with_shell("sh -c 'xdotool type \"$(xsel)\"'") end),
    awful.key({                 }, "Print", function () awful.util.spawn("touchpad-toggle") end),

--#############################################################################
-- Keybindings: Media Keys
--#############################################################################

    awful.key({ }, "Pause",  function () awful.util.spawn_with_shell("play-pause") end),
    awful.key({ }, "F10", function () awful.util.spawn("amixer set Master toggle | amixer set IEC958 toggle"     ) end),
    awful.key({ }, "F11",  function () awful.util.spawn("amixer set Master 2%- unmute | amixer set PCM 2%- unmute") end),
    awful.key({ }, "F12", function () awful.util.spawn("amixer set Master 2%+ unmute | amixer set PCM 2%+ unmute") end),

    -- restore all minimized clients
    awful.key({ modkey, "Shift"   }, "m",
        function()
            local tag = awful.tag.selected()
                for i=1, #tag:clients() do
                    tag:clients()[i].minimized=false
            end
        end)
)

--#############################################################################
-- Keybindings: Client Manipulation
--#############################################################################

clientkeys = awful.util.table.join(
    awful.key({ modkey, "Shift" }, "f", function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey          }, "d", function (c) c:kill()                         end),
    awful.key({ modkey          }, "o", function (c) c.ontop = not c.ontop            end)
)

--#############################################################################
-- Keybindings: Tags
--#############################################################################

for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = 1
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = 1
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.movetotag(tag)
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.toggletag(tag)
                      end
                  end))
end
globalkeys = awful.util.table.join(globalkeys,
    awful.key({ modkey }, "0" ,
              function ()
                    local screen = 1
                    local tag = awful.tag.gettags(screen)[10]
                    if tag then
                       awful.tag.viewonly(tag)
                    end
              end),
    awful.key({ modkey, "Control" }, "0",
              function ()
                  local screen = 1
                  local tag = awful.tag.gettags(screen)[10]
                  if tag then
                     awful.tag.viewtoggle(tag)
                  end
              end),
    awful.key({ modkey, "Shift" }, "0",
              function ()
                  local tag = awful.tag.gettags(client.focus.screen)[10]
                  if client.focus and tag then
                      awful.client.movetotag(tag)
                 end
              end),
    awful.key({ modkey, "Control", "Shift" }, "0",
              function ()
                  local tag = awful.tag.gettags(client.focus.screen)[10]
                  if client.focus and tag then
                      awful.client.toggletag(tag)
                  end
              end))
for i = 1, 5 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey2 }, "#" .. i + 9,
                  function ()
                        local screen = 2
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey2, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = 2
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey2, "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.movetotag(tag)
                     end
                  end),
        awful.key({ modkey2, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.toggletag(tag)
                      end
                  end))
end

root.keys(globalkeys)

-- }}}
-- Rules {{{
-------------------------------------------------------------------------------

awful.rules.rules = {
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons } },

--#############################################################################
-- Workspace 1
--#############################################################################

    -- [L+E] Use this if you have both laptop and external display.
    --{ rule = { class = "Gvim" },
    --  properties = { switchtotag = true },
    --  callback = function(c) c:geometry({x=1950, y=40}) end },
    --{ rule = { instance = "tcli" },
    --  properties = { tag = tags[1][1], switchtotag = true },
    --  callback = function(c) c:geometry({x=1950, y=560}) end },

    -- [L] Use this if you only have laptop display.
    { rule = { class = "Gvim" },
      properties = { switchtotag = true },
      callback = function(c) c:geometry({x=30, y=40}) end },
    { rule = { instance = "tcli" },
      properties = { tag = tags[1][1], switchtotag = true },
      callback = function(c) c:geometry({x=30, y=660}) end },

--#############################################################################
-- Workspace 2
--#############################################################################

     { rule = { role = "browser" },
      properties = { tag = tags[1][2], switchtotag = true },
      callback = function(c) c:geometry({x=10, y=30, width = 1575, height = 850}) end },
     { rule_any = { name = {"Options for Menu Editor", "Firefox Preferences", "Page Info", "Tab Mix Plus Options",
                  "Library"}, instance = {"plugin-container"} },
      properties = { floating = true },
      callback = awful.placement.centered },

--#############################################################################
-- Workspace 3
--#############################################################################

    { rule = { instance = "VCLSalFrame" },
      properties = { tag = tags[1][3], floating = false, switchtotag = true } },
    { rule = { class = "r_x11" },
      properties = { tag = tags[1][3], switchtotag = true } },

--#############################################################################
-- Workspace 4
--#############################################################################

    { rule = { class = "gimp" },
      properties = { tag = tags[1][4], switchtotag = true } },
    { rule = { class = "VirtualBox" },
      properties = { tag = tags[1][4], floating = false, switchtotag = true } },
    { rule = { class = "Skype" },
      properties = { tag = tags[1][4], switchtotag = true },
      callback = function(c) c:geometry({x=60, y=40}) end },
     { rule_any = { class = {"Skype"}, role = {"ConversationsWindow"} },
      properties = { floating = true },
      callback = function(c) c:geometry({x=300, y=40}) end },

--#############################################################################
-- Workspace 1 ([L+E]) or Workspace 5 & 10 ([L])
--#############################################################################

    -- [L+E] Use this if you have both laptop and external display.
    --{ rule = { instance = "irssi" },
    --  properties = { tag = tags[2][1], switchtotag = true },
    --  callback = function(c) c:geometry({x=1340, y=175}) end },
    --{ rule = { instance = "nil" },
    --  properties = { tag = tags[2][1], switchtotag = true },
    --  callback = function(c) c:geometry({x=1340, y=550}) end },
    --{ rule = { instance = "ncmpcpp" },
    --  properties = { tag = tags[2][1], switchtotag = true },
    --  callback = function(c) c:geometry({x=1340, y=40}) end },
    --{ rule = { instance = "ranger" },
    --  properties = { tag = tags[2][1], switchtotag = true },
    --  callback = function(c) c:geometry({x=1340, y=845}) end },
    --{ rule = { class = "Calibre-ebook-viewer" },
    --  properties = { tag = tags[2][1], switchtotag = true },
    --  callback = function(c) c:geometry({x=275, y=40, width = 800, height = 1020}) end },
    --{ rule = { class = "feh" },
    --  properties = { tag = tags[2][1], switchtotag = true },
    --  callback = function(c) c:geometry({x=0, y=0}) end },
    --{ rule = { class = "Mcomix" },
    --  properties = { tag = tags[2][1], switchtotag = true },
    --  callback = function(c) c:geometry({x=300, y=42, width=780, height=1016}) end },
    --{ rule = { class = "mpv" },
    --  properties = { tag = tags[2][1], switchtotag = true },
    --  callback = function(c) c:geometry({x=65, y=200}) end },
    --{ rule = { class = "Zathura" },
    --  properties = { tag = tags[2][1], switchtotag = true },
    --  callback = function(c) c:geometry({x=300, y=42, width=780, height=1016}) end },

    -- [L] Use this if you only have laptop display.
    { rule = { instance = "irssi" },
<<<<<<< HEAD
      properties = { tag = tags[1][5], floating = true, switchtotag = true },
      callback = function(c) c:geometry({x=900, y=210}) end },
=======
      properties = { tag = tags[1][5], switchtotag = true },
      callback = function(c) c:geometry({x=900, y=180}) end },
>>>>>>> new colorscheme
    { rule = { instance = "nil" },
      properties = { tag = tags[1][5], switchtotag = true },
      callback = function(c) c:geometry({x=70, y=260}) end },
    { rule = { instance = "ncmpcpp" },
      properties = { tag = tags[1][5], switchtotag = true },
      callback = function(c) c:geometry({x=900, y=35}) end },
    { rule = { instance = "ranger" },
      properties = { tag = tags[1][5], switchtotag = true },
      callback = function(c) c:geometry({x=900, y=625}) end },
    { rule = { class = "Calibre-ebook-viewer" },
      properties = { tag = tags[1][10], switchtotag = true },
      callback = function(c) c:geometry({width = 700, height = 725}) end },
    { rule_any = { class = { "feh", "Mcomix", "mpv" } },
      properties = { tag = tags[1][10], switchtotag = true },
      callback = awful.placement.centered },
    { rule = { class = "Zathura" },
      properties = { tag = tags[1][10], switchtotag = true },
      callback = function(c) c:geometry({height = 700}) end },

--#############################################################################
-- Miscellaneous
--#############################################################################

    { rule = { instance = "calendar" },
      properties = { switchtotag = true },
      callback = function(c) c:geometry({x=450, y=15}) end },
}
-- }}}
-- Signals {{{
-------------------------------------------------------------------------------

client.connect_signal("manage", function (c, startup)
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- }}}
-- Functions {{{
------------------------------------------------------------------------------

--#############################################################################
-- Run or Raise Function
--#############################################################################
-- Runs a program if designated client is not found. If it is found, it focuses (raises) it and moves to that tag. If
-- there exist multiple designated clients, it cycles through them.

-- This is taken from Awesome Wiki but modified to take extra rules similar to a "rule_any". In particular, I did this so
-- I only require one keybind to focus any instance of "Calibre-ebook-viewer", "feh", "Mcomix", or "mpv". None of these
-- media applications are up simultaneously as I only use one at a time. This makes it most efficient as I only require
-- one keybind for accessing all media.
-- Note: There should be a better way to code this so it is exactly like "rule_any" where it takes an infinite number of
-- optional rules and not something hacky like the way I did things. Something to be coded in the match function, but I
-- don't know Lua enough to know how to do this.

function run_or_raise(cmd, properties, opt2, opt3, opt4, opt5)
   local clients = client.get()
   local focused = awful.client.next(0)
   local findex = 0
   local matched_clients = {}
   local n = 0
   opt2 = opt2 or {instance="SOMETHING"}
   opt3 = opt3 or {instance="SOMETHING"}
   opt4 = opt4 or {instance="SOMETHING"}
   opt5 = opt5 or {instance="SOMETHING"}
   for i, c in pairs(clients) do
      if match(properties, c) or match(opt2, c) or match(opt3, c) or match(opt4, c) or match(opt5, c) then
         n = n + 1
         matched_clients[n] = c
         if c == focused then
            findex = n
         end
      end
   end
   if n > 0 then
      local c = matched_clients[1]
      if 0 < findex and findex < n then
         c = matched_clients[findex+1]
      end
      local ctags = c:tags()
      if #ctags == 0 then
         local curtag = awful.tag.selected()
         awful.client.movetotag(curtag, c)
      else
         awful.tag.viewonly(ctags[1])
      end
      client.focus = c
      c:raise()
      return
   end
   awful.util.spawn(cmd)
end

--#############################################################################
-- Match Function
--#############################################################################
-- This is necessary for the run or raise function.

function match (table1, table2)
   for k, v in pairs(table1) do
      if table2[k] ~= v and not table2[k]:find(v) then
         return false
      end
   end
   return true
end

-- }}}
