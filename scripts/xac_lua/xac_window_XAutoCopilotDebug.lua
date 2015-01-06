--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 01.07.2014
-- Time: 20:49
-- 


XAutoCopilotDebug = {
    gui_h = gui.newWindow("XAutoCopilotDebug"),
    l = 560, --left position on screen
    t = 430, --top position on screen
    w = 250, --window width
    h = 180, --window height
    auto_show = false,
}



function XAutoCopilotDebug_OnCreate()
    local w, h = gfx.getScreenSize()
    --gui.setWindowSize( gui_window_id, left, top, width, height )
    gui.setWindowSize(XAutoCopilotDebug.gui_h, XAutoCopilotDebug.l, XAutoCopilotDebug.t, XAutoCopilotDebug.w, XAutoCopilotDebug.h)
    gui.setWindowCaption(XAutoCopilotDebug.gui_h, "Debug")

    local xac_left = 10
    local xac_top = 30
    local xac_width = 100

    -- help icon
    XAutoCopilotDebug.helpIcon_h 	= gui.newCustomWidget( XAutoCopilotDebug.gui_h, "XAutoCopilotDebug_helpIcon", XAutoCopilotDebug.w-20, 20, 17, 17)

    local left = 2
    local oben = 20
    local widht = 200
    local hight = 160
    --XAutoCopilotDebug.help2_h 	= gui.newCustomWidget( XAutoCopilotDebug.gui_h, "XAutoCopilotDebug_help2", left, oben, widht, hight) --will resize instantly anyway
    gui.newButton(XAutoCopilotDebug.gui_h, "XAutoCopilotDebug_btnStart", "Debug", xac_left, xac_top + 125, xac_width - 30)

end

function XAutoCopilotDebug_OnBeforeClose()

end

function XAutoCopilotDebug_btnStart_OnClick()
    xac_prefs.debug()
end

function XAutoCopilotDebug_helpIcon_OnDraw()
    --icon
    local icon_file = "help.png"
    gfx.texOn()
    gfx.setColor(color.white)
    gfx.useTexture(icons.get(icon_file))
    gfx.drawTexturedQuad( 0,0, 16, 16 )

end

function XAutoCopilotDebug_helpIcon_OnMouseDown ()
    --toast.test()
    toast.newInfo("Debug Info", "This Window is only for testing\nHave a nice day!")
    end

function XAutoCopilotDebug_help2_OnDraw()
    local l,t,w,h = gui.getWidgetSize( XAutoCopilotDebug.help2_h )
    -- helper to find the position
    --gfx.texOff()
    --gfx.setColor(0.65,0.65,0.65, 1)
    --gfx.drawFilledBox( 0,0,w,h )

end



ToolXAutoCopilotDebug = {
    active = true,
    texture = gfx.loadPng(gizmo.getFolder() .. "firmware/icons/" .. tostring( "nuclear.png" )),
    name = "XAutoCopilotDebug",
    run = function(self)
        if (XAutoCopilotDebug) then
            gui.showWindow(XAutoCopilotDebug.gui_h)
        else
            self.active = false
        end
    end,
}


if (ToolTray) then
    ToolTray:register(ToolXAutoCopilotDebug)
end