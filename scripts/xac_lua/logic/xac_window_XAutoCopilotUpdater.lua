--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 01.07.2014
-- Time: 20:49
-- 

xac_update = {}
--updater script
xac_update.updater = { url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/xac_window_XAutoCopilotUpdater.lua", data = "", size = "", localsize = "", status = "0", filename = acf.getFolder() .. "scripts/xac_lua/logic/xac_window_XAutoCopilotUpdater.lua" }

--xac root script`s
xac_update.init = { url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/xac_init.lua", data = "", size = "", localsize = "", status = "0", filename = acf.getFolder() .. "scripts/xac_lua/xac_init.lua" }
xac_update.version = { url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/version", data = "", size = "", localsize = "", status = "0", filename = acf.getFolder() .. "scripts/xac_lua/version" }
xac_update.vupdater = { url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/version_updater", data = "", size = "", localsize = "", status = "0", filename = acf.getFolder() .. "scripts/xac_lua/version_updater" }
xac_update.changelog = { url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/version_changelog", data = "", size = "", localsize = "", status = "0", filename = acf.getFolder() .. "scripts/xac_lua/version_changelog" }

--folder help/icons/prefs not really needed yet
--folder logic
xac_update.datarefs = { url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/xac_datarefs.lua", data = "", size = "", localsize = "", status = "0", filename = acf.getFolder() .. "scripts/xac_lua/logic/xac_datarefs.lua" }
xac_update.pdatarefs = { url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/xac_publish_dataref.lua", data = "", size = "", localsize = "", status = "0", filename = acf.getFolder() .. "scripts/xac_lua/logic/xac_publish_dataref.lua" }
xac_update.helper = { url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/xac_function_helper.lua", data = "", size = "", localsize = "", status = "0", filename = acf.getFolder() .. "scripts/xac_lua/logic/xac_function_helper.lua" }
xac_update.copilot = { url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/xac_window_XAutoCopilot.lua", data = "", size = "", localsize = "", status = "0", filename = acf.getFolder() .. "scripts/xac_lua/logic/xac_window_XAutoCopilot.lua" }
xac_update.approach = { url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/xac_window_XAutoCopilotBriefingApproach.lua", data = "", size = "", localsize = "", status = "0", filename = acf.getFolder() .. "scripts/xac_lua/logic/xac_window_XAutoCopilotBriefingApproach.lua" }
xac_update.departure = { url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/xac_window_XAutoCopilotBriefingDeparture.lua", data = "", size = "", localsize = "", status = "0", filename = acf.getFolder() .. "scripts/xac_lua/logic/xac_window_XAutoCopilotBriefingDeparture.lua" }
xac_update.debug = { url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/xac_window_XAutoCopilotDebug.lua", data = "", size = "", localsize = "", status = "0", filename = acf.getFolder() .. "scripts/xac_lua/logic/xac_window_XAutoCopilotDebug.lua" }
xac_update.flightinfo = { url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/xac_window_XAutoCopilotFlightInfo.lua", data = "", size = "", localsize = "", status = "0", filename = acf.getFolder() .. "scripts/xac_lua/logic/xac_window_XAutoCopilotFlightInfo.lua" }
xac_update.route = { url = "http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/logic/xac_window_XAutoCopilotRoute.lua", data = "", size = "", localsize = "", status = "0", filename = acf.getFolder() .. "scripts/xac_lua/logic/xac_window_XAutoCopilotRoute.lua" }

-- -- set Version for updates year, month, day, hour, minutes
--xac_version = 201501082240

local version = lines_from(xac_update.version.filename)
local vupdater =lines_from(xac_update.vupdater.filename)

xac_version = tonumber(version[1])
xac_updater_version = tonumber(vupdater[1])

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

    XAutoCopilotUpdater.updatertext = gui.newLabel(XAutoCopilotUpdater.gui_h, "ignored", "New Updater file", left, top, width)
    XAutoCopilotUpdater.updaterbutton = gui.newButton(XAutoCopilotUpdater.gui_h, "XAutoCopilotUpdater_btnUpdateUpdater", "Update", left + 130, top, width - 50)

    local left = 10
    local top = 60
    local width = 100

    XAutoCopilotUpdater.updatetext = gui.newLabel(XAutoCopilotUpdater.gui_h, "ignored", "XAC files was changed", left, top, width)
    XAutoCopilotUpdater.updatebutton = gui.newButton(XAutoCopilotUpdater.gui_h, "XAutoCopilotUpdater_btnUpdate", "Update", left + 130, top, width - 50)

    local left = 10
    local top = 155
    local width = 100

    XAutoCopilotUpdater.autochk = gui.newCheckbox(XAutoCopilotUpdater.gui_h, "XAutoCopilotUpdaterautochk", "", left, top - 50, width - 80)
    XAutoCopilotUpdater.autochktext = gui.newLabel(XAutoCopilotUpdater.gui_h, "ignored", "New Version Check on Start", left + 30, top - 50, width - 80)

    gui.newButton(XAutoCopilotUpdater.gui_h, "XAutoCopilotUpdater_btnCheck", "Check", left, top, width - 50)
    XAutoCopilotUpdater.rebootbutton = gui.newButton(XAutoCopilotUpdater.gui_h, "XAutoCopilotUpdater_btnReboot", "Reboot", left + 60, top, width - 50)

    -- help + save icon
    XAutoCopilotUpdater.helpIcon_h = gui.newCustomWidget(XAutoCopilotUpdater.gui_h, "XAutoCopilotUpdater_helpIcon", XAutoCopilotUpdater.w - 20, 20, 17, 17)
    XAutoCopilotUpdater.diskIcon_h = gui.newCustomWidget(XAutoCopilotUpdater.gui_h, "XAutoCopilotUpdater_diskIcon", XAutoCopilotUpdater.w - 40, 20, 17, 17)

    gui.hideWidget(XAutoCopilotUpdater.updatertext)
    gui.hideWidget(XAutoCopilotUpdater.updaterbutton)
    gui.hideWidget(XAutoCopilotUpdater.updatetext)
    gui.hideWidget(XAutoCopilotUpdater.updatebutton)
    gui.hideWidget(XAutoCopilotUpdater.rebootbutton)

    local autochk = xac_prefs.get("XAutoCopilotUpdater.autochk", 1)

    if autochk == true then
        gui.setWidgetValue(XAutoCopilotUpdater.autochk, 1)
        local tmr_oneshot = timer.newOneShot("check_for_updates", 20.0)
    else
        gui.setWidgetValue(XAutoCopilotUpdater.autochk, 0)
    end
end

function XAutoCopilotUpdater_OnUpdate()

    if xac_update.updater.status == 1 and xac_update.updater.size ~= fsize(xac_update.updater.filename) then
        gui.showWidget(XAutoCopilotUpdater.updatertext)
        gui.showWidget(XAutoCopilotUpdater.updaterbutton)
        xac_update.updater.status = 2
    end

    if xac_update.vupdater.status == 1 and xac_updater_version ~= tonumber(xac_update.vupdater.data) then
        gui.showWidget(XAutoCopilotUpdater.updatertext)
        gui.showWidget(XAutoCopilotUpdater.updaterbutton)
        xac_update.vupdater.status = 2
    end

    if xac_update.init.status == 1 and xac_update.init.size ~= fsize(xac_update.init.filename) then
        gui.showWidget(XAutoCopilotUpdater.updatetext)
        gui.showWidget(XAutoCopilotUpdater.updatebutton)
        xac_update.init.status = 2
    end

    if xac_update.version.status == 1 and xac_version ~= tonumber(xac_update.version.data) then
        gui.showWidget(XAutoCopilotUpdater.updatetext)
        gui.showWidget(XAutoCopilotUpdater.updatebutton)
        xac_update.version.status = 2
    end

    if xac_update.changelog.status == 1 and xac_update.changelog.size ~= fsize(xac_update.changelog.filename) then
        gui.showWidget(XAutoCopilotUpdater.updatetext)
        gui.showWidget(XAutoCopilotUpdater.updatebutton)
        xac_update.changelog.status = 2
    end

    if xac_update.datarefs.status == 1 and xac_update.datarefs.size ~= fsize(xac_update.datarefs.filename) then
        gui.showWidget(XAutoCopilotUpdater.updatetext)
        gui.showWidget(XAutoCopilotUpdater.updatebutton)
        xac_update.datarefs.status = 2
    end

    if xac_update.pdatarefs.status == 1 and xac_update.pdatarefs.size ~= fsize(xac_update.pdatarefs.filename) then
        gui.showWidget(XAutoCopilotUpdater.updatetext)
        gui.showWidget(XAutoCopilotUpdater.updatebutton)
        xac_update.pdatarefs.status = 2
    end

    if xac_update.helper.status == 1 and xac_update.helper.size ~= fsize(xac_update.helper.filename) then
        gui.showWidget(XAutoCopilotUpdater.updatetext)
        gui.showWidget(XAutoCopilotUpdater.updatebutton)
        xac_update.helper.status = 2
    end

    if xac_update.copilot.status == 1 and xac_update.copilot.size ~= fsize(xac_update.copilot.filename) then
        gui.showWidget(XAutoCopilotUpdater.updatetext)
        gui.showWidget(XAutoCopilotUpdater.updatebutton)
        xac_update.copilot.status = 2
    end

    if xac_update.approach.status == 1 and xac_update.approach.size ~= fsize(xac_update.approach.filename) then
        gui.showWidget(XAutoCopilotUpdater.updatetext)
        gui.showWidget(XAutoCopilotUpdater.updatebutton)
        xac_update.approach.status = 2
    end

    if xac_update.departure.status == 1 and xac_update.departure.size ~= fsize(xac_update.departure.filename) then
        gui.showWidget(XAutoCopilotUpdater.updatetext)
        gui.showWidget(XAutoCopilotUpdater.updatebutton)
        xac_update.departure.status = 2
    end

    if xac_update.debug.status == 1 and xac_update.debug.size ~= fsize(xac_update.debug.filename) then
        gui.showWidget(XAutoCopilotUpdater.updatetext)
        gui.showWidget(XAutoCopilotUpdater.updatebutton)
        xac_update.debug.status = 2
    end

    if xac_update.flightinfo.status == 1 and xac_update.flightinfo.size ~= fsize(xac_update.flightinfo.filename) then
        gui.showWidget(XAutoCopilotUpdater.updatetext)
        gui.showWidget(XAutoCopilotUpdater.updatebutton)
        xac_update.flightinfo.status = 2
    end

    if xac_update.route.status == 1 and xac_update.route.size ~= fsize(xac_update.route.filename) then
        gui.showWidget(XAutoCopilotUpdater.updatetext)
        gui.showWidget(XAutoCopilotUpdater.updatebutton)
        xac_update.route.status = 2
    end
end

function XAutoCopilotUpdater_helpIcon_OnDraw()
    --icon
    local icon_file = gfx.loadPng(gizmo.getFolder() .. "firmware/icons/" .. tostring("help.png"))
    gfx.texOn()
    gfx.setColor(xaccolor.white)
    gfx.useTexture(icon_file)
    gfx.drawTexturedQuad(0, 0, 16, 16)
end

function XAutoCopilotUpdater_diskIcon_OnDraw()
    --icon
    local icon_file = gfx.loadPng(gizmo.getFolder() .. "firmware/icons/" .. tostring("disk.png"))
    gfx.texOn()
    gfx.setColor(xaccolor.white)
    gfx.useTexture(icon_file)
    gfx.drawTexturedQuad(0, 0, 16, 16)
end

function XAutoCopilotUpdater_helpIcon_OnMouseDown()
infocube.plate =  "STRING"
end


function XAutoCopilotUpdater_diskIcon_OnMouseDown()
    local filename = acf.getFolder() .. "scripts/xac_lua/prefs/xac_prefs.txt"
    xac_prefs.set("XAutoCopilotUpdater.autochk", gui.getWidgetValue(XAutoCopilotUpdater.autochk))
    xac_prefs.save(filename)
end

function XAutoCopilotUpdater_btnCheck_OnClick()

    if gui.getWidgetValue(XAutoCopilotUpdater.autochk) == true then
        xac_trigger_update()
    end

    if gui.getWidgetValue(XAutoCopilotUpdater.autochk) == false then
        check_for_updates()
        xac_trigger_update()
    end
end

function XAutoCopilotUpdater_btnUpdate_OnClick()
    --http_update_save(filename,data)
    if xac_update.init.status == 2 then
        http_update_save(xac_update.init.filename, xac_update.init.data)
        xac_update.init.status = 3
        gui.hideWidget(XAutoCopilotUpdater.updatebutton)
    end

    if xac_update.version.status == 2 then
        http_update_save(xac_update.version.filename, xac_update.version.data)
        xac_update.version.status = 3
        gui.hideWidget(XAutoCopilotUpdater.updatebutton)
    end

    if xac_update.changelog.status == 2 then
        http_update_save(xac_update.changelog.filename, xac_update.changelog.data)
        xac_update.changelog.status = 3
        gui.hideWidget(XAutoCopilotUpdater.updatebutton)
    end

    if xac_update.datarefs.status == 2 then
        http_update_save(xac_update.datarefs.filename, xac_update.datarefs.data)
        xac_update.datarefs.status = 3
        gui.hideWidget(XAutoCopilotUpdater.updatebutton)
    end

    if xac_update.pdatarefs.status == 2 then
        http_update_save(xac_update.pdatarefs.filename, xac_update.pdatarefs.data)
        xac_update.pdatarefs.status = 3
        gui.hideWidget(XAutoCopilotUpdater.updatebutton)
    end

    if xac_update.helper.status == 2 then
        http_update_save(xac_update.helper.filename, xac_update.helper.data)
        xac_update.helper.status = 3
        gui.hideWidget(XAutoCopilotUpdater.updatebutton)
    end

    if xac_update.copilot.status == 2 then
        http_update_save(xac_update.copilot.filename, xac_update.copilot.data)
        xac_update.copilot.status = 3
        gui.hideWidget(XAutoCopilotUpdater.updatebutton)
    end

    if xac_update.approach.status == 2 then
        http_update_save(xac_update.approach.filename, xac_update.approach.data)
        xac_update.approach.status = 3
        gui.hideWidget(XAutoCopilotUpdater.updatebutton)
    end

    if xac_update.departure.status == 2 then
        http_update_save(xac_update.departure.filename, xac_update.departure.data)
        xac_update.departure.status = 3
        gui.hideWidget(XAutoCopilotUpdater.updatebutton)
    end

    if xac_update.debug.status == 2 then
        http_update_save(xac_update.debug.filename, xac_update.debug.data)
        xac_update.debug.status = 3
        gui.hideWidget(XAutoCopilotUpdater.updatebutton)
    end

    if xac_update.flightinfo.status == 2 then
        http_update_save(xac_update.flightinfo.filename, xac_update.flightinfo.data)
        xac_update.flightinfo.status = 3
        gui.hideWidget(XAutoCopilotUpdater.updatebutton)
    end

    if xac_update.route.status == 2 then
        http_update_save(xac_update.route.filename, xac_update.route.data)
        xac_update.route.status = 3
        gui.hideWidget(XAutoCopilotUpdater.updatebutton)
    end

    local tmr_oneshot = timer.newOneShot("show_reboot_button", 5.0)
end

function XAutoCopilotUpdater_btnUpdateUpdater_OnClick()
    --http_update_save(filename,data)
    if xac_update.updater.status == 2 then
        http_update_save(xac_update.updater.filename, xac_update.updater.data)
        xac_update.updater.status = 3
        gui.hideWidget(XAutoCopilotUpdater.updaterbutton)
    end

    if xac_update.vupdater.status == 2 then
        http_update_save(xac_update.vupdater.filename, xac_update.vupdater.data)
        xac_update.vupdater.status = 3
        gui.hideWidget(XAutoCopilotUpdater.updaterbutton)
    end

    local tmr_oneshot = timer.newOneShot("show_reboot_button", 5.0)
end

function show_reboot_button ()
    gui.showWidget(XAutoCopilotUpdater.rebootbutton)
end

function XAutoCopilotUpdater_btnReboot_OnClick()
    gizmo.reboot()
end

function check_for_updates()
    xac_updater_check()
    xac_update_check()
end

function xac_updater_check()
    local url = 'http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/version_updater'
    http.get(url, 'http_updater_check')
end

function http_updater_check(data, url, size)
    local data = tonumber(data)
    if (data) then
        if data ~= xac_updater_version then
            --infocube.newInfo("NEW UPDATER SCRIPT", "Version: " .. data .. "\nCurrent: " .. xac_updater_version .. "")
        end
    else
        Network_Error("Version Updater Check")
    end
end

function xac_update_check()
    local url = 'http://labor.urbanswelt.de/XAutoCopilot/scripts/xac_lua/version'
    http.get(url, 'http_update_check')
end

function http_update_check(data, url, size)
    local data = tonumber(data)
    if (data) then
        if data ~= xac_version then
            --infocube.newInfo("NEW UPDATES FOR XAC", "Version: " .. data .. "\nCurrent: " .. xac_version .. "")
        end
    else
        Network_Error("XAC Version Update Check")
    end
end

http_update_save = function(filename, data)

    local data_blob = data
    local data_path = filename

    --write data
    local fh = io.open(data_path, "wb")
    if (fh) then
        fh:write(data_blob)
        fh:close()
        fh = nil

    else
        error("http_update_save(): Failed: (" .. data_path .. ")")
    end --check file handle is not nil
end --http_update_save()

function Network_Error(modul)
    local modul = modul
    --infocube.newError("Network Error", modul)
end

function xac_trigger_update()
    http.get(xac_update.updater.url, 'xac_http_update_get')
    http.get(xac_update.init.url, 'xac_http_update_get')
    http.get(xac_update.version.url, 'xac_http_update_get')
    http.get(xac_update.vupdater.url, 'xac_http_update_get')
    http.get(xac_update.changelog.url, 'xac_http_update_get')
    http.get(xac_update.datarefs.url, 'xac_http_update_get')
    http.get(xac_update.pdatarefs.url, 'xac_http_update_get')
    http.get(xac_update.helper.url, 'xac_http_update_get')
    http.get(xac_update.copilot.url, 'xac_http_update_get')
    http.get(xac_update.approach.url, 'xac_http_update_get')
    http.get(xac_update.departure.url, 'xac_http_update_get')
    http.get(xac_update.debug.url, 'xac_http_update_get')
    http.get(xac_update.flightinfo.url, 'xac_http_update_get')
    http.get(xac_update.route.url, 'xac_http_update_get')
end

function xac_http_update_get(data, url, size)
    local data = data
    local url = url
    local size = size
    local status = 1 --download to table is finish
    local dataread

    if size > 1 then
        dataread = 1
    end

    if size < 1 and xac_update.updater.url == url then
        Network_Error("Download Update Scripts") --later in window !!!
    end

    --write to updater table
    if xac_update.updater.url == url and dataread == 1 then
        xac_update.updater.data = data
        xac_update.updater.size = size
        xac_update.updater.status = status
        xac_update.updater.localsize = fsize(xac_update.updater.filename) --test
    end
    --write to other script tables
    if xac_update.init.url == url and dataread == 1 then
        xac_update.init.data = data
        xac_update.init.size = size
        xac_update.init.status = status
        xac_update.init.localsize = fsize(xac_update.init.filename)
    end

    if xac_update.version.url == url and dataread == 1 then
        xac_update.version.data = data
        xac_update.version.size = size
        xac_update.version.status = status
        xac_update.version.localsize = fsize(xac_update.version.filename)
    end

    if xac_update.vupdater.url == url and dataread == 1 then
        xac_update.vupdater.data = data
        xac_update.vupdater.size = size
        xac_update.vupdater.status = status
        xac_update.vupdater.localsize = fsize(xac_update.vupdater.filename)
    end

    if xac_update.changelog.url == url and dataread == 1 then
        xac_update.changelog.data = data
        xac_update.changelog.size = size
        xac_update.changelog.status = status
        xac_update.changelog.localsize = fsize(xac_update.changelog.filename)
    end

    if xac_update.datarefs.url == url and dataread == 1 then
        xac_update.datarefs.data = data
        xac_update.datarefs.size = size
        xac_update.datarefs.status = status
        xac_update.datarefs.localsize = fsize(xac_update.datarefs.filename)
    end

    if xac_update.pdatarefs.url == url and dataread == 1 then
        xac_update.pdatarefs.data = data
        xac_update.pdatarefs.size = size
        xac_update.pdatarefs.status = status
        xac_update.pdatarefs.localsize = fsize(xac_update.pdatarefs.filename)
    end

    if xac_update.helper.url == url and dataread == 1 then
        xac_update.helper.data = data
        xac_update.helper.size = size
        xac_update.helper.status = status
        xac_update.helper.localsize = fsize(xac_update.helper.filename)
    end

    if xac_update.copilot.url == url and dataread == 1 then
        xac_update.copilot.data = data
        xac_update.copilot.size = size
        xac_update.copilot.status = status
        xac_update.copilot.localsize = fsize(xac_update.copilot.filename)
    end

    if xac_update.approach.url == url and dataread == 1 then
        xac_update.approach.data = data
        xac_update.approach.size = size
        xac_update.approach.status = status
        xac_update.approach.localsize = fsize(xac_update.approach.filename)
    end

    if xac_update.departure.url == url and dataread == 1 then
        xac_update.departure.data = data
        xac_update.departure.size = size
        xac_update.departure.status = status
        xac_update.departure.localsize = fsize(xac_update.departure.filename)
    end

    if xac_update.debug.url == url and dataread == 1 then
        xac_update.debug.data = data
        xac_update.debug.size = size
        xac_update.debug.status = status
        xac_update.debug.localsize = fsize(xac_update.debug.filename)
    end

    if xac_update.flightinfo.url == url and dataread == 1 then
        xac_update.flightinfo.data = data
        xac_update.flightinfo.size = size
        xac_update.flightinfo.status = status
        xac_update.flightinfo.localsize = fsize(xac_update.flightinfo.filename)
    end

    if xac_update.route.url == url and dataread == 1 then
        xac_update.route.data = data
        xac_update.route.size = size
        xac_update.route.status = status
        xac_update.route.localsize = fsize(xac_update.route.filename)
    end
end

ToolXAutoCopilotUpdater = {
    active = true,
    texture = gfx.loadPng(gizmo.getFolder() .. "firmware/icons/" .. tostring("ipod_cast.png")),
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
