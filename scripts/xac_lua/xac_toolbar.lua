--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 23.01.14
-- Time: 19:41
-- To change this template use File | Settings | File Templates.
--

gizmoXAutoCopilot = {
    gui_h = gui.newWindow("gizmoXAutoCopilot"),
    w = 520,
    h = 480,
    l = 540,
    t = 120,

    auto_show=false,

}
function gizmoXAutoCopilot_OnCreate()
    local w,h = gfx.getScreenSize()

    gui.setWindowSize( gizmoXAutoCopilot.gui_h, gizmoXAutoCopilot.l, gizmoXAutoCopilot.t, gizmoXAutoCopilot.w, gizmoXAutoCopilot.h )
    gui.centerWindow( gizmoXAutoCopilot )
    gui.setWindowCaption( gizmoXAutoCopilot.gui_h, "X-Plane Auto Copilot" )


    local btn_x = 60
    local btn_y = 30
    local btn_h = 15
    local txt_w = 100

    --Label / Button creation
    gui.newLabel( gizmoXAutoCopilot.gui_h, "ignored", "COCKPIT PREPARATION", btn_x-50, btn_y, 50 )
    gizmoXAutoCopilot.btnNavSearch = gui.newButton( gizmoXAutoCopilot.gui_h, "gizmoXAutoCopilot_btnPreparation", "execute", btn_x+txt_w, btn_y, 50 ); btn_y = btn_y + btn_h
end


function gizmoXAutoCopilot_btnPreparation_OnClick()
    btnPreparation_State = 1
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


if( GizmoToyBox_Globals )then
    GizmoToyBox_Globals:register( ToolGizmoXAutoCopilot )
end

