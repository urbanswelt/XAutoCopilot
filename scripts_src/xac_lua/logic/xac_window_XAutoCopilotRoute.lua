-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 25.01.14
-- Time: 17:03
-- http://gizmo.x-plugins.com/docs/Gizmo_API.htm / http://lua.gts-stolberg.de/string.php / http://www.torsten-horn.de/techdocs/ascii.htm 
-- http://de.wikipedia.org/wiki/%C3%9Cbergangsh%C3%B6he / http://de.wikipedia.org/wiki/Flugfl%C3%A4che / http://www.pilotundrecht.de/TEXTE/DOWNLOAD/translevneu.pdf


XAutoCopilotRoute = {
    gui_h = gui.newWindow("XAutoCopilotRoute"),
    l = 300, --left position on screen
    t = 430, --top position on screen
    w = 250, --window width
    h = 180, --window height
    auto_show = false,
}

function XAutoCopilotRoute_OnCreate()

    --gui.setWindowSize( gui_window_id, left, top, width, height )
    gui.setWindowSize(XAutoCopilotRoute.gui_h, XAutoCopilotRoute.l, XAutoCopilotRoute.t, XAutoCopilotRoute.w, XAutoCopilotRoute.h)
    gui.setWindowCaption(XAutoCopilotRoute.gui_h, "Route")

    local left = 70
    local top = 30
    local width = 50
    -- left side
    gui.newLabel(XAutoCopilotRoute.gui_h, "ignored", "Company Route", left, top, width)
    gui.newLabel(XAutoCopilotRoute.gui_h, "ignored", "Flight Number", left, top + 15, width)
    gui.newLabel(XAutoCopilotRoute.gui_h, "ignored", "Cost Index", left, top + 30, width)
    gui.newLabel(XAutoCopilotRoute.gui_h, "ignored", "Cruise Flightlevel", left, top + 45, width)

    gui.newButton(XAutoCopilotRoute.gui_h, "XAutoCopilotRoute_btnStart", "Start", left + 120, top + 45, width)

    gui.newLabel(XAutoCopilotRoute.gui_h, "ignored", "Taxi", left, top + 70, width)
    gui.newLabel(XAutoCopilotRoute.gui_h, "ignored", "Reserve in %", left, top + 85, width)
    gui.newLabel(XAutoCopilotRoute.gui_h, "ignored", "Final Time in HHMM", left, top + 100, width)
    gui.newLabel(XAutoCopilotRoute.gui_h, "ignored", "Extra Time in HHMM", left, top + 115, width)

    gui.newButton(XAutoCopilotRoute.gui_h, "XAutoCopilotRoute_btnFuelStart", "Fuel", left + 120, top + 115, width)

    local left = 10
    local top = 30
    local width = 60

    local corte = xac_prefs.get("XAutoCopilotRoute.corte", "KMMHKSFO")
    local fltnbr = xac_prefs.get("XAutoCopilotRoute.fltnbr", "KOM1234")
    local coi = xac_prefs.get("XAutoCopilotRoute.coi", "99")
    local crzfl = xac_prefs.get("XAutoCopilotRoute.crzfl", "200")

    -- right side
    XAutoCopilotRoute.corte = gui.newTextBox(XAutoCopilotRoute.gui_h, "ignored", corte, left, top, width)
    XAutoCopilotRoute.fltnbr = gui.newTextBox(XAutoCopilotRoute.gui_h, "ignored", fltnbr, left, top + 15, width)
    XAutoCopilotRoute.coi = gui.newTextBox(XAutoCopilotRoute.gui_h, "ignored", coi, left, top + 30, width)
    XAutoCopilotRoute.crzfl = gui.newTextBox(XAutoCopilotRoute.gui_h, "ignored", crzfl, left, top + 45, width)

    local fuel_taxi = xac_prefs.get("XAutoCopilotRoute.fuel_taxi", "0.2")
    local fuel_reserve = xac_prefs.get("XAutoCopilotRoute.fuel_reserve", "5.00")
    local fuel_final_h = xac_prefs.get("XAutoCopilotRoute.fuel_final_h", "00")
    local fuel_final_m = xac_prefs.get("XAutoCopilotRoute.fuel_final_m", "30")
    local fuel_extra_h = xac_prefs.get("XAutoCopilotRoute.fuel_extra_h", "00")
    local fuel_extra_m = xac_prefs.get("XAutoCopilotRoute.fuel_extra_m", "00")

    XAutoCopilotRoute.fuel_taxi = gui.newTextBox(XAutoCopilotRoute.gui_h, "ignored", fuel_taxi, left, top + 70, width)
    XAutoCopilotRoute.fuel_reserve = gui.newTextBox(XAutoCopilotRoute.gui_h, "ignored", fuel_reserve, left, top + 85, width)
    XAutoCopilotRoute.fuel_final_h = gui.newTextBox(XAutoCopilotRoute.gui_h, "ignored", fuel_final_h, left, top + 100, width - 30)
    XAutoCopilotRoute.fuel_final_m = gui.newTextBox(XAutoCopilotRoute.gui_h, "ignored", fuel_final_m, left + 30, top + 100, width - 30)
    XAutoCopilotRoute.fuel_extra_h = gui.newTextBox(XAutoCopilotRoute.gui_h, "ignored", fuel_extra_h, left, top + 115, width - 30)
    XAutoCopilotRoute.fuel_extra_m = gui.newTextBox(XAutoCopilotRoute.gui_h, "ignored", fuel_extra_m, left + 30, top + 115, width - 30)

    -- help + save icon
    XAutoCopilotRoute.helpIcon_h = gui.newCustomWidget(XAutoCopilotRoute.gui_h, "XAutoCopilotRoute_helpIcon", XAutoCopilotRoute.w - 20, 20, 17, 17)
    XAutoCopilotRoute.diskIcon_h = gui.newCustomWidget(XAutoCopilotRoute.gui_h, "XAutoCopilotRoute_diskIcon", XAutoCopilotRoute.w - 40, 20, 17, 17)
