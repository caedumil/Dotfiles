--[[

    AwesomeWM Theme
    based on:
        Rainbow Awesome WM theme 2.0
        github.com/copycat-killer

--]]


local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")

local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()

theme                                          = {}
theme.default_dir                               = require("awful.util").get_themes_dir() .. "default"
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/osgiliath"
theme.wallpaper                                 = theme.dir .. "/wall"
theme.font                                      = "Artwiz Lime 8"
theme.icon_font                                 = "Wuncon Siji 8"
theme.fg_normal                                 = xrdb.color8
theme.fg_focus                                  = xrdb.color7
theme.bg_normal                                 = xrdb.color0
theme.bg_focus                                  = xrdb.color8
theme.fg_urgent                                 = xrdb.color0
theme.bg_urgent                                 = xrdb.color1
theme.border_width                              = 5
theme.border_normal                             = theme.bg_normal
theme.border_focus                              = theme.bg_focus
theme.taglist_fg_focus                          = theme.fg_focus
theme.taglist_bg_focus                          = theme.fg_normal
theme.taglist_fg_occupied                       = theme.fg_focus
theme.taglist_bg_occupied                       = theme.bg_normal
theme.taglist_fg_empty                          = theme.fg_normal
theme.taglist_bg_empty                          = theme.bg_normal
theme.menu_height                               = 16
theme.menu_width                                = 140
theme.ocol                                      = "<span color='" .. theme.fg_normal .. "'>"
theme.tasklist_sticky                           = theme.ocol .. "[S]</span>"
theme.tasklist_ontop                            = theme.ocol .. "[T]</span>"
theme.tasklist_floating                         = theme.ocol .. "[F]</span>"
theme.tasklist_maximized_horizontal             = theme.ocol .. "[M] </span>"
theme.tasklist_maximized_vertical               = ""
theme.tasklist_disable_icon                     = true
theme.awesome_icon                              = theme.dir .."/icons/awesome.png"
theme.menu_submenu_icon                         = theme.dir .."/icons/submenu.png"
theme.taglist_squares_sel                       = ""
theme.taglist_squares_unsel                     = ""
theme.useless_gap                               = 10
theme.layout_txt_floating                       = "\u{E0B1}"
theme.layout_txt_tile                           = "\u{E002}"
theme.layout_txt_tileleft                       = "[tl]"
theme.layout_txt_tilebottom                     = "\u{E003}"
theme.layout_txt_tiletop                        = "[tt]"
theme.layout_txt_fairv                          = "[fv]"
theme.layout_txt_fairh                          = "[fh]"
theme.layout_txt_spiral                         = "\u{E008}"
theme.layout_txt_dwindle                        = "\u{E007}"
theme.layout_txt_max                            = "\u{E000}"
theme.layout_txt_fullscreen                     = "\u{E076}"
theme.layout_txt_magnifier                      = "\u{E001}"
theme.layout_txt_cornernw                       = "\u{E009}"
theme.widget_sep                                = "\u{E195}"
theme.widget_run                                = "\u{E1EF}"
theme.widget_date                               = "\u{E265}"
theme.widget_time                               = "\u{E017}"
theme.widget_mpd                                = "\u{E1A6}"
theme.widget_cpu                                = "\u{E026}"
theme.widget_temp                               = "\u{E01D}"
theme.widget_net                                = "\u{E19C}"
theme.widget_netdown                            = "\u{E07B}"
theme.widget_netup                              = "\u{E07A}"
theme.widget_vol                                = "\u{E203}"
theme.titlebar_close_button_normal              = theme.default_dir.."/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.default_dir.."/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.default_dir.."/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.default_dir.."/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.default_dir.."/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.default_dir.."/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.default_dir.."/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.default_dir.."/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.default_dir.."/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.default_dir.."/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.default_dir.."/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.default_dir.."/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.default_dir.."/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.default_dir.."/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.default_dir.."/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.default_dir.."/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.default_dir.."/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.default_dir.."/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.default_dir.."/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.default_dir.."/titlebar/maximized_focus_active.png"

local markup = lain.util.markup
local white  = theme.fg_focus
local gray   = theme.fg_normal

-- {{{ Textclock
local textclockdate = wibox.widget.textclock(markup(white, " %A, %d %B %Y "))
local textclocktime = wibox.widget.textclock(markup(white, " %H:%M "))
local textclockdateicon = wibox.widget({
    text = theme.widget_date,
    font = theme.icon_font,
    widget = wibox.widget.textbox
})
local textclocktimeicon = wibox.widget({
    text = theme.widget_time,
    font = theme.icon_font,
    widget = wibox.widget.textbox
})
textclockdate.font = theme.font
textclocktime.font = theme.font
-- }}}

-- {{{ Calendar
lain.widget.calendar({
    attach_to = { textclockdate },
    notification_preset = {
        font = theme.font,
        fg   = white,
        bg   = theme.bg_normal
    }
})
-- }}}

