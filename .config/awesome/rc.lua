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
        -- Make sure we don't go into an endless error loop
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

beautiful.init("/usr/share/awesome/themes/default/theme.lua")
terminal = "urxvt"
editor = "gvim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod1"
modkey2 = "Mod4"

-- }}}
-- Dialogs {{{
-------------------------------------------------------------------------------

--#############################################################################
-- Tags & Layouts
--#############################################################################

local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
}

tags = {
names  = { 1, 2, 3, 4, 5, 6, 7, 8, 9 },
layout = { layouts[1], layouts[2], layouts[2], layouts[1], layouts[1],
          layouts[1], layouts[1], layouts[1], layouts[1] }
}

for s = 1, screen.count() do
 tags[s] = awful.tag(tags.names, s, tags.layout)
end

--#############################################################################
-- Menus
--#############################################################################

myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- }}}
-- Wibox {{{
-------------------------------------------------------------------------------

-- Create a textclock widget
mytextclock = awful.widget.textclock()

-- Create a wibox for each screen and add it
mywibox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )

for s = 1, screen.count() do
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytextclock)
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

--#############################################################################
-- Keybindings
--#############################################################################

globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Shift"   }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Main Applications
    awful.key({ modkey, }, "w", function () run_or_raise("gvim", { class = "Gvim" }) end),
    awful.key({ modkey, }, "a", function () run_or_raise("urxvt -name tcli -g 129x18 -e /home/nil/.config/nil/scripts/nil-transmission-remote-cli", { instance = "tcli" }) end),
    awful.key({ modkey, }, "q", function () run_or_raise("firefox", { class = "Firefox" }) end),
    awful.key({ modkey, }, "o", function () run_or_raise("libreoffice /home/nil/Dropbox/nil/Aesthetics/Macros.ods", { instance = "" }) end),
    -- [L+E] Use this if you have both laptop and external display.
    --awful.key({ modkey, }, "i", function () run_or_raise("urxvt -name irssi -font 'xft:uushi' -boldFont 'xft:uushi' -g 85x31 -e irssi", { instance = "irssi" }) end),
    --awful.key({ modkey, }, "t", function () run_or_raise("urxvt -name nil -font 'xft:uushi' -boldFont 'xft:uushi' -g 85x24", { instance = "nil" }) end),
    --awful.key({ modkey, }, "n", function () run_or_raise("urxvt -name ncmpcpp -font 'xft:uushi' -boldFont 'xft:uushi' -g 85x9 -e ncmpcpp", { instance = "ncmpcpp" }) end),
    --awful.key({ modkey, }, "f", function () run_or_raise("urxvt -name ranger -font 'xft:uushi' -boldFont 'xft:uushi' -g 85x19 -e ranger", { instance = "ranger" }) end),
    -- [L] Use this if you only have laptop display.
    awful.key({ modkey, }, "t", function () run_or_raise("urxvt -name nil -g 85x24", { instance = "nil" }) end),
    awful.key({ modkey, }, "i", function () run_or_raise("urxvt -name irssi -g 102x35 -e irssi", { instance = "irssi" }) end),
    awful.key({ modkey, }, "n", function () run_or_raise("urxvt -name ncmpcpp -g 102x10 -e ncmpcpp", { instance = "ncmpcpp" }) end),
    awful.key({ modkey, }, "f", function () run_or_raise("urxvt -name ranger -g 102x21 -e ranger", { instance = "ranger" }) end),
    awful.key({ modkey, }, "m", function () run_or_raise("", { class = "mpv" }) end),
    awful.key({ modkey, }, "e", function () run_or_raise("", { class = "feh" }) end),
    awful.key({ modkey, }, "z", function () run_or_raise("", { class = "Zathura" }) end),

    -- Media Keys
    awful.key({ }, "F6", function () awful.util.spawn_with_shell("bash ~/.config/nil/scripts/play-pause") end),
    awful.key({ }, "F9", function () awful.util.spawn("amixer set Master 2%- unmute | amixer set PCM 2%- unmute") end),
    awful.key({ }, "F10", function () awful.util.spawn("amixer set Master 2%+ unmute | amixer set PCM 2%+ unmute") end),
    awful.key({ }, "F11", function () awful.util.spawn("amixer set Master toggle | amixer set IEC958 toggle") end),
    awful.key({ modkey }, "c", function () awful.util.spawn("bash /home/nil/.config/nil/scripts/calendar-toggle") end),
    awful.key({ modkey, "Shift" }, "i", function () awful.util.spawn("echo >> /home/nil/.irssi/logs/fnotify") end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey, "Shift"   }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "d",      function (c) c:kill()                         end),
    awful.key({ modkey, "Shift"   }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
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

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
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
    --{ rule_any = { name = "Options for Menu Editor", name = "Firefox Preferences", name = "Page Info", name = "Tab Mix Plus Options", name = "Library" },
      --properties = { floating = true } },
    { rule = { class = "Gvim" },
      properties = { floating = true, switchtotag = true },
      callback = function(c) c:geometry({x=30, y=40}) end },
    { rule = { instance = "tcli" },
      properties = { tag = tags[1][1], floating = true, switchtotag = true },
      callback = function(c) c:geometry({x=30, y=560}) end },
     { rule = { class = "Firefox" },
      properties = { tag = tags[1][2], switchtotag = true } },
    { rule = { instance = "VCLSalFrame" },
      properties = { tag = tags[1][3], switchtotag = true } },
    { rule = { class = "gimp" },
      properties = { tag = tags[1][4], floating = true, switchtotag = true } },
    { rule = { instance = "calendar" },
      properties = { floating = true, switchtotag = true },
      callback = function(c) c:geometry({x=683, y=15}) end },
    -- [L+E] Use this if you have both laptop and external display.
    --{ rule = { instance = "irssi" },
      --properties = { tag = tags[2][1], floating = true, switchtotag = true },
      --callback = function(c) c:geometry({x=1340, y=175}) end },
    --{ rule = { instance = "nil" },
      --properties = { tag = tags[2][1], floating = true, switchtotag = true },
      --callback = function(c) c:geometry({x=1340, y=550}) end },
    --{ rule = { instance = "ncmpcpp" },
      --properties = { tag = tags[2][1], floating = true, switchtotag = true },
      --callback = function(c) c:geometry({x=1340, y=40}) end },
    --{ rule = { instance = "ranger" },
      --properties = { tag = tags[2][1], floating = true, switchtotag = true },
      --callback = function(c) c:geometry({x=1340, y=845}) end },
    --{ rule = { class = "feh" },
      --properties = { tag = tags[2][1], floating = true, switchtotag = true },
      --callback = function(c) c:geometry({x=0, y=0}) end },
    --{ rule = { class = "mpv" },
      --properties = { tag = tags[2][1], floating = true, switchtotag = true },
      --callback = function(c) c:geometry({x=0, y=0}) end },
    --{ rule = { class = "Zathura" },
      --properties = { tag = tags[2][1], floating = true, switchtotag = true },
      --callback = function(c) c:geometry({x=0, y=0}) end },
    -- [L] Use this if you only have laptop display.
    { rule = { instance = "irssi" },
      properties = { tag = tags[1][5], floating = true, switchtotag = true },
      callback = function(c) c:geometry({x=780, y=165}) end },
    { rule = { instance = "nil" },
      properties = { tag = tags[1][5], floating = true, switchtotag = true },
      callback = function(c) c:geometry({x=70, y=260}) end },
    { rule = { instance = "ncmpcpp" },
      properties = { tag = tags[1][5], floating = true, switchtotag = true },
      callback = function(c) c:geometry({x=780, y=35}) end },
    { rule = { instance = "ranger" },
      properties = { tag = tags[1][5], floating = true, switchtotag = true },
      callback = function(c) c:geometry({x=780, y=540}) end },
    { rule = { class = "feh" },
      properties = { tag = tags[1][9], floating = true, switchtotag = true },
      callback = awful.placement.centered },
    { rule = { class = "mpv" },
      properties = { tag = tags[1][9], floating = true, switchtotag = true },
      callback = awful.placement.centered },
    { rule = { class = "Zathura" },
      properties = { tag = tags[1][9], floating = true, switchtotag = true },
      callback = awful.placement.centered },
}
-- }}}
-- Signals {{{
-------------------------------------------------------------------------------

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
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

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
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

-- Run or Raise: Runs a program if designated client is not found. If it is found, it focuses (raises) it and moves to that tag. If multiple, it cycles through them.
function run_or_raise(cmd, properties)
   local clients = client.get()
   local focused = awful.client.next(0)
   local findex = 0
   local matched_clients = {}
   local n = 0
   for i, c in pairs(clients) do
      if match(properties, c) then
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

function match (table1, table2)
   for k, v in pairs(table1) do
      if table2[k] ~= v and not table2[k]:find(v) then
         return false
      end
   end
   return true
end

-- Run program only when starting Awesome for the first time, but not when it restarts.
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

-- }}}
-- Startup Applications {{{
-------------------------------------------------------------------------------

-- Maybe put these ones in xinitrc somehow too?
run_once("firefox")
run_once("gvim")
run_once("libreoffice ~/Dropbox/nil/Aesthetics/Macros.ods")
-- [L+E] Use this if you have both laptop and external display.
--run_once("urxvt -name nil -font 'xft:uushi' -boldFont 'xft:uushi' -g 85x24")
--run_once("urxvt -name irssi -font 'xft:uushi' -boldFont 'xft:uushi' -g 85x31 -e irssi")
--run_once("urxvt -name ncmpcpp -font 'xft:uushi' -boldFont 'xft:uushi' -g 85x9 -e ncmpcpp")
--run_once("urxvt -name ranger -font 'xft:uushi' -boldFont 'xft:uushi' -g 85x19 -e ranger")
-- [L] Use this if you only have laptop display.
run_once("urxvt -name nil -g 85x24")
run_once("urxvt -name irssi -g 102x35 -e irssi")
run_once("urxvt -name ncmpcpp -g 102x10 -e ncmpcpp")
run_once("urxvt -name ranger -g 102x21 -e ranger")
run_once("urxvt -name tcli -g 129x18 -e ~/.config/nil/scripts/nil-transmission-remote-cli")
-- Terminal commands I haven't put in xinitrc yet.
run_once("dropboxd")
run_once("rssdler -d")
run_once("mpdas")
run_once("transmission-daemon")

-- }}}
