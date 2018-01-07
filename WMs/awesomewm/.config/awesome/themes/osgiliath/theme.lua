-- vim:foldmethod=marker:foldlevel=0
--[[

    AwesomeWM Theme
    based on:
        Rainbow Awesome WM theme 2.0
        github.com/copycat-killer

--]]


local lain  = require("lain")
local markup = lain.util.markup
local awful = require("awful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()


theme                                           = {}
theme.default_dir                               = require("awful.util").get_themes_dir() .. "default"
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/osgiliath"
theme.wallpaper                                 = os.getenv("HOME") .. "/.wallpaper"
theme.font                                      = "Artwiz Lime 8"
theme.icon_font                                 = "Wuncon Siji 8"
theme.awesome_icon                              = theme.dir .."/icons/awesome.png"
theme.menu_submenu_icon                         = theme.dir .."/icons/submenu.png"
theme.useless_gap                               = 10
theme.fg_normal                                 = xrdb.color7
theme.bg_normal                                 = xrdb.color0
theme.fg_normal_alt                             = xrdb.color8
theme.fg_focus                                  = xrdb.color0
theme.bg_focus                                  = xrdb.color1
theme.fg_urgent                                 = xrdb.color3
theme.bg_urgent                                 = xrdb.color0
theme.border_normal                             = theme.bg_normal
theme.border_focus                              = theme.fg_normal_alt
theme.border_width                              = 5
theme.taglist_fg_empty                          = theme.fg_normal_alt
theme.taglist_bg_empty                          = theme.bg_normal
theme.taglist_fg_focus                          = theme.fg_focus
theme.taglist_bg_focus                          = theme.bg_focus
theme.taglist_fg_occupied                       = theme.bg_focus
theme.taglist_bg_occupied                       = theme.bg_normal
theme.taglist_squares_sel                       = ""
theme.taglist_squares_unsel                     = ""
theme.menu_fg_normal                            = theme.fg_normal
theme.menu_bg_normal                            = theme.bg_normal
theme.menu_fg_focus                             = theme.fg_focus
theme.menu_bg_focus                             = theme.bg_focus
theme.menu_height                               = 16
theme.menu_width                                = 140
theme.tasklist_fg_normal                        = theme.fg_normal
theme.tasklist_bg_normal                        = theme.bg_normal
theme.tasklist_fg_focus                         = theme.bg_focus
theme.tasklist_bg_focus                         = theme.fg_focus
theme.tasklist_fg_minimize                      = theme.fg_normal_alt
theme.tasklist_bg_minimize                      = theme.bg_normal
theme.tasklist_disable_icon                     = true
theme.tasklist_sticky                           = markup(theme.fg_normal, "[S]")
theme.tasklist_ontop                            = markup(theme.fg_normal, "[T]")
theme.tasklist_floating                         = markup(theme.fg_normal, "[F]")
theme.tasklist_maximized_horizontal             = markup(theme.fg_normal, "[M]")
theme.tasklist_maximized_vertical               = markup(theme.fg_normal, "[V]")
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
theme.titlevar_fg_normal                        = theme.fg_normal
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.titlebar_bg_focus                         = theme.fg_normal_alt
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
theme.notification_fg                           = theme.fg_normal
theme.notification_bg                           = theme.bg_normal
theme.notification_border_color                 = theme.fg_normal_alt
theme.notification_border_width                 = theme.border_width

-- Panel widgets {{{
local color_bright  = theme.fg_normal
local color_normal  = theme.fg_normal_alt
local color_sep     = theme.bg_focus

-- {{{ Textclock
local textclockdate = wibox.widget.textclock(markup(color_bright, " %A, %d %B %Y "))
local textclocktime = wibox.widget.textclock(markup(color_bright, " %H:%M "))
local textclockdateicon = wibox.widget({
    markup = markup(color_normal, theme.widget_date),
    font = theme.icon_font,
    widget = wibox.widget.textbox
})
local textclocktimeicon = wibox.widget({
    markup = markup(color_normal, theme.widget_time),
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
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})
-- }}}

-- {{{ MPD
local mpdicon = wibox.widget({
    markup = markup(color_normal, theme.widget_mpd),
    font = theme.icon_font,
    widget = wibox.widget.textbox
})
local mpd = lain.widget.mpd({
    settings = function()
        mpd_notification_preset.fg = color_bright

        artist = mpd_now.artist .. " "
        title  = mpd_now.title  .. " "

        if mpd_now.state == "pause" then
            artist = "mpd "
            title  = "paused "
        elseif mpd_now.state == "stop" then
            artist = ""
            title  = ""
        end

        widget:set_markup(markup.font(theme.font, markup(color_normal, artist) .. markup(color_bright, title)))
    end
})
-- }}}

-- {{{ CPU
local cpuicon = wibox.widget({
    markup = markup(color_normal, theme.widget_cpu),
    font = theme.icon_font,
    widget = wibox.widget.textbox
})
local cpu = lain.widget.cpu({
    settings = function()
        local info = markup.fontfg(theme.font, color_bright, cpu_now.usage .. "% ")
        widget:set_markup(info)
    end
})
-- }}}

-- {{{ Net
local neticon = wibox.widget({
    markup = markup(color_normal, theme.widget_net),
    font = theme.icon_font,
    widget = wibox.widget.textbox
})
local netdownicon = wibox.widget({
    markup = markup(color_normal, theme.widget_netdown),
    font = theme.icon_font,
    widget = wibox.widget.textbox
})
local netupicon = wibox.widget({
    markup = markup(color_normal, theme.widget_netup),
    font = theme.icon_font,
    widget = wibox.widget.textbox
})
local netdowninfo = wibox.widget.textbox()
local netupinfo = lain.widget.net({
    settings = function()
        local up = markup.fontfg(theme.font, color_bright, net_now.sent .. " ")
        local dn = markup.fontfg(theme.font, color_bright, net_now.received .. " ")

        widget:set_markup(up)
        netdowninfo:set_markup(dn)
    end
})
-- }}}

-- {{{ PULSE
local pulseicon = wibox.widget({
    markup = markup(color_normal, theme.widget_vol),
    font = theme.icon_font,
    widget = wibox.widget.textbox
})
local pulsevol = lain.widget.pulse({
    settings = function()
        local fg = volume_now.muted == "no" and color_bright or color_normal
        local info = string.format("%s:%s", volume_now.left, volume_now.right)
        local markinfo = markup.fontfg(theme.font, fg, info .. " ")
        widget:set_markup(markinfo)
    end
})
-- }}}

-- {{{ Separator
local spricon = wibox.widget({
    markup = markup(color_sep, theme.widget_sep),
    font = theme.icon_font,
    widget = wibox.widget.textbox
})

local spr = wibox.container.margin(spricon, 5, 5)
-- }}}

-- Export panel{{{
theme.wibox = {}
theme.wibox.sep = spr
theme.wibox.rightside = {
    spr,
    mpdicon,
    mpd.widget,
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
}
-- }}}
-- }}}

return theme