-- {{{ MPD
local mpdicon = wibox.widget({
    text = theme.widget_mpd,
    font = theme.icon_font,
    widget = wibox.widget.textbox
})
theme.mpd = lain.widget.mpd({
    settings = function()
        mpd_notification_preset.fg = white

        artist = mpd_now.artist .. " "
        title  = mpd_now.title  .. " "

        if mpd_now.state == "pause" then
            artist = "mpd "
            title  = "paused "
        elseif mpd_now.state == "stop" then
            artist = ""
            title  = ""
        end

        widget:set_markup(markup.font(theme.font, markup(gray, artist) .. markup(white, title)))
    end
})
-- }}}

-- {{{ CPU
local cpuicon = wibox.widget({
    text = theme.widget_cpu,
    font = theme.icon_font,
    widget = wibox.widget.textbox
})
local cpu = lain.widget.cpu({
    settings = function()
        local info = markup.fontfg(theme.font, white, cpu_now.usage .. "% ")
        widget:set_markup(info)
    end
})
-- }}}

-- {{{ Net
local neticon = wibox.widget({
    text = theme.widget_net,
    font = theme.icon_font,
    widget = wibox.widget.textbox
})
local netdownicon = wibox.widget({
    text = theme.widget_netdown,
    font = theme.icon_font,
    widget = wibox.widget.textbox
})
local netupicon = wibox.widget({
    text = theme.widget_netup,
    font = theme.icon_font,
    widget = wibox.widget.textbox
})
local netdowninfo = wibox.widget.textbox()
local netupinfo = lain.widget.net({
    settings = function()
        local up = markup.fontfg(theme.font, white, net_now.sent .. " ")
        local dn = markup.fontfg(theme.font, white, net_now.received .. " ")

        widget:set_markup(up)
        netdowninfo:set_markup(dn)
    end
})
-- }}}

-- {{{ PULSE
local pulseicon = wibox.widget({
    text = theme.widget_vol,
    font = theme.icon_font,
    widget = wibox.widget.textbox
})
local pulsevol = lain.widget.pulse({
    settings = function()
        local fg = volume_now.muted == "no" and white or gray
        local info = string.format("%s:%s", volume_now.left, volume_now.right)
        local markinfo = markup.fontfg(theme.font, fg, info .. " ")
        widget:set_markup(markinfo)
    end
})
-- }}}

-- {{{ Prompt
local prompticon = wibox.widget({
    text = theme.widget_run,
    font = theme.icon_font,
    widget = wibox.widget.textbox
})
-- }}}

-- {{{ Separator
local spricon = wibox.widget({
    text = theme.widget_sep,
    font = theme.icon_font,
    widget = wibox.widget.textbox
})

local spr = wibox.container.margin(spricon, 5, 5)
-- }}}

-- {{{ Wibar
local function update_txt_layoutbox(s)
    -- Writes a string representation of the current layout in a textbox widget
    local txt_l = theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))] or ""
    s.mytxtlayoutbox:set_markup(markup(white, txt_l))
end

function theme.at_screen_connect(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Tags
    awful.tag(tags.names, s, tags.layout)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt({ fg = white })

    -- Textual layoutbox
    s.mytxtlayoutbox = wibox.widget({
        font = theme.icon_font,
        widget = wibox.widget.textbox
    })
    update_txt_layoutbox(s)
    awful.tag.attached_connect_signal(s,
                                      "property::selected",
                                      function() update_txt_layoutbox(s) end
                                     )
    awful.tag.attached_connect_signal(s,
                                      "property::layout",
                                      function() update_txt_layoutbox(s) end
                                     )
    s.mytxtlayoutbox:buttons(
        gears.table.join(
            awful.button({}, 1, function() awful.layout.inc(1) end),
            awful.button({}, 3, function() awful.layout.inc(-1) end),
            awful.button({}, 4, function() awful.layout.inc(1) end),
            awful.button({}, 5, function() awful.layout.inc(-1) end)
        )
    )

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s,
                                       awful.widget.taglist.filter.all,
                                       awful.util.taglist_buttons,
                                       { font = theme.icon_font }
                                      )

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s,
                                         awful.widget.tasklist.filter.currenttags,
                                         awful.util.tasklist_buttons,
                                         { align = "center" }
                                        )

    -- Create the wibox
    s.mywibox = awful.wibar(
        {
            position = "top",
            screen = s,
            height = 20,
            bg = theme.bg_normal,
            fg = theme.fg_normal
        }
    )

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        {   -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            spr,
            s.mytaglist,
            spr,
            s.mytxtlayoutbox,
            spr,
            prompticon,
            s.mypromptbox,
            spr,
        },
        s.mytasklist, -- Middle widget
        {   -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spr,
            mpdicon,
            theme.mpd.widget,
            spr,
            cpuicon,
            cpu,
            spr,
            pulseicon,
            pulsevol,
            spr,
            neticon,
            netdownicon,
            netdowninfo,
            netupicon,
            netupinfo,
            spr,
            textclockdateicon,
            textclockdate,
            textclocktimeicon,
            textclocktime,
            spr,
        },
    }
end
-- }}}

return theme

-- vim:foldmethod=marker:foldlevel=0
