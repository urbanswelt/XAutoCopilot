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
    h = 180, --window height
    auto_show = false,
}



function XAutoCopilotBriefingDeparture_OnCreate()
    local w, h = gfx.getScreenSize()

    --gui.setWindowSize( gui_window_id, left, top, width, height )
    gui.setWindowSize(XAutoCopilotBriefingDeparture.gui_h, XAutoCopilotBriefingDeparture.l, XAutoCopilotBriefingDeparture.t, XAutoCopilotBriefingDeparture.w, XAutoCopilotBriefingDeparture.h)
    gui.setWindowCaption(XAutoCopilotBriefingDeparture.gui_h, "Departure Briefing")

    local xac_left = 10
    local xac_top = 30
    local xac_width = 100

    gui.newLabel(XAutoCopilotBriefingDeparture.gui_h, "ignored", "Initial Altitude", xac_left + 100, xac_top, xac_width - 50)
    gui.newLabel(XAutoCopilotBriefingDeparture.gui_h, "ignored", "QNH", xac_left + 100, xac_top + 15, xac_width - 50)
    gui.newLabel(XAutoCopilotBriefingDeparture.gui_h, "ignored", "Tower Frequency", xac_left + 100, xac_top + 30, xac_width - 50)
    gui.newLabel(XAutoCopilotBriefingDeparture.gui_h, "ignored", "Departure Frequency", xac_left + 100, xac_top + 45, xac_width - 50)
    gui.newLabel(XAutoCopilotBriefingDeparture.gui_h, "ignored", "Squawk Code", xac_left + 100, xac_top + 60, xac_width - 50)
    gui.newLabel(XAutoCopilotBriefingDeparture.gui_h, "ignored", "Transition Altitude", xac_left + 100, xac_top + 75, xac_width - 50)
    gui.newLabel(XAutoCopilotBriefingDeparture.gui_h, "ignored", "Flaps", xac_left + 100, xac_top + 90, xac_width - 50)
    gui.newLabel(XAutoCopilotBriefingDeparture.gui_h, "ignored", "Flex temp", xac_left + 100, xac_top + 105, xac_width - 50)

    xac_initalt = gui.newTextBox(XAutoCopilotBriefingDeparture.gui_h, "ignored", "5000", xac_left, xac_top, xac_width)
    xac_qnh = gui.newTextBox(XAutoCopilotBriefingDeparture.gui_h, "ignored", string.format("%0.2f", dref.getFloat(xac_barometer_sealevel_inhg)), xac_left, xac_top + 15, xac_width)
    xac_deptower = gui.newTextBox(XAutoCopilotBriefingDeparture.gui_h, "ignored", "122.00", xac_left, xac_top + 30, xac_width)
    xac_depstation = gui.newTextBox(XAutoCopilotBriefingDeparture.gui_h, "ignored", "122.00", xac_left, xac_top + 45, xac_width)
    xac_squawk = gui.newTextBox(XAutoCopilotBriefingDeparture.gui_h, "ignored", "2000", xac_left, xac_top + 60, xac_width)
    xac_trans_dep = gui.newTextBox(XAutoCopilotBriefingDeparture.gui_h, "ignored", "5000", xac_left, xac_top + 75, xac_width)
    xac_flaps = gui.newTextBox(XAutoCopilotBriefingDeparture.gui_h, "ignored", "2/UP2.0", xac_left, xac_top + 90, xac_width)
    xac_flex_temp = gui.newTextBox(XAutoCopilotBriefingDeparture.gui_h, "ignored", "F50", xac_left, xac_top + 105, xac_width)

    gui.newButton(XAutoCopilotBriefingDeparture.gui_h, "XAutoCopilotBriefingDeparture_btnStart", "Confirmed", xac_left, xac_top + 125, xac_width - 30)
end

function XAutoCopilotBriefingDeparture_btnStart_OnClick()

    tmp_xac_initalt = string.format("%i", gui.getWidgetValue(xac_initalt)) -- Initial Altitude
    tmp_depstation = gui.getWidgetValue(xac_depstation) * 100 -- Save Departure Frequency
    tmp_xac_trans_dep = tonumber(gui.getWidgetValue(xac_trans_dep)) -- Transition Altitude for Departure
    --tmp_xac_trans_dep = string.upper(gui.getWidgetValue(xac_trans_dep)) -- Transition Altitude for Departure
    tmp_xac_flaps = string.upper(gui.getWidgetValue(xac_flaps)) -- Flaps Setting
    tmp_xac_flex_temp = string.upper(gui.getWidgetValue(xac_flex_temp)) -- Flex Temperature Setting

    -- All Adjustments done with timers
    local steptime = 0.3

    timer.newOneShot("Departure_Brief_Step1", (steptime * 1))
    timer.newOneShot("Departure_Brief_Step2", (steptime * 2))
    timer.newOneShot("Departure_Brief_Step3", (steptime * 3))
    timer.newOneShot("Departure_Brief_Step4", (steptime * 4))
    timer.newOneShot("Departure_Brief_Step5", (steptime * 5))
    timer.newOneShot("Departure_Brief_Step6", (steptime * 6))
    timer.newOneShot("Departure_Brief_Step7", (steptime * 7))
end

function Departure_Brief_Step1()
    dref.setInt(xac_alt100x, (tmp_xac_initalt / 100)) -- Set Initial Altitude
end

function Departure_Brief_Step2()
    dref.setFloat(xac_barometer_setting, gui.getWidgetValue(xac_qnh)) --  set QNH Pilot  / jar use a round/ceil formating ?
    dref.setFloat(xac_barometer_setting2, gui.getWidgetValue(xac_qnh)) --  set QNH CoPilot
    dref.setInt(xac_transponder_code, gui.getWidgetValue(xac_squawk)) -- Set Transponder Code
end

function Departure_Brief_Step3()
    dref.setInt(xac_nav_com_adf_mode, 2) -- VHF1 active
    dref.setInt(xac_com1_stdby_freq_hz, gui.getWidgetValue(xac_deptower) * 100) -- Set Tower Frequency on Standby COM1
end

function Departure_Brief_Step4()
    dref.setInt(xac_click_perf, 1) -- go to performance page
    dref.setString(xac_scratchpad, tmp_xac_flaps) -- Copy Flaps to scratchpad
    dref.setInt(xac_click_r3, 1) -- click right 3
end

function Departure_Brief_Step5()
    dref.setString(xac_scratchpad, tmp_xac_flex_temp) -- Copy Flex trmp to scratchpad
    dref.setInt(xac_click_r4, 1) -- click right 4
end

function Departure_Brief_Step6()
    dref.setString(xac_scratchpad, tmp_xac_trans_dep) -- Copy Transition Altitude to scratchpad
    dref.setInt(xac_click_l4, 1) -- click left 4
end

function Departure_Brief_Step7()
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