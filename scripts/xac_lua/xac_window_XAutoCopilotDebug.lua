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
    --local url = 'http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/xac_init.lua'

end

-- set Version for updater
xac_updater_version = 201506012053
xac_version = 201506012053

function xac_updater_check ()
    local url = 'http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/xac_updater_version'
    http.get( url, 'http_updater_check' )
end

function http_updater_check( data, url, size )
    local data = tonumber(data)
    if data > xac_updater_version then
        toast.newInfo("UPDATER", "A new Updater is available")
    end

    --local filename = acf.getFolder() .. "scripts/xac_lua/prefs/xac_prefs2.txt"
    --httpupdater.save(filename,data)
end


function xac_update_check ()
    local url = 'http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/xac_version'
    http.get( url, 'http_update_check' )
end

function http_update_check( data, url, size )
    local data = tonumber(data)
    if data > xac_updater_version then
        toast.newInfo("UPDATE", "A new Update for XAC is available")
    end
end



http_updater_save = function(filename,data)

    local data_blob = data
    local data_path = filename

    --write data
    local fh = io.open( data_path, "wb" )
    if( fh )then
        fh:write( data_blob )
        fh:close()
        fh = nil

    else
        error("http_updater_save(): Failed: (" .. data_path ..  ")")

    end --check file handle is not nil

end --http_updater.save()



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