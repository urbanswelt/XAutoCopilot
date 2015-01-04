--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 01.07.2014
-- Time: 20:49
-- 


XAutoCopilotUpdater = {
    gui_h = gui.newWindow("XAutoCopilotUpdater"),
    l = 560, --left position on screen
    t = 430, --top position on screen
    w = 250, --window width
    h = 180, --window height
    auto_show = false,
}



function XAutoCopilotUpdater_OnCreate()
    local w, h = gfx.getScreenSize()

    --gui.setWindowSize( gui_window_id, left, top, width, height )
    gui.setWindowSize(XAutoCopilotUpdater.gui_h, XAutoCopilotUpdater.l, XAutoCopilotUpdater.t, XAutoCopilotUpdater.w, XAutoCopilotUpdater.h)
    gui.setWindowCaption(XAutoCopilotUpdater.gui_h, "Debug")

    local xac_left = 10
    local xac_top = 30
    local xac_width = 100


    gui.newButton(XAutoCopilotUpdater.gui_h, "XAutoCopilotUpdater_btnStart", "Debug", xac_left, xac_top + 125, xac_width - 30)
end




function XAutoCopilotUpdater_btnStart_OnClick()
	toast.newError("Bugi", "What is wronge here Ben ?")
end

function XAutoCopilotUpdater_OnUpdate()

end


ToolXAutoCopilotUpdater = {
    active = true,
    texture = gfx.loadPng(acf.getFolder() .. "scripts/xac_lua/icons/Flight.png"),
    name = "XAutoCopilotUpdater",
    run = function(self)
        if (XAutoCopilotUpdater) then
            gui.showWindow(XAutoCopilotUpdater.gui_h)
        else
            self.active = false
        end
    end,
}


if (ToolTray) then
    ToolTray:register(ToolXAutoCopilotUpdater)
end