end

function XAutoCopilotRoute_helpIcon_OnDraw()
    --icon
    local icon_file = gfx.loadPng(gizmo.getFolder() .. "firmware/icons/" .. tostring("help.png"))
    gfx.texOn()
    gfx.setColor(xaccolor.white)
    gfx.useTexture(icon_file)
    gfx.drawTexturedQuad(0, 0, 16, 16)
end

function XAutoCopilotRoute_diskIcon_OnDraw()
    --icon
    local icon_file = gfx.loadPng(gizmo.getFolder() .. "firmware/icons/" .. tostring("disk.png"))
    gfx.texOn()
    gfx.setColor(xaccolor.white)
    gfx.useTexture(icon_file)
    gfx.drawTexturedQuad(0, 0, 16, 16)
end

function XAutoCopilotRoute_helpIcon_OnMouseDown()
    --message
    --[[local left = 2
    local top = 20
    local width = 50

    gui.hideWindow(XAutoCopilotDebug.gui_h)

    local file = acf.getFolder() .. "scripts/xac_lua/help/route.txt" --our file destination
    local lines = lines_from(file) -- line seperated table for all entrys
    local cnt = (table_length(lines))
    local i = 0
    --bla = 1

    for i=1,cnt do
        gui.newLabel(XAutoCopilotDebug.gui_h, "ignored", lines[i], left, top, width);top = top + 15
    end

    gui.showWindow(XAutoCopilotDebug.gui_h)]]

    --infocube.newInfo("Route Window Info", "This Window is only for testing\nHave a nice day!")
end

function XAutoCopilotRoute_diskIcon_OnMouseDown()
    local filename = acf.getFolder() .. "scripts/xac_lua/prefs/xac_prefs.txt"

    xac_prefs.set("XAutoCopilotRoute.corte", gui.getWidgetValue(XAutoCopilotRoute.corte))
    xac_prefs.set("XAutoCopilotRoute.fltnbr", gui.getWidgetValue(XAutoCopilotRoute.fltnbr))
    xac_prefs.set("XAutoCopilotRoute.coi", gui.getWidgetValue(XAutoCopilotRoute.coi))
    xac_prefs.set("XAutoCopilotRoute.crzfl", gui.getWidgetValue(XAutoCopilotRoute.crzfl))

    xac_prefs.set("XAutoCopilotRoute.fuel_taxi", gui.getWidgetValue(XAutoCopilotRoute.fuel_taxi))
    xac_prefs.set("XAutoCopilotRoute.fuel_reserve", gui.getWidgetValue(XAutoCopilotRoute.fuel_reserve))
    xac_prefs.set("XAutoCopilotRoute.fuel_final_h", gui.getWidgetValue(XAutoCopilotRoute.fuel_final_h))
    xac_prefs.set("XAutoCopilotRoute.fuel_final_m", gui.getWidgetValue(XAutoCopilotRoute.fuel_final_m))
    xac_prefs.set("XAutoCopilotRoute.fuel_extra_h", gui.getWidgetValue(XAutoCopilotRoute.fuel_extra_h))
    xac_prefs.set("XAutoCopilotRoute.fuel_extra_m", gui.getWidgetValue(XAutoCopilotRoute.fuel_extra_m))

    xac_prefs.save(filename)
end

function XAutoCopilotRoute_btnStart_OnClick()
    dref.setInt(xac_route_crzflinft, gui.getWidgetValue(XAutoCopilotRoute.crzfl) * 100)

    local steptime = 0.3

    timer.newOneShot("Route_Step1", (steptime * 1))
    timer.newOneShot("Route_Step2", (steptime * 2))
    timer.newOneShot("Route_Step3", (steptime * 3))
    timer.newOneShot("Route_Step4", (steptime * 4))
end


function Route_Step1()
    dref.setInt(xac_click_init, 1) -- go to init page
    dref.setString(xac_scratchpad, string.upper(gui.getWidgetValue(XAutoCopilotRoute.corte))) -- Copy Company Route to scratchpad
    dref.setInt(xac_click_l1, 1) -- click left 1
end

function Route_Step2()
    dref.setString(xac_scratchpad, string.upper(gui.getWidgetValue(XAutoCopilotRoute.fltnbr))) -- Copy Flight Number to scratchpad
    dref.setInt(xac_click_l3, 1) -- click left 3
end

function Route_Step3()
    dref.setString(xac_scratchpad, string.upper(gui.getWidgetValue(XAutoCopilotRoute.coi))) -- Copy Cost Index to scratchpad
    dref.setInt(xac_click_l5, 1) -- click left 5
end

function Route_Step4()
    dref.setString(xac_scratchpad, gui.getWidgetValue(XAutoCopilotRoute.crzfl)) -- Copy Cruise Flightlevel to scratchpad
    dref.setInt(xac_click_l6, 1) -- click left 6
end

function XAutoCopilotRoute_btnFuelStart_OnClick()
    --[[
    Block = FOB in KG*1000, max Block 18.7
    t0/t4 max 852 pro wing
    t1/t3 max 5530 pro wing
    t2 max 5965 center
    t0/t4 --> t1/t3 --> t2
    ]]
    -- Block is changing, we must start 2 loop´s
    timer.newOneShot("Fuelloop1", (0.1))
    timer.newOneShot("Fuelloop2", (3.0))
end

function Fuelloop1()

    local steptime = 0.3

    timer.newOneShot("RouteFuel_Step1", (steptime * 1))
    timer.newOneShot("RouteFuel_Step2", (steptime * 2))
    timer.newOneShot("RouteFuel_Step3", (steptime * 3))
    timer.newOneShot("RouteFuel_Step4", (steptime * 4))
    timer.newOneShot("RouteFuel_Step5", (steptime * 5))
    timer.newOneShot("RouteFuel_Step6", (steptime * 6))
    timer.newOneShot("RouteFuel_Step7", (steptime * 7))
    timer.newOneShot("RouteFuel_Step8", (steptime * 8))
end

function Fuelloop2()

    local steptime = 0.3

    timer.newOneShot("RouteFuel_Step1", (steptime * 1))
    timer.newOneShot("RouteFuel_Step2", (steptime * 2))
    timer.newOneShot("RouteFuel_Step3", (steptime * 3))
    timer.newOneShot("RouteFuel_Step4", (steptime * 4))
    timer.newOneShot("RouteFuel_Step5", (steptime * 5))
    timer.newOneShot("RouteFuel_Step6", (steptime * 6))
    timer.newOneShot("RouteFuel_Step7", (steptime * 7))
    timer.newOneShot("RouteFuel_Step8", (steptime * 8))
