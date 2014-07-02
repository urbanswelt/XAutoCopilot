-- Copyright
--
-- 02.07.14 19:05			DateInfo	The current date and time.

--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 25.01.14
-- Time: 17:03
-- http://gizmo.x-plugins.com/docs/Gizmo_API.htm / http://lua.gts-stolberg.de/string.php / http://www.torsten-horn.de/techdocs/ascii.htm 
-- http://de.wikipedia.org/wiki/%C3%9Cbergangsh%C3%B6he / http://de.wikipedia.org/wiki/Flugfl%C3%A4che / http://www.pilotundrecht.de/TEXTE/DOWNLOAD/translevneu.pdf
--

XAutoCopilotRoute = {
    gui_h = gui.newWindow("XAutoCopilotRoute"),
    l = 300, --left position on screen
    t = 430, --top position on screen
    w = 250, --window width
    h = 180, --window height
    auto_show = false,
}

function XAutoCopilotRoute_OnCreate()
    local w, h = gfx.getScreenSize()

    --gui.setWindowSize( gui_window_id, left, top, width, height )
    gui.setWindowSize(XAutoCopilotRoute.gui_h, XAutoCopilotRoute.l, XAutoCopilotRoute.t, XAutoCopilotRoute.w, XAutoCopilotRoute.h)
    gui.setWindowCaption(XAutoCopilotRoute.gui_h, "Route")

    local xac_left = 10
    local xac_top = 30
    local xac_width = 100

    gui.newLabel(XAutoCopilotRoute.gui_h, "ignored", "Company Route", xac_left + 100, xac_top, xac_width - 50)
    gui.newLabel(XAutoCopilotRoute.gui_h, "ignored", "Flight Number", xac_left + 100, xac_top + 15, xac_width - 50)
    gui.newLabel(XAutoCopilotRoute.gui_h, "ignored", "Cost Index", xac_left + 100, xac_top + 30, xac_width - 50)
    gui.newLabel(XAutoCopilotRoute.gui_h, "ignored", "Cruise Flightlevel", xac_left + 100, xac_top + 45, xac_width - 50)

    xac_corte = gui.newTextBox(XAutoCopilotRoute.gui_h, "ignored", "KMMHKSFO", xac_left, xac_top, xac_width)
    xac_fltnbr = gui.newTextBox(XAutoCopilotRoute.gui_h, "ignored", "KOM123", xac_left, xac_top + 15, xac_width)
    xac_coi = gui.newTextBox(XAutoCopilotRoute.gui_h, "ignored", "99", xac_left, xac_top + 30, xac_width)
    xac_crzfl = gui.newTextBox(XAutoCopilotRoute.gui_h, "ignored", "200", xac_left, xac_top + 45, xac_width)

    gui.newButton(XAutoCopilotRoute.gui_h, "XAutoCopilotRoute_btnStart", "Start", xac_left, xac_top + 125, xac_width - 50)


--[[Init FUEL PREDICTION
-extra / time
- TAXI Time 0.2
- Route Reserve in % with /5.0
- Final / Time
- sim/cockpit2/fuel_quantity
- Extra / Time (for reading)]]

end


function XAutoCopilotRoute_btnStart_OnClick()
    tmp_xac_corte = string.upper(gui.getWidgetValue(xac_corte))
    tmp_xac_fltnbr = string.upper(gui.getWidgetValue(xac_fltnbr))
    tmp_xac_coi = string.upper(gui.getWidgetValue(xac_coi))
    tmp_xac_crzfl = string.upper(gui.getWidgetValue(xac_crzfl))

    local steptime = 0.3

    timer.newOneShot("Route_Step1", (steptime * 1))
    timer.newOneShot("Route_Step2", (steptime * 2))
    timer.newOneShot("Route_Step3", (steptime * 3))
    timer.newOneShot("Route_Step4", (steptime * 4))
    timer.newOneShot("Route_Step5", (steptime * 5))
    timer.newOneShot("Route_Step6", (steptime * 6))
    timer.newOneShot("Route_Step7", (steptime * 7))
    timer.newOneShot("Route_Step8", (steptime * 8))
    timer.newOneShot("Route_Step9", (steptime * 9))
    timer.newOneShot("Route_Step10", (steptime * 10))
end


function Route_Step1()
    dref.setInt(xac_click_init, 1) -- go to init page
    dref.setString(xac_scratchpad, tmp_xac_corte) -- Copy Company Route to scratchpad
    dref.setInt(xac_click_l1, 1) -- click left 1
end

function Route_Step2()
    dref.setString(xac_scratchpad, tmp_xac_fltnbr) -- Copy Flight Number to scratchpad
    dref.setInt(xac_click_l3, 1) -- click left 3
end

function Route_Step3()
    dref.setString(xac_scratchpad, tmp_xac_coi) -- Copy Cost Index to scratchpad
    dref.setInt(xac_click_l5, 1) -- click left 5
end

function Route_Step4()
    dref.setString(xac_scratchpad, tmp_xac_crzfl) -- Copy Cruise Flightlevel to scratchpad
    dref.setInt(xac_click_l6, 1) -- click left 6
end

function Route_Step5()
    dref.setInt(xac_click_right, 1) -- second init page
end

function Route_Step6()
    dref.setInt(xac_click_r1, 1) -- ZFWCG / ZFW
    dref.setInt(xac_click_r2, 1) -- BLOCK
end

function Route_Step7()
    dref.setInt(xac_click_perf, 1) -- go to performance page
    dref.setInt(xac_click_l1, 1) -- click V1
end

function Route_Step8()
    dref.setInt(xac_click_perf, 1) -- go to performance page
    dref.setInt(xac_click_l2, 1) -- click VR
end

function Route_Step9()
    dref.setInt(xac_click_l3, 1) -- click V2
end

function Route_Step10()
    dref.setInt(xac_click_init, 1) -- go to init page
    sound.say("Route is Set!")
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