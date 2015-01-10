--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 01.07.2014
-- Time: 20:49
-- 


XAutoCopilotBriefingDeparture = {
    gui_h = gui.newWindow("XAutoCopilotBriefingDeparture"),
    l = 560, --left position on screen
    t = 430, --top position on screen
    w = 250, --window width
    h = 190, --window height
    auto_show = false,
}

function XAutoCopilotBriefingDeparture_OnCreate()

    --gui.setWindowSize( gui_window_id, left, top, width, height )
    gui.setWindowSize(XAutoCopilotBriefingDeparture.gui_h, XAutoCopilotBriefingDeparture.l, XAutoCopilotBriefingDeparture.t, XAutoCopilotBriefingDeparture.w, XAutoCopilotBriefingDeparture.h)
    gui.setWindowCaption(XAutoCopilotBriefingDeparture.gui_h, "Departure Briefing")

    local left = 70
    local top = 30
    local width = 50
    -- right side
    gui.newLabel(XAutoCopilotBriefingDeparture.gui_h, "ignored", "Initial Altitude", left, top, width)
    gui.newLabel(XAutoCopilotBriefingDeparture.gui_h, "ignored", "Transition Altitude", left, top + 15, width)
    gui.newLabel(XAutoCopilotBriefingDeparture.gui_h, "ignored", "Flaps", left, top + 30, width)
    gui.newLabel(XAutoCopilotBriefingDeparture.gui_h, "ignored", "Flex temp", left, top + 45, width)

    gui.newLabel(XAutoCopilotBriefingDeparture.gui_h, "ignored", "QNH inHg", left, top + 70, width)
    gui.newLabel(XAutoCopilotBriefingDeparture.gui_h, "ignored", "Squawk Code", left, top + 85, width)
    gui.newLabel(XAutoCopilotBriefingDeparture.gui_h, "ignored", "Tower Frequency", left, top + 100, width)
    gui.newLabel(XAutoCopilotBriefingDeparture.gui_h, "ignored", "Departure Frequency", left, top + 115, width)

    local left = 10
    local top = 30
    local width = 60

    local initalt = xac_prefs.get("XAutoCopilotBriefingDeparture.initalt", "9000")
    local transition = xac_prefs.get("XAutoCopilotBriefingDeparture.transition", "18000")
    local flaps = xac_prefs.get("XAutoCopilotBriefingDeparture.flaps", "2/UP2.0")
    local flex = xac_prefs.get("XAutoCopilotBriefingDeparture.flex", "F50")

    local squawk = xac_prefs.get("XAutoCopilotBriefingDeparture.squawk", "2000")
    local tower = xac_prefs.get("XAutoCopilotBriefingDeparture.tower", "122.00")
    local station = xac_prefs.get("XAutoCopilotBriefingDeparture.station", "122.00")

    -- left side
    XAutoCopilotBriefingDeparture.initalt = gui.newTextBox(XAutoCopilotBriefingDeparture.gui_h, "ignored", initalt, left, top, width)
    XAutoCopilotBriefingDeparture.transition = gui.newTextBox(XAutoCopilotBriefingDeparture.gui_h, "ignored", transition, left, top + 15, width)
    XAutoCopilotBriefingDeparture.flaps = gui.newTextBox(XAutoCopilotBriefingDeparture.gui_h, "ignored", flaps, left, top + 30, width)
    XAutoCopilotBriefingDeparture.flex = gui.newTextBox(XAutoCopilotBriefingDeparture.gui_h, "ignored", flex, left, top + 45, width)

    XAutoCopilotBriefingDeparture.qnh_inHg = gui.newTextBox(XAutoCopilotBriefingDeparture.gui_h, "ignored", string.sub(dref.getFloat(xac_barometer_sealevel_inhg), 1, 5), left, top + 70, width)
    XAutoCopilotBriefingDeparture.squawk = gui.newTextBox(XAutoCopilotBriefingDeparture.gui_h, "ignored", squawk, left, top + 85, width)
    XAutoCopilotBriefingDeparture.tower = gui.newTextBox(XAutoCopilotBriefingDeparture.gui_h, "ignored", tower, left, top + 100, width)
    XAutoCopilotBriefingDeparture.station = gui.newTextBox(XAutoCopilotBriefingDeparture.gui_h, "ignored", station, left, top + 115, width)

    gui.newButton(XAutoCopilotBriefingDeparture.gui_h, "XAutoCopilotBriefingDeparture_btnStart", "Confirmed", left, top + 135, width)

    -- help + save icon
    XAutoCopilotBriefingDeparture.helpIcon_h = gui.newCustomWidget(XAutoCopilotBriefingDeparture.gui_h, "XAutoCopilotBriefingDeparture_helpIcon", XAutoCopilotBriefingDeparture.w - 20, 20, 17, 17)
    XAutoCopilotBriefingDeparture.diskIcon_h = gui.newCustomWidget(XAutoCopilotBriefingDeparture.gui_h, "XAutoCopilotBriefingDeparture_diskIcon", XAutoCopilotBriefingDeparture.w - 40, 20, 17, 17)
end

function XAutoCopilotBriefingDeparture_helpIcon_OnDraw()
    --icon
    local icon_file = gfx.loadPng(gizmo.getFolder() .. "firmware/icons/" .. tostring("help.png"))
    gfx.texOn()
    --gfx.setColor(color.white)
    gfx.useTexture(icon_file)
    gfx.drawTexturedQuad(0, 0, 16, 16)
end

function XAutoCopilotBriefingDeparture_diskIcon_OnDraw()
    --icon
    local icon_file = gfx.loadPng(gizmo.getFolder() .. "firmware/icons/" .. tostring("disk.png"))
    gfx.texOn()
    --gfx.setColor(color.white)
    gfx.useTexture(icon_file)
    gfx.drawTexturedQuad(0, 0, 16, 16)
end

function XAutoCopilotBriefingDeparture_helpIcon_OnMouseDown()
    --message
    --toast.newInfo("Departure Window Info", "This Window is only for testing\nHave a nice day!")
end

function XAutoCopilotBriefingDeparture_diskIcon_OnMouseDown()
    local filename = acf.getFolder() .. "scripts/xac_lua/prefs/xac_prefs.txt"

    xac_prefs.set("XAutoCopilotBriefingDeparture.initalt", gui.getWidgetValue(XAutoCopilotBriefingDeparture.initalt))
    xac_prefs.set("XAutoCopilotBriefingDeparture.transition", gui.getWidgetValue(XAutoCopilotBriefingDeparture.transition))
    xac_prefs.set("XAutoCopilotBriefingDeparture.flaps", gui.getWidgetValue(XAutoCopilotBriefingDeparture.flaps))
    xac_prefs.set("XAutoCopilotBriefingDeparture.flex", gui.getWidgetValue(XAutoCopilotBriefingDeparture.flex))
    xac_prefs.set("XAutoCopilotBriefingDeparture.squawk", gui.getWidgetValue(XAutoCopilotBriefingDeparture.squawk))
    xac_prefs.set("XAutoCopilotBriefingDeparture.tower", gui.getWidgetValue(XAutoCopilotBriefingDeparture.tower))
    xac_prefs.set("XAutoCopilotBriefingDeparture.station", gui.getWidgetValue(XAutoCopilotBriefingDeparture.station))

    xac_prefs.save(filename)
end

function XAutoCopilotBriefingDeparture_btnStart_OnClick()
    --update the value of our dateref
    dref.setInt(xac_departure_transition, tonumber(gui.getWidgetValue(XAutoCopilotBriefingDeparture.transition)))
    dref.setInt(xac_daparture_station, tonumber(gui.getWidgetValue(XAutoCopilotBriefingDeparture.station)) * 100)

    -- All Adjustments done with timers
    local steptime = 0.3

    timer.newOneShot("Departure_Brief_Step1", (steptime * 1))
    timer.newOneShot("Departure_Brief_Step2", (steptime * 2))
    timer.newOneShot("Departure_Brief_Step3", (steptime * 3))
    timer.newOneShot("Departure_Brief_Step4", (steptime * 4))
    timer.newOneShot("Departure_Brief_Step5", (steptime * 5))
    timer.newOneShot("Departure_Brief_Step6", (steptime * 6))
    timer.newOneShot("Departure_Brief_Step7", (steptime * 7))
    timer.newOneShot("Departure_Brief_Step8", (steptime * 8))
    timer.newOneShot("Departure_Brief_Step9", (steptime * 9))
    timer.newOneShot("Departure_Brief_Step10", (steptime * 10))
end

function Departure_Brief_Step1()
    dref.setInt(xac_alt100x, (string.format("%i", gui.getWidgetValue(XAutoCopilotBriefingDeparture.initalt)) / 100)) -- Set Initial Altitude
end

function Departure_Brief_Step2()
    -- http://docs.oracle.com/cd/E19957-01/806-3568/ncg_goldberg.html / choose 30.15 for ind_baro_inhg and look on barometer_setting JAR ?
    dref.setFloat(xac_daparture_qnh_inHg, tonumber(gui.getWidgetValue(XAutoCopilotBriefingDeparture.qnh_inHg))) --back to real float
    dref.setFloat(xac_barometer_setting, (dref.getFloat(xac_daparture_qnh_inHg))) --  set QNH Pilot
    dref.setFloat(xac_barometer_setting2, (dref.getFloat(xac_daparture_qnh_inHg))) --  set QNH CoPilot
    dref.setInt(xac_transponder_code, gui.getWidgetValue(XAutoCopilotBriefingDeparture.squawk)) -- Set Transponder Code
end

function Departure_Brief_Step3()
    dref.setInt(xac_nav_com_adf_mode, 2) -- VHF1 active
    dref.setInt(xac_com1_stdby_freq_hz, gui.getWidgetValue(XAutoCopilotBriefingDeparture.tower) * 100) -- Set Tower Frequency on Standby COM1
end

function Departure_Brief_Step4()
    dref.setInt(xac_click_perf, 1) -- go to performance page
    dref.setString(xac_scratchpad, string.upper(gui.getWidgetValue(XAutoCopilotBriefingDeparture.flaps))) -- Copy Flaps to scratchpad
    dref.setInt(xac_click_r3, 1) -- click right 3
end

function Departure_Brief_Step5()
    dref.setString(xac_scratchpad, string.upper(gui.getWidgetValue(XAutoCopilotBriefingDeparture.flex))) -- Copy Flex temp to scratchpad
    dref.setInt(xac_click_r4, 1) -- click right 4
end

function Departure_Brief_Step6()
    dref.setInt(xac_ap_trans_alt, tonumber(gui.getWidgetValue(XAutoCopilotBriefingDeparture.transition))) -- Copy Transition Altitude to scratchpad
end

function Departure_Brief_Step7()
    dref.setInt(xac_click_l1, 1) -- click V1
end

function Departure_Brief_Step8()
    dref.setInt(xac_click_l2, 1) -- click VR
end

function Departure_Brief_Step9()
    dref.setInt(xac_click_l3, 1) -- click V2
end

function Departure_Brief_Step10()
    dref.setInt(xac_click_init, 1) -- go to init page
    dref.setInt(xac_click_r3, 1) -- press Allign IRS
    sound.say("Departure Briefing Confirmed!")
end


ToolXAutoCopilotBriefingDeparture = {
    active = true,
    texture = gfx.loadPng(acf.getFolder() .. "scripts/xac_lua/icons/Departure.png"),
    name = "XAutoCopilotDeparture",
    run = function(self)
        if (XAutoCopilotBriefingDeparture) then
            gui.showWindow(XAutoCopilotBriefingDeparture.gui_h)
        else
            self.active = false
        end
    end,
}


if (ToolTray) then
    ToolTray:register(ToolXAutoCopilotBriefingDeparture)
end