--  [[
--
--  AwesomeWM configuration file
--
--  ]]


-- {{{ Libraries
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- Enable VIM help for hotkeys widget when client with matching name is opened:
require("awful.hotkeys_popup.keys.vim")
-- }}}

-- {{{ Error handling
-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error",
        function(err)
            -- Make sure we don't go into an endless error loop
            if in_error then return end
            in_error = true

            naughty.notify(
                {
                    preset = naughty.config.presets.critical,
                    title = "Oops, an error happened!",
                    text = tostring(err)
                }
            )
            in_error = false
        end
    )
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
theme_name = "osgiliath"
beautiful.init(os.getenv("HOME").. "/.config/awesome/themes/" .. theme_name .. "/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "termite"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
modkey = "Mod4"
-- }}}

-- {{{ Layout & Tags
-- Table of layouts to cover with awful.layout.inc, order matters.
awful.util.tagnames = {
    "\u{E1A0}",     -- WWW
    "\u{E1EC}",     -- TERM
    "\u{E1EC}",     -- TERM
    "\u{E1DD}",     -- MEDIA
    "\u{E1D7}",     -- VMs
    "\u{E1D5}",     -- OFFICE
    "\u{E1DA}",     -- GIMP
    "\u{E19D}"      -- MISC
}
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

layouts = awful.layout.layouts
tags = {
    names = awful.util.tagnames,
    layout = { layouts[1], layouts[5], layouts[2], layouts[4],
               layouts[1], layouts[1], layouts[1], layouts[1] }
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end }
}

mypowermenu = {
    { "reboot", function() awful.spawn.with_shell("systemctl reboot", false) end },
    { "poweroff", function() awful.spawn.with_shell("systemctl poweroff", false) end }
}

mymainmenu = awful.menu(
    {
        items = {
            { "awesome", myawesomemenu, beautiful.awesome_icon },
            { "power", mypowermenu, beautiful.awesome_icon },
            { "open terminal", terminal }
        }
    }
)
-- }}}

-- {{{ Wibar bindings
-- Create a wibox for each screen and add it
awful.util.taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1,
        function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end
    ),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3,
        function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end
    ),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = gears.table.join(
     awful.button({ }, 1,
        function(c)
            if c == client.focus then
                c.minimized = true
            else
                -- Without this, the following
                -- :isvisible() makes no sense
                c.minimized = false
                if not c:isvisible() and c.first_tag then
                    c.first_tag:view_only()
                end
                -- This will also un-minimize
                -- the client, if needed
                client.focus = c
                c:raise()
            end
        end
    ),
    awful.button({ }, 3,
        function()
            local instance = nil

            return function()
                if instance and instance.wibox.visible then
                    instance:hide()
                    instance = nil
                else
                    instance = awful.menu.clients({ theme = { width = 250 } })
                end
            end
        end
    ),
    awful.button({ }, 4, function() awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function() awful.client.focus.byidx(-1) end)
)
-- }}}

-- {{{ Screen
--function set_wallpaper(s)
--    -- Wallpaper
--    if beautiful.wallpaper then
--        local wallpaper = beautiful.wallpaper
--        -- If wallpaper is a function, call it with the screen
--        if type(wallpaper) == "function" then
--            wallpaper = wallpaper(s)
--        end
--        gears.wallpaper.maximized(wallpaper, s, true)
--    end
--end
function set_wallpaper(s)
    awful.spawn.with_shell("${HOME}/.fehbg")
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- Create wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)
-- }}}

-- {{{ Mouse bindings
root.buttons(
    gears.table.join(
        awful.button({ }, 3, function() mymainmenu:toggle() end),
        awful.button({ }, 4, awful.tag.viewnext),
        awful.button({ }, 5, awful.tag.viewprev)
    )
)
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key(
        { modkey,           }, "s",
        hotkeys_popup.show_help,
        {description="show help", group="awesome"}
    ),
    awful.key(
        { modkey,           }, "Left",
        awful.tag.viewprev,
        {description = "view previous", group = "tag"}
    ),
    awful.key(
        { modkey,           }, "Right",
        awful.tag.viewnext,
        {description = "view next", group = "tag"}
    ),
    awful.key(
        { }, "XF86Back",
        awful.tag.viewprev,
        {description = "view previous", group = "tag"}
    ),
    awful.key(
        { }, "XF86Forward",
        awful.tag.viewnext,
        {description = "view next", group = "tag"}
    ),
    awful.key(
        { modkey,           }, "'",
        awful.tag.history.restore,
        {description = "go back", group = "tag"}
    ),

    awful.key(
        { modkey,           }, "j",
        function() awful.client.focus.byidx( 1) end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key(
        { modkey,           }, "k",
        function() awful.client.focus.byidx(-1) end,
        {description = "focus previous by index", group = "client"}
    ),

    awful.key(
        { modkey,           }, "F1",
        function() mymainmenu:show() end,
        {description = "show main menu", group = "awesome"}
    ),

    -- Layout manipulation
    awful.key(
        { modkey, "Shift"   }, "j",
        function() awful.client.swap.byidx(  1) end,
        {description = "swap with next client by index", group = "client"}
    ),
    awful.key(
        { modkey, "Shift"   }, "k",
        function() awful.client.swap.byidx( -1) end,
        {description = "swap with previous client by index", group = "client"}
    ),
    awful.key(
        { modkey, "Control" }, "j",
        function() awful.screen.focus_relative( 1) end,
        {description = "focus the next screen", group = "screen"}
    ),
    awful.key(
        { modkey, "Control" }, "k",
        function() awful.screen.focus_relative(-1) end,
        {description = "focus the previous screen", group = "screen"}
    ),
    awful.key(
        { modkey,           }, "u",
        awful.client.urgent.jumpto,
        {description = "jump to urgent client", group = "client"}
    ),
    awful.key(
        { modkey,           }, "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}
    ),

    awful.key(
        { modkey,           }, "l",
        function() awful.tag.incmwfact( 0.05) end,
        {description = "increase master width factor", group = "layout"}
    ),
    awful.key(
        { modkey,           }, "h",
        function() awful.tag.incmwfact(-0.05) end,
        {description = "decrease master width factor", group = "layout"}
    ),
    awful.key(
        { modkey, "Shift"   }, "h",
        function() awful.tag.incnmaster( 1, nil, true) end,
        {description = "increase the number of master clients", group = "layout"}
    ),
    awful.key(
        { modkey, "Shift"   }, "l",
        function() awful.tag.incnmaster(-1, nil, true) end,
        {description = "decrease the number of master clients", group = "layout"}
    ),
    awful.key(
        { modkey, "Control" }, "h",
        function() awful.tag.incncol( 1, nil, true) end,
        {description = "increase the number of columns", group = "layout"}
    ),
    awful.key(
        { modkey, "Control" }, "l",
        function() awful.tag.incncol(-1, nil, true) end,
        {description = "decrease the number of columns", group = "layout"}
    ),
    awful.key(
        { modkey,           }, "space",
        function() awful.layout.inc( 1)                end,
        {description = "select next", group = "layout"}
    ),
    awful.key(
        { modkey, "Shift"   }, "space",
        function() awful.layout.inc(-1) end,
        {description = "select previous", group = "layout"}
    ),

    awful.key(
        { modkey, "Control" }, "n",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
                c:raise()
            end
        end,
        {description = "restore minimized", group = "client"}
    ),

    -- Prompt
    awful.key(
        { modkey },            "r",
        function() awful.screen.focused().mypromptbox:run() end,
        {description = "run prompt", group = "launcher"}
    ),

    -- Standard program
    awful.key(
        { modkey,           }, "Return",
        function() awful.spawn(terminal) end,
        {description = "open a terminal", group = "launcher"}
    ),
    awful.key(
        { modkey,           }, "Escape",
        awesome.restart,
        {description = "reload awesome", group = "awesome"}
    ),
    awful.key(
        { modkey, "Shift"   }, "Escape",
        awesome.quit,
        {description = "quit awesome", group = "awesome"}
    ),

    -- Volume control
    awful.key(
        { }, "XF86AudioLowerVolume",
        function() awful.spawn("ponymix decrease 5", false) end,
        {description = "decrase volume", group= "volume"}
    ),
    awful.key(
        { }, "XF86AudioRaiseVolume",
        function() awful.spawn("ponymix increase 5", false) end,
        {description = "raise volume", group= "volume"}
    ),
    awful.key(
        { }, "XF86AudioMute",
        function() awful.spawn("ponymix toggle", false) end,
        {description = "mute/unmute volume", group= "volume"}
    ),

    -- Media Player control (MPRIS)
    awful.key(
        { }, "XF86AudioPlay",
        function() awful.spawn("playerctl play-pause", false) end,
        { description = "play/pause", group = "mpd" }
    ),
    awful.key(
        { modkey, }, "XF86AudioPlay",
        function() awful.spawn("playerctl stop", false) end,
        { description = "stop", group = "mpd" }
    ),
    awful.key(
        { }, "XF86AudioPrev",
        function() awful.spawn("playerctl previous", false) end,
        { description = "previous", group = "mpd" }
    ),
    awful.key(
        { }, "XF86AudioNext",
        function() awful.spawn("playerctl next", false) end,
        { description = "next group", group = "mpd" }
    ),

    -- User programs
    awful.key(
        { }, "XF86Search",
        function() awful.spawn("rofi -modi drun -show drun") end,
        {description = "rofi desktop menu launcher", group = "launcher"}
    ),
    awful.key(
        { modkey, }, "XF86Search",
        function() awful.spawn("rofi -modi run -show run") end,
        {description = "rofi menu launcher", group = "launcher"}
    ),
    awful.key(
        { }, "XF86Mail",
        function() awful.spawn("sxlock -f '-misc-ohsnap-medium-*-normal-*-11-*-*-*-*-*-*-*'", false) end,
        {description = "lock screen", group = "launcher"}
    )
)

clientkeys = gears.table.join(
    awful.key(
        { modkey,           }, "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}
    ),
    awful.key(
        { modkey,           }, "w",
        function(c) c:kill() end,
        {description = "close", group = "client"}
    ),
    awful.key(
        { modkey, "Control" }, "space",
        awful.client.floating.toggle,
        {description = "toggle floating", group = "client"}
    ),
    awful.key(
        { modkey, "Control" }, "Return",
        function(c) c:swap(awful.client.getmaster()) end,
        {description = "move to master", group = "client"}
    ),
    awful.key(
        { modkey,           }, "o",
        function(c) c:move_to_screen() end,
        {description = "move to screen", group = "client"}
    ),
    awful.key(
        { modkey,           }, "t",
        function(c) c.ontop = not c.ontop end,
        {description = "toggle keep on top", group = "client"}
    ),
    awful.key(
        { modkey,           }, "n",
        function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}
    ),
    awful.key(
        { modkey,           }, "m",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}
    ),
    awful.key(
        { modkey, "Control" }, "m",
        function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}
    ),
    awful.key(
        { modkey, "Shift"   }, "m",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"}
    )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key(
            { modkey }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = "view tag #"..i, group = "tag"}
        ),
        -- Toggle tag display.
        awful.key(
            { modkey, "Control" }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag #" .. i, group = "tag"}
        ),
        -- Move client to tag.
        awful.key(
            { modkey, "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag #"..i, group = "tag"}
        ),
        -- Toggle tag on focused client.
        awful.key(
            { modkey, "Control", "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = "toggle focused client on tag #" .. i, group = "tag"}
        )
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function(c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
         }
    },

    -- Titlebars
    {
        rule_any = {
            type = { "normal", "dialog" }
        },
        properties = { titlebars_enabled = false }
    },

    -- Floating clients.
    {
        rule_any = {
            instance = { },
            class = {
                "mpv",
                "Pinentry",
            },
            name = { },
            role = { }
        },
        properties = {
            floating = true,
            placement = awful.placement.centered
        }
    },

    -- Map applications to tag 1.
    {
        rule = { class = "Firefox" },
        properties = {
            screen = 1,
            tag = tags.names[1],
            placement = awful.placement.centered
        }
    },

    -- Map applications to tag 5.
    {
        rule = { class = "VirtualBox" },
        properties = {
            screen = 1,
            tag = tags.names[5],
            placement = awful.placement.centered
        }
    },
    {
        rule = { class = "Vmware" },
        properties = {
            screen = 1,
            tag = tags.names[5],
            placement = awful.placement.centered
        }
    },
    -- Map applications to tag 6.
    {
        rule = { instance = "libreoffice" },
        properties = {
            screen = 1,
            tag = tags.names[6],
            placement = awful.placement.centered
        }
    },

    -- Map applications to tag 7.
    {
        rule = { class = "Gimp-2.8" },
        properties = {
            screen = 1,
            tag = tags.names[7],
            placement = awful.placement.centered
        }
    },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage",
    function(c)
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- if not awesome.startup then awful.client.setslave(c) end

        if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
            -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c)
        end
    end
)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars",
    function(c)
        -- buttons for the titlebar
        local buttons = gears.table.join(
            awful.button({ }, 1,
                function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end
            ),
            awful.button({ }, 3,
                function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end
            )
        )

        awful.titlebar(c) : setup {
            { -- Left
                awful.titlebar.widget.iconwidget(c),
                buttons = buttons,
                layout  = wibox.layout.fixed.horizontal
            },
            { -- Middle
                { -- Title
                    align  = "center",
                    widget = awful.titlebar.widget.titlewidget(c)
                },
                buttons = buttons,
                layout  = wibox.layout.flex.horizontal
            },
            { -- Right
                awful.titlebar.widget.floatingbutton (c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.stickybutton   (c),
                awful.titlebar.widget.ontopbutton    (c),
                awful.titlebar.widget.closebutton    (c),
                layout = wibox.layout.fixed.horizontal()
            },
            layout = wibox.layout.align.horizontal
        }
    end
)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter",
    function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
            client.focus = c
        end
    end
)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- vim:foldmethod=marker:foldlevel=0
