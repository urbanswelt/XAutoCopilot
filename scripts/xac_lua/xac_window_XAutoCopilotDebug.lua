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


    gui.newButton(XAutoCopilotDebug.gui_h, "XAutoCopilotDebug_btnStart", "Debug", xac_left, xac_top + 125, xac_width - 30)
end


function XAutoCopilotDebug_btnStart_OnClick()
    prefs.save = function()

    --console.log("prefs.save()..")

        local prefs_blob = "--Auto Generated Gizmo Preferences Data\nreturn" .. vardump_lua(prefs.values)
        --console.log( prefs_blob )

        local prefs_path = prefs.filename

        --write prefs data
        local fh = io.open( prefs_path, "wb" )
        if( fh )then
            --prefs_data = fh:read("*all")
            fh:write( prefs_blob )
            fh:close()
            fh = nil

            --logging.warning("prefs saved. (" .. prefs_path ..  ")")

        else
            error("prefs.save(): Failed: (" .. prefs_path ..  ")")

        end --check file handle is not nil

    end --prefs.save()
end


ToolXAutoCopilotDebug = {
    active = true,
    texture = gfx.loadPng(acf.getFolder() .. "scripts/xac_lua/icons/Approach.png"),
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