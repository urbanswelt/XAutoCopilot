--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 25.01.14
-- Time: 17:03
-- To change this template use File | Settings | File Templates.
-- http://gizmo.x-plugins.com/docs/Gizmo_API.htm / http://lua.gts-stolberg.de/string.php / http://www.torsten-horn.de/techdocs/ascii.htm

gizmoXAutoCopilotMcdu = {
    gui_h = gui.newWindow("gizmoXAutoCopilotMcdu"),
    l = 300, --left position on screen
    t = 430, --top position on screen
    w = 250, --window width
    h = 130, --window height
    auto_show=false,
}

function gizmoXAutoCopilotMcdu_OnCreate()
    local w,h = gfx.getScreenSize()

    --gui.setWindowSize( gui_window_id, left, top, width, height )
    gui.setWindowSize( gizmoXAutoCopilotMcdu.gui_h, gizmoXAutoCopilotMcdu.l, gizmoXAutoCopilotMcdu.t, gizmoXAutoCopilotMcdu.w, gizmoXAutoCopilotMcdu.h )
    gui.setWindowCaption( gizmoXAutoCopilotMcdu.gui_h, "A320 MCDU Settings" )

    local xac_left    = 10
    local xac_top     = 30
    local xac_width   = 100

    gui.newLabel( gizmoXAutoCopilotMcdu.gui_h, "ignored", "Company Route",      xac_left+100, xac_top,    xac_width-50 )
    gui.newLabel( gizmoXAutoCopilotMcdu.gui_h, "ignored", "Flight Number",      xac_left+100, xac_top+15, xac_width-50 )
    gui.newLabel( gizmoXAutoCopilotMcdu.gui_h, "ignored", "Cost Index",         xac_left+100, xac_top+30, xac_width-50 )
    gui.newLabel( gizmoXAutoCopilotMcdu.gui_h, "ignored", "Cruize Flightlevel", xac_left+100, xac_top+45, xac_width-50 )

    xac_corte = gui.newTextBox( gizmoXAutoCopilotMcdu.gui_h, "ignored", "EDDHEDDM", xac_left, xac_top,    xac_width )
    gui.newTextBox( gizmoXAutoCopilotMcdu.gui_h, "ignored", "ABC123",               xac_left, xac_top+15, xac_width )
    gui.newTextBox( gizmoXAutoCopilotMcdu.gui_h, "ignored", "99",                   xac_left, xac_top+30, xac_width )
    gui.newTextBox( gizmoXAutoCopilotMcdu.gui_h, "ignored", "150",                  xac_left, xac_top+45, xac_width )

    gui.newButton( gizmoXAutoCopilotMcdu.gui_h, "gizmoXAutoCopilotMcdu_btnStart", "Start", xac_left, xac_top+75, xac_width-50 )

end


function gizmoXAutoCopilotMcdu_btnStart_OnClick()
    local tmp_xac_corte = gui.getWidgetValue( xac_corte )
    local ASC1 = string.byte(tmp_xac_corte,1)
    local ASC2 = string.byte(tmp_xac_corte,2)
    local ASC3 = string.byte(tmp_xac_corte,3)
    local ASC4 = string.byte(tmp_xac_corte,4)
    local ASC5 = string.byte(tmp_xac_corte,5)
    local ASC6 = string.byte(tmp_xac_corte,6)
    local ASC7 = string.byte(tmp_xac_corte,7)
    local ASC8 = string.byte(tmp_xac_corte,8)

    dref.setInt(xac_click_init, 1)
    if ASC1 == 69 then dref.setInt(xac_click_e, 1) end
    if ASC2 == 68 then dref.setInt(xac_click_d, 1) end
    if ASC3 == 68 then dref.setInt(xac_click_d, 1) end
    if ASC4 == 72 then dref.setInt(xac_click_h, 1) end
    if ASC5 == 69 then dref.setInt(xac_click_e, 1) end
    if ASC6 == 68 then dref.setInt(xac_click_d, 1) end
    if ASC7 == 68 then dref.setInt(xac_click_d, 1) end
    if ASC8 == 77 then dref.setInt(xac_click_m, 1) end
    --sound.say(ASC1)



    --local test = gui.getWidgetValue( xac_corte )
    --dref.setFloatV(xac_scratchpad, 1, A)
    --  dref.setInt(xac_click_l1, 1)

end


-- Toolbar Widget definition/Integration. --

ToolgizmoXAutoCopilotMcdu = {
    active = true,
    texture = gfx.loadPng( gizmo.getFolder() .. "firmware/icons/hammer_screwdriver.png" ),

    name = "XAutoCopilotMcdu",
    run = function(self)
        if( gizmoXAutoCopilotMcdu )then
            gui.showWindow( gizmoXAutoCopilotMcdu.gui_h )
        else
            self.active = false
        end
    end,
}

if( ToolTray )then
    ToolTray:register( ToolgizmoXAutoCopilotMcdu )
end


