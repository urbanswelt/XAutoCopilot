--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 23.01.14
-- Time: 19:41
--

XAutoCopilot = {
    gui_h = gui.newWindow("XAutoCopilot"),
    l = 10,  --left position on screen
    t = 430, --top position on screen
    w = 250, --window width
    h = 130, --window height
    auto_show=false,
}

function XAutoCopilot_OnCreate()
    local w,h = gfx.getScreenSize()

    gui.setWindowSize( XAutoCopilot.gui_h, XAutoCopilot.l, XAutoCopilot.t, XAutoCopilot.w, XAutoCopilot.h )
    gui.setWindowCaption( XAutoCopilot.gui_h, "X-Plane Auto Copilot" )

    local xac_left    = 10
    local xac_top     = 30
    local xac_width   = 100

    gui.newLabel( XAutoCopilot.gui_h, "ignored", "COCKPIT PREPARATION", xac_left+100, xac_top,    xac_width-50 )
    gui.newLabel( XAutoCopilot.gui_h, "ignored", "MCDU/FMC",            xac_left+100, xac_top+15, xac_width-50 )
    gui.newLabel( XAutoCopilot.gui_h, "ignored", "BEFORE START",        xac_left+100, xac_top+30, xac_width-50 )
    gui.newLabel( XAutoCopilot.gui_h, "ignored", "PUSHBACK",            xac_left+100, xac_top+45, xac_width-50 )
    gui.newLabel( XAutoCopilot.gui_h, "ignored", "ENGINE START",        xac_left+100, xac_top+60, xac_width-50 )
    gui.newLabel( XAutoCopilot.gui_h, "ignored", "AFTER ENGINE START",  xac_left+100, xac_top+75, xac_width-50 )

    gui.newButton( XAutoCopilot.gui_h, "XAutoCopilot_btnPreparation", "execute", xac_left, xac_top,    xac_width )
    gui.newButton( XAutoCopilot.gui_h, "XAutoCopilot_btnMcdu",        "execute", xac_left, xac_top+15, xac_width )
    gui.newButton( XAutoCopilot.gui_h, "XAutoCopilot_btnBeforeStart", "execute", xac_left, xac_top+30, xac_width )
    gui.newButton( XAutoCopilot.gui_h, "XAutoCopilot_btnPushback",    "execute", xac_left, xac_top+45, xac_width )
    gui.newButton( XAutoCopilot.gui_h, "XAutoCopilot_btnEngineStart", "execute", xac_left, xac_top+60, xac_width )
    gui.newButton( XAutoCopilot.gui_h, "XAutoCopilot_btnAfterEngineStart", "execute", xac_left, xac_top+75, xac_width )

end

function XAutoCopilot_btnPreparation_OnClick()
    prepstate1 = 0
    prepstate2 = 0
    prepstate3 = 0
    prepstate4 = 0
    prepstate5 = 0
    preparation_finish = 0
    XAutoCopilot_btnPreparation_State = 1
end

function XAutoCopilot_btnMcdu_OnClick()
    gui.showWindow( XAutoCopilotMcdu.gui_h )
end

function XAutoCopilot_btnBeforeStart_OnClick()
    beforestartstate1 = 0
    beforestart_finish = 0
    XAutoCopilot_btnBeforeStart_State = 1
end

function XAutoCopilot_btnPushback_OnClick()
    pushback_finish = 0
    XAutoCopilot_btnPushback_State = 1
end

function XAutoCopilot_btnEngineStart_OnClick()
    enginestart_finish = 0
    XAutoCopilot_btnEngineStart_State = 1
end

function XAutoCopilot_btnAfterEngineStart_OnClick()
    afterenginestart_finish = 0
    XAutoCopilot_btnAfterEngineStart_State = 1
end

-- Toolbar Widget definition/Integration. --

ToolXAutoCopilot = {
    active = true,
    texture = gfx.loadPng( gizmo.getFolder() .. "firmware/icons/world.png" ),

    name = "XAutoCopilot",
    run = function(self)
        if( XAutoCopilot )then
            gui.showWindow( XAutoCopilot.gui_h )
        else
            self.active = false
        end
    end,
}


if( ToolTray )then
    ToolTray:register( ToolXAutoCopilot )
end


