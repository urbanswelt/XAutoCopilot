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
    gui.setWindowCaption(XAutoCopilotUpdater.gui_h, "Updater")

    local xac_left = 10
    local xac_top = 30
    local xac_width = 100


    gui.newButton(XAutoCopilotUpdater.gui_h, "XAutoCopilotUpdater_btnStart", "Update", xac_left, xac_top + 125, xac_width - 30)

    -- help icon
    XAutoCopilotUpdater.helpIcon_h 	= gui.newCustomWidget( XAutoCopilotUpdater.gui_h, "XAutoCopilotUpdater_helpIcon", XAutoCopilotUpdater.w-20, 20, 17, 17)
end

function XAutoCopilotUpdater_helpIcon_OnDraw()
    --icon
    local icon_file = "help.png"
    gfx.texOn()
    gfx.setColor(color.white)
    gfx.useTexture(icons.get(icon_file))
    gfx.drawTexturedQuad( 0,0, 16, 16 )

end

function XAutoCopilotUpdater_helpIcon_OnMouseDown ()
    --toast.test()
    toast.newInfo("Updater", "This Window is only for testing\nHave a nice day!")
end

local tmr_oneshot = timer.newOneShot( "check_for_updates", 20.0 )

function check_for_updates()
    xac_updater_check ()
    xac_update_check ()
end


function xac_updater_check ()
    local url = 'http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/version_updater'
    http.get( url, 'http_updater_check' )
end

function http_updater_check( data, url, size )
    local data = tonumber(data)
    if (data) then
        if data > xac_updater_version then
            toast.newInfo("UPDATER", "A new Updater is available")
        end
    else
        Network_Error()
    end
end


function xac_update_check ()
    local url = 'http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/version'
    http.get( url, 'http_update_check' )
end

function http_update_check( data, url, size )
    local data = tonumber(data)
    if (data) then
        if data > xac_version then
            toast.newInfo("UPDATE", "A new Update for XAC is available")
        end
    else
        Network_Error()
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

function Network_Error()
    toast.newError("Network", "Network Error")
end

function XAutoCopilotUpdater_btnStart_OnClick()
    --local url = 'http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/xac_init.lua'
    --local filename = acf.getFolder() .. "scripts/xac_lua/prefs/xac_prefs2.txt"
    --http_updater_save(filename,data)
end

function XAutoCopilotUpdater_OnUpdate()

end


ToolXAutoCopilotUpdater = {
    active = true,
    texture = gfx.loadPng(gizmo.getFolder() .. "firmware/icons/" .. tostring( "ipod_cast.png" )),
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