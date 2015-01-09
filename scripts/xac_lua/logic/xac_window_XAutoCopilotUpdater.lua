--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 01.07.2014
-- Time: 20:49
-- 
-- set Version for updates year, month, day, hour, minutes
--xac_updater_version = 201501082240
xac_updater_version = 201506012350

xac_update = {}
--updater script
xac_update.updater = {url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/xac_window_XAutoCopilotUpdater.lua", data = "", size = "", status = "0" }

--xac root script`s
xac_update.init = {url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/xac_init.lua", data = "", size = "", status = "0" }
xac_update.version = {url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/version", data = "", size = "", status = "0" }
xac_update.vupdater = {url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/version_updater", data = "", size = "", status = "0" }
xac_update.changelog = {url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/version_changelog", data = "", size = "", status = "0" }

--folder help/icons/prefs not really needed yet
--folder logic
xac_update.datarefs = {url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/xac_datarefs.lua", data = "", size = "", status = "0" }
xac_update.pdatarefs = {url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/xac_publish_dataref.lua", data = "", size = "", status = "0" }
xac_update.helper = {url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/xac_function_helper.lua", data = "", size = "", status = "0" }
xac_update.copilot = {url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/xac_window_XAutoCopilot.lua", data = "", size = "", status = "0" }
xac_update.approach = {url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/xac_window_XAutoCopilotBriefingApproach.lua", data = "", size = "", status = "0" }
xac_update.departure = {url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/xac_window_XAutoCopilotBriefingDeparture.lua", data = "", size = "", status = "0" }
xac_update.debug = {url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/xac_window_XAutoCopilotDebug.lua", data = "", size = "", status = "0" }
xac_update.flightinfo = {url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/xac_window_XAutoCopilotFlightInfo.lua", data = "", size = "", status = "0" }
xac_update.route = {url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/xac_window_XAutoCopilotRoute.lua", data = "", size = "", status = "0" }

--folder FirmewarePreview
xac_update.color = {url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/FirmewarePreview/color_api.lua", data = "", size = "", status = "0" }
xac_update.icons = {url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/FirmewarePreview/icons_api.lua", data = "", size = "", status = "0" }
xac_update.toast = {url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/FirmewarePreview/toast_api.lua", data = "", size = "", status = "0" }
xac_update.info = {url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/FirmewarePreview/Info.txt", data = "", size = "", status = "0" }


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

    local left = 10
    local top = 30
    local width = 100

    gui.newLabel(XAutoCopilotUpdater.gui_h, "ignored", "Updater files", left, top, width); top = top + 15
    gui.newLabel(XAutoCopilotUpdater.gui_h, "ignored", "XAC files", left, top, width); top = top + 15

    local left = 10
    local top = 30
    local width = 100

    gui.newButton(XAutoCopilotUpdater.gui_h, "XAutoCopilotUpdater_btnCheck", "Check", left, top + 125, width - 50)
    gui.newButton(XAutoCopilotUpdater.gui_h, "XAutoCopilotUpdater_btnUpdate", "Update", left + 60, top + 125, width - 50)
    gui.newButton(XAutoCopilotUpdater.gui_h, "XAutoCopilotUpdater_btnReboot", "Reboot", left + 120, top + 125, width - 50)

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
            toast.newInfo("NEW UPDATER SCRIPT", "Version: " .. data ..  "\nCurrent: " .. xac_updater_version .. "")
            xac_new_updater = 1
        end
    else
        Network_Error("Download Updater Check")
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
            toast.newInfo("NEW UPDATES FOR XAC", "Version: " .. data ..  "\nCurrent: " .. xac_version .. "")
            xac_new_update = 1
        end
    else
        Network_Error("Download Update Check")
    end
end

http_update_save = function(filename,data)

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

function Network_Error(modul)
    local modul = modul
    toast.newError("Network Error", modul)
end

function XAutoCopilotUpdater_btnCheck_OnClick()
    check_for_updates()
end

function XAutoCopilotUpdater_btnUpdate_OnClick()
    xac_trigger_update ()
end

function XAutoCopilotUpdater_btnReboot_OnClick()
    --gizmo.reboot()
    local filename = acf.getFolder() .. "scripts/xac_lua/logic/xac_window_XAutoCopilotUpdater.lua"
    local file = acf.getFolder() .. "scripts/xac_lua/logic/xac_window_XAutoCopilotUpdater.lua"
    --http_update_save(filename,data)

    local fh = io.open( filename, "r" )
    if( fh )then
        filesize = fh:seek("end")
        fh:close()
        fh = nil
    else
        logging.warning("No file found!")
        return
    end
    local somewhat = fsize (filename)
    logging.debug(filesize .." local")
    logging.debug(xac_update.updater.size .." remote")
    logging.debug(somewhat .." fsize")

end

function fsize (file)
    local file = io.open( file, "r" )
    local current = file:seek()      -- get current position
    local size = file:seek("end")    -- get file size
    file:seek("set", current)        -- restore position
    return size
end


function xac_trigger_update ()
    http.get( xac_update.updater.url, 'xac_http_update_get' )
    http.get( xac_update.init.url, 'xac_http_update_get' )
    http.get( xac_update.version.url, 'xac_http_update_get' )
    http.get( xac_update.vupdater.url, 'xac_http_update_get' )
    http.get( xac_update.changelog.url, 'xac_http_update_get' )
    http.get( xac_update.datarefs.url, 'xac_http_update_get' )
    http.get( xac_update.pdatarefs.url, 'xac_http_update_get' )
    http.get( xac_update.helper.url, 'xac_http_update_get' )
    http.get( xac_update.copilot.url, 'xac_http_update_get' )
    http.get( xac_update.approach.url, 'xac_http_update_get' )
    http.get( xac_update.departure.url, 'xac_http_update_get' )
    http.get( xac_update.debug.url, 'xac_http_update_get' )
    http.get( xac_update.flightinfo.url, 'xac_http_update_get' )
    http.get( xac_update.route.url, 'xac_http_update_get' )
    http.get( xac_update.color.url, 'xac_http_update_get' )
    http.get( xac_update.icons.url, 'xac_http_update_get' )
    http.get( xac_update.toast.url, 'xac_http_update_get' )
    http.get( xac_update.info.url, 'xac_http_update_get' )
end

--local filename = acf.getFolder() .. "scripts/xac_lua/logic/xac_window_XAutoCopilotUpdater.lua"
--http_update_save(filename,data)

function xac_http_update_get( data, url, size )
    local data = data
    local url = url
    local size = size
    local status = 1 --download to table is finish
    local dataread

    if size > 1 then
        dataread = 1
    end

    if size < 1 and xac_update.updater.url == url then
        Network_Error("Download Update Script") --later in window !!!
    end

    --write to updater table
    if xac_update.updater.url == url and dataread == 1 then
        xac_update.updater.data = data
        xac_update.updater.size = size
        xac_update.updater.status = status
    end
    --write to other script tables
    if xac_update.init.url == url and dataread == 1 then
        xac_update.init.data = data
        xac_update.init.size = size
        xac_update.init.status = status
    end

    if xac_update.version.url == url and dataread == 1 then
        xac_update.version.data = data
        xac_update.version.size = size
        xac_update.version.status = status
    end

    if xac_update.vupdater.url == url and dataread == 1 then
        xac_update.vupdater.data = data
        xac_update.vupdater.size = size
        xac_update.vupdater.status = status
    end

    if xac_update.changelog.url == url and dataread == 1 then
        xac_update.changelog.data = data
        xac_update.changelog.size = size
        xac_update.changelog.status = status
    end

    if xac_update.datarefs.url == url and dataread == 1 then
        xac_update.datarefs.data = data
        xac_update.datarefs.size = size
        xac_update.datarefs.status = status
    end

    if xac_update.pdatarefs.url == url and dataread == 1 then
        xac_update.pdatarefs.data = data
        xac_update.pdatarefs.size = size
        xac_update.pdatarefs.status = status
    end

    if xac_update.helper.url == url and dataread == 1 then
        xac_update.helper.data = data
        xac_update.helper.size = size
        xac_update.helper.status = status
    end

    if xac_update.copilot.url == url and dataread == 1 then
        xac_update.copilot.data = data
        xac_update.copilot.size = size
        xac_update.copilot.status = status
    end

    if xac_update.approach.url == url and dataread == 1 then
        xac_update.approach.data = data
        xac_update.approach.size = size
        xac_update.approach.status = status
    end

    if xac_update.departure.url == url and dataread == 1 then
        xac_update.departure.data = data
        xac_update.departure.size = size
        xac_update.departure.status = status
    end

    if xac_update.debug.url == url and dataread == 1 then
        xac_update.debug.data = data
        xac_update.debug.size = size
        xac_update.debug.status = status
    end

    if xac_update.flightinfo.url == url and dataread == 1 then
        xac_update.flightinfo.data = data
        xac_update.flightinfo.size = size
        xac_update.flightinfo.status = status
    end

    if xac_update.route.url == url and dataread == 1 then
        xac_update.route.data = data
        xac_update.route.size = size
        xac_update.route.status = status
    end

    if xac_update.color.url == url and dataread == 1 then
        xac_update.color.data = data
        xac_update.color.size = size
        xac_update.color.status = status
    end

    if xac_update.icons.url == url and dataread == 1 then
        xac_update.icons.data = data
        xac_update.icons.size = size
        xac_update.icons.status = status
    end

    if xac_update.toast.url == url and dataread == 1 then
        xac_update.toast.data = data
        xac_update.toast.size = size
        xac_update.toast.status = status
    end

    if xac_update.info.url == url and dataread == 1 then
        xac_update.info.data = data
        xac_update.info.size = size
        xac_update.info.status = status
    end
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
