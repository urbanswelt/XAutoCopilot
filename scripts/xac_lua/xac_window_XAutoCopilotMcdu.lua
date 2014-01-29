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
    h = 130, --window height
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

    xac_corte = gui.newTextBox( XAutoCopilotMcdu.gui_h, "ignored", "A", xac_left, xac_top,    xac_width )
    gui.newTextBox( XAutoCopilotMcdu.gui_h, "ignored", "ABC123",               xac_left, xac_top+15, xac_width )
    gui.newTextBox( XAutoCopilotMcdu.gui_h, "ignored", "99",                   xac_left, xac_top+30, xac_width )
    gui.newTextBox( XAutoCopilotMcdu.gui_h, "ignored", "150",                  xac_left, xac_top+45, xac_width )

    gui.newButton( XAutoCopilotMcdu.gui_h, "XAutoCopilotMcdu_btnStart", "Start", xac_left, xac_top+75, xac_width-50 )

end


function XAutoCopilotMcdu_btnStart_OnClick()
    tmp_xac_corte = gui.getWidgetValue( xac_corte )
    timer.newOneShot( "test1", 1 )

end

function test1 ()
    --dref.setInt(xac_click_init, 1)

    tmp_ascii = string.byte(tmp_xac_corte,1)
    local testfunc = find_dref_ascii(ascii_matrix)
    dref.setInt(testfunc, 1)



end











-- Toolbar Widget definition/Integration. --

ToolXAutoCopilotMcdu = {
    active = true,
    texture = gfx.loadPng( gizmo.getFolder() .. "firmware/icons/hammer_screwdriver.png" ),

    name = "XAutoCopilotMcdu",
    run = function(self)
        if( XAutoCopilotMcdu )then
            gui.showWindow( XAutoCopilotMcdu.gui_h )
        else
            self.active = false
        end
    end,
}

if( ToolTray )then
    ToolTray:register( ToolXAutoCopilotMcdu )
end