end

function RouteFuel_Step1()
    local fuelpage = dref.getString(xac_title_w)

    if string.find(fuelpage, "INIT FUEL PREDICTION") then
        dref.setInt(xac_click_r1, 1) -- ZFWCG / ZFW
    else
        dref.setInt(xac_click_init, 1) -- go to init page
        dref.setInt(xac_click_right, 1) -- second init page
    end
end

function RouteFuel_Step2()
    dref.setInt(xac_click_r1, 1) -- ZFWCG / ZFW
    dref.setInt(xac_click_r2, 1) -- click right 2 BLOCK
end

function RouteFuel_Step3()
    dref.setString(xac_scratchpad, gui.getWidgetValue(XAutoCopilotRoute.fuel_taxi)) -- Copy Taxi Time to scratchpad
    dref.setInt(xac_click_l1, 1) -- click left 1
end

function RouteFuel_Step4()
    dref.setString(xac_scratchpad, "/" .. gui.getWidgetValue(XAutoCopilotRoute.fuel_reserve)) -- Copy Reserve to scratchpad
    dref.setInt(xac_click_l3, 1) -- click left 3
end

function RouteFuel_Step5()
    local final = (gui.getWidgetValue(XAutoCopilotRoute.fuel_final_h) .. "" .. gui.getWidgetValue(XAutoCopilotRoute.fuel_final_m))
    dref.setString(xac_scratchpad, "/" .. final) -- Copy Final Time to scratchpad
    dref.setInt(xac_click_l5, 1) -- click left 5
end

function RouteFuel_Step6()
    local taxi = dref.getFloat(xac_taxi_fuel)
    local trip = dref.getFloat(xac_trip_fuel)
    local reserve = dref.getFloat(xac_rsv_fuel)
    local final = dref.getFloat(xac_final_fuel)
    local extra_h = tonumber(gui.getWidgetValue(XAutoCopilotRoute.fuel_extra_h)) * 60
    local extra_m = tonumber(gui.getWidgetValue(XAutoCopilotRoute.fuel_extra_m))
    local extra = (extra_h + extra_m) * (1 / 30)
    local block = taxi + trip + reserve + final + extra
    XAutoCopilotRoute.block = taxi + trip + reserve + final + extra
end

function RouteFuel_Step7()
    dref.setString(xac_scratchpad, XAutoCopilotRoute.block) -- Copy Block to scratchpad
    dref.setInt(xac_click_r2, 1) -- click right 2
end

function RouteFuel_Step8()
    local block = (XAutoCopilotRoute.block * 1000)

    if block < 1702 then
        local rest0 = block / 2
        dref.setFloat(xac_t0, rest0)
        dref.setFloat(xac_t4, rest0)

        dref.setFloat(xac_t2, 0.0)
    end

    if block > 1702 and block < 12762 then
        dref.setFloat(xac_t0, 852)
        dref.setFloat(xac_t4, 852)

        local rest1 = (block - 1702) / 2
        dref.setFloat(xac_t1, rest1)
        dref.setFloat(xac_t3, rest1)

        dref.setFloat(xac_t2, 0.0)
    end

    if block > 12762 and block < 18700 then
        dref.setFloat(xac_t0, 852)
        dref.setFloat(xac_t4, 852)
        dref.setFloat(xac_t1, 5530)
        dref.setFloat(xac_t3, 5530)

        local rest2 = (block - 12762)
        dref.setFloat(xac_t2, rest2)
    end
end



-- Toolbar Widget definition/Integration. --

ToolXAutoCopilotRoute = {
    active = true,
    texture = gfx.loadPng(acf.getFolder() .. "scripts/xac_lua/icons/Route.png"),
    name = "XAutoCopilotRoute",
    run = function(self)
        if (XAutoCopilotRoute) then
            gui.showWindow(XAutoCopilotRoute.gui_h)
        else
            self.active = false
        end
    end,
}

if (ToolTray) then
    ToolTray:register(ToolXAutoCopilotRoute)
end