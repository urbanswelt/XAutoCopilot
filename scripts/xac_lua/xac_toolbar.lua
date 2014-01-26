--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 23.01.14
-- Time: 19:41
-- To change this template use File | Settings | File Templates.
--

gizmoXAutoCopilot = {
    gui_h = gui.newWindow("gizmoXAutoCopilot"),
    l = 10,  --left position on screen
    t = 430, --top position on screen
    w = 250, --window width
    h = 130, --window height
    auto_show=false,
}

function gizmoXAutoCopilot_OnCreate()
    local w,h = gfx.getScreenSize()

    gui.setWindowSize( gizmoXAutoCopilot.gui_h, gizmoXAutoCopilot.l, gizmoXAutoCopilot.t, gizmoXAutoCopilot.w, gizmoXAutoCopilot.h )
    gui.setWindowCaption( gizmoXAutoCopilot.gui_h, "X-Plane Auto Copilot" )

    local xac_left    = 10
    local xac_top     = 30
    local xac_width   = 100

    gui.newLabel( gizmoXAutoCopilot.gui_h, "ignored", "COCKPIT PREPARATION", xac_left+100, xac_top,    xac_width-50 )
    gui.newLabel( gizmoXAutoCopilot.gui_h, "ignored", "MCDU/FMC",            xac_left+100, xac_top+15, xac_width-50 )
    gui.newLabel( gizmoXAutoCopilot.gui_h, "ignored", "BEFORE START",        xac_left+100, xac_top+30, xac_width-50 )

    gui.newButton( gizmoXAutoCopilot.gui_h, "gizmoXAutoCopilot_btnPreparation", "execute", xac_left, xac_top,    xac_width )
    gui.newButton( gizmoXAutoCopilot.gui_h, "gizmoXAutoCopilot_btnMcdu",        "execute", xac_left, xac_top+15, xac_width )
    gui.newButton( gizmoXAutoCopilot.gui_h, "gizmoXAutoCopilot_btnBeforeStart", "execute", xac_left, xac_top+30, xac_width )

end

function gizmoXAutoCopilot_btnPreparation_OnClick()
    prepstate1 = 0
    prepstate2 = 0
    prepstate3 = 0
    prepstate4 = 0
    prepstate5 = 0
    btnPreparation_State = 1
end

function gizmoXAutoCopilot_btnMcdu_OnClick()
    gui.showWindow( gizmoXAutoCopilotMcdu.gui_h )
end

function gizmoXAutoCopilot_btnBeforeStart_OnClick()
    beforestartstate1 = 0
    btnBeforeStart_State = 1
end


-- Toolbar Widget definition/Integration. --

ToolGizmoXAutoCopilot = {
    active = true,
    texture = gfx.loadPng( gizmo.getFolder() .. "firmware/icons/world.png" ),

    name = "XAutoCopilot",
    run = function(self)
        if( gizmoXAutoCopilot )then
            gui.showWindow( gizmoXAutoCopilot.gui_h )
        else
            self.active = false
        end
    end,
}


if( ToolTray )then
    ToolTray:register( ToolGizmoXAutoCopilot )
end


