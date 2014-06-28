--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 25.01.14
-- Time: 17:03
-- http://gizmo.x-plugins.com/docs/Gizmo_API.htm / http://lua.gts-stolberg.de/string.php / http://www.torsten-horn.de/techdocs/ascii.htm
--

XAutoCopilotMcdu = {
    gui_h = gui.newWindow("XAutoCopilotMcdu"),
    l = 300, --left position on screen
    t = 430, --top position on screen
    w = 250, --window width
    h = 150, --window height
    auto_show=false,
}

function XAutoCopilotMcdu_OnCreate()
    local w,h = gfx.getScreenSize()

    --gui.setWindowSize( gui_window_id, left, top, width, height )
    gui.setWindowSize( XAutoCopilotMcdu.gui_h, XAutoCopilotMcdu.l, XAutoCopilotMcdu.t, XAutoCopilotMcdu.w, XAutoCopilotMcdu.h )
    gui.setWindowCaption( XAutoCopilotMcdu.gui_h, "A320 MCDU Settings" )

    local xac_left    = 10
    local xac_top     = 30
    local xac_width   = 100

    gui.newLabel( XAutoCopilotMcdu.gui_h, "ignored", "Company Route",      xac_left+100, xac_top,    xac_width-50 )
    gui.newLabel( XAutoCopilotMcdu.gui_h, "ignored", "Flight Number",      xac_left+100, xac_top+15, xac_width-50 )
    gui.newLabel( XAutoCopilotMcdu.gui_h, "ignored", "Cost Index",         xac_left+100, xac_top+30, xac_width-50 )
    gui.newLabel( XAutoCopilotMcdu.gui_h, "ignored", "Cruize Flightlevel", xac_left+100, xac_top+45, xac_width-50 )
    gui.newLabel( XAutoCopilotMcdu.gui_h, "ignored", "Flaps",              xac_left+100, xac_top+60, xac_width-50 )
    gui.newLabel( XAutoCopilotMcdu.gui_h, "ignored", "Flex temp",          xac_left+100, xac_top+75, xac_width-50 )

    xac_corte      = gui.newTextBox( XAutoCopilotMcdu.gui_h, "ignored", "KMMHKSFO", xac_left, xac_top,    xac_width )
    xac_fltnbr     = gui.newTextBox( XAutoCopilotMcdu.gui_h, "ignored", "KOM123",   xac_left, xac_top+15, xac_width )
    xac_coi        = gui.newTextBox( XAutoCopilotMcdu.gui_h, "ignored", "99",       xac_left, xac_top+30, xac_width )
    xac_crzfl      = gui.newTextBox( XAutoCopilotMcdu.gui_h, "ignored", "180",      xac_left, xac_top+45, xac_width )
    xac_flaps      = gui.newTextBox( XAutoCopilotMcdu.gui_h, "ignored", "2/UP2.0",  xac_left, xac_top+60, xac_width )
    xac_flex_temp  = gui.newTextBox( XAutoCopilotMcdu.gui_h, "ignored", "F50",      xac_left, xac_top+75, xac_width )

    gui.newButton( XAutoCopilotMcdu.gui_h, "XAutoCopilotMcdu_btnStart", "Start", xac_left, xac_top+100, xac_width-50 )

end


function XAutoCopilotMcdu_btnStart_OnClick()
    dref.setInt(xac_alt100x, gui.getWidgetValue(xac_crzfl))
    tmp_xac_corte = string.upper(gui.getWidgetValue(xac_corte))
    tmp_xac_corte_l = string.len(tmp_xac_corte)
    tmp_xac_fltnbr = string.upper(gui.getWidgetValue(xac_fltnbr))
    tmp_xac_coi = string.upper(gui.getWidgetValue(xac_coi))
    tmp_xac_crzfl = string.upper(gui.getWidgetValue(xac_crzfl))
    tmp_xac_flaps = string.upper(gui.getWidgetValue(xac_flaps))
    tmp_xac_flex_temp = string.upper(gui.getWidgetValue(xac_flex_temp))
--[[    if tmp_xac_corte_l == 0 or tmp_xac_corte_l > 3 then
        gui.setFocus( xac_corte )
        sound.say("CO-RTE FILE NOT FOUND")
    end]]

    timer.newOneShot("step1", 0.1)
    timer.newOneShot("step2", 0.3)
    timer.newOneShot("step3", 0.5)
    timer.newOneShot("step4", 0.7)
    timer.newOneShot("step5", 0.9)
    timer.newOneShot("step6", 1.1)
    timer.newOneShot("step7", 1.3)
    timer.newOneShot("step8", 1.5)
    timer.newOneShot("step9", 1.7)
    timer.newOneShot("step10", 1.9)
end

-- ##################################INIT PAGE BEGIN##############################################
function step1()
    dref.setInt(xac_click_init, 1)
    dref.setString(xac_scratchpad, tmp_xac_corte)
    dref.setInt(xac_click_l1, 1)
end

function step2()
    dref.setString(xac_scratchpad, tmp_xac_fltnbr)
    dref.setInt(xac_click_l3, 1)
end

function step3 ()
    dref.setString(xac_scratchpad, tmp_xac_coi)
    dref.setInt(xac_click_l5, 1)
end

function step4 ()
    dref.setString(xac_scratchpad, tmp_xac_crzfl)
    dref.setInt(xac_click_l6, 1)
end

function step5 ()
    dref.setInt(xac_click_right, 1)
end

function step6 ()
    dref.setInt(xac_click_r1, 1)
    dref.setInt(xac_click_r2, 1)
end

-- sim/cockpit2/fuel_quantity

-- ##################################INIT PAGE END##############################################

-- ##################################PERF PAGE BEGIN##############################################
function step7 ()
    dref.setInt(xac_click_perf, 1)
    dref.setInt(xac_click_l1, 1)
    dref.setInt(xac_click_l2, 1)
    dref.setInt(xac_click_l3, 1)
end

function step8 ()
    dref.setString(xac_scratchpad, tmp_xac_flaps)
    dref.setInt(xac_click_r3, 1)
end

function step9 ()
    dref.setString(xac_scratchpad, tmp_xac_flex_temp)
    dref.setInt(xac_click_r4, 1)
end

function step10 ()
    dref.setInt(xac_click_init, 1)
    dref.setInt(xac_click_r3, 1)
end

-- ##################################PERF PAGE END##############################################

-- Toolbar Widget definition/Integration. --

ToolXAutoCopilotMcdu = {
    active = true,
    texture = gfx.loadPng(gizmo.getFolder() .. "firmware/icons/hammer_screwdriver.png"),
    name = "XAutoCopilotMcdu",
    run = function(self)
        if (XAutoCopilotMcdu) then
            gui.showWindow(XAutoCopilotMcdu.gui_h)
        else
            self.active = false
        end
    end,
}

if (ToolTray) then
    ToolTray:register(ToolXAutoCopilotMcdu)
end