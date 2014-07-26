-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 01.07.2014
-- Time: 20:49

-- Approach Briefing: QNH, Temperature, Wind, Transition Alt, Flaps, MDA/DH, Go Around Altitude, Tower Frequency, Ground Frequency

XAutoCopilotBriefingApproach = {
    gui_h = gui.newWindow("XAutoCopilotBriefingApproach"),
    l = 560, --left position on screen
    t = 430, --top position on screen
    w = 250, --window width
    h = 220, --window height
    auto_show = false,
}

function XAutoCopilotBriefingApproach_OnCreate()

    --gui.setWindowSize( gui_window_id, left, top, width, height )
    gui.setWindowSize(XAutoCopilotBriefingApproach.gui_h, XAutoCopilotBriefingApproach.l, XAutoCopilotBriefingApproach.t, XAutoCopilotBriefingApproach.w, XAutoCopilotBriefingApproach.h)
    gui.setWindowCaption(XAutoCopilotBriefingApproach.gui_h, "Approach Briefing")

    local left = 70
    local top = 30
    local width = 50
    -- right side
    gui.newLabel(XAutoCopilotBriefingApproach.gui_h, "ignored", "Descent Altitude", left, top, width)
    gui.newLabel(XAutoCopilotBriefingApproach.gui_h, "ignored", "Transition Altitude", left, top + 15, width)
    gui.newLabel(XAutoCopilotBriefingApproach.gui_h, "ignored", "GoAround Altitude", left, top + 30, width)
    gui.newLabel(XAutoCopilotBriefingApproach.gui_h, "ignored", "MDA/DH", left, top + 45, width)
    gui.newLabel(XAutoCopilotBriefingApproach.gui_h, "ignored", "Flap Landing config", left, top + 60, width)

    XAutoCopilotBriefingApproach.catI = gui.newLabel(XAutoCopilotBriefingApproach.gui_h, "ignored", "CAT I", left + 70, top + 45, width)
    XAutoCopilotBriefingApproach.catII = gui.newLabel(XAutoCopilotBriefingApproach.gui_h, "ignored", "CAT II / III", left + 70, top + 45, width)
    XAutoCopilotBriefingApproach.catx = gui.newLabel(XAutoCopilotBriefingApproach.gui_h, "ignored", "...choose", left + 70, top + 45, width)
    XAutoCopilotBriefingApproach.cat = gui.newCheckbox(XAutoCopilotBriefingApproach.gui_h, "XAutoCopilotBriefingApproach_chkCat", "", left + 50, top + 45, width - 30)

    gui.newLabel(XAutoCopilotBriefingApproach.gui_h, "ignored", "QNH inHg", left, top + 85, width)
    gui.newLabel(XAutoCopilotBriefingApproach.gui_h, "ignored", "Temperature in °C", left, top + 100, width)
    gui.newLabel(XAutoCopilotBriefingApproach.gui_h, "ignored", "Mag/Wind", left, top + 115, width)
    gui.newLabel(XAutoCopilotBriefingApproach.gui_h, "ignored", "Tower Frequency", left, top + 130, width)
    gui.newLabel(XAutoCopilotBriefingApproach.gui_h, "ignored", "Ground Frequency", left, top + 145, width)

    local left = 10
    local top = 30
    local width = 60

    -- left side
    XAutoCopilotBriefingApproach.desctalt = gui.newTextBox(XAutoCopilotBriefingApproach.gui_h, "ignored", "3000", left, top, width)
    XAutoCopilotBriefingApproach.transition = gui.newTextBox(XAutoCopilotBriefingApproach.gui_h, "ignored", "18000", left, top + 15, width)
    XAutoCopilotBriefingApproach.goaround = gui.newTextBox(XAutoCopilotBriefingApproach.gui_h, "ignored", "5000", left, top + 30, width)
    XAutoCopilotBriefingApproach.mda = gui.newTextBox(XAutoCopilotBriefingApproach.gui_h, "ignored", "460", left, top + 45, width - 30)
    XAutoCopilotBriefingApproach.dh = gui.newTextBox(XAutoCopilotBriefingApproach.gui_h, "ignored", "213", left + 30, top + 45, width - 30)

    XAutoCopilotBriefingApproach.conf3 = gui.newLabel(XAutoCopilotBriefingApproach.gui_h, "ignored", "CONF3", left + 20, top + 60, width)
    XAutoCopilotBriefingApproach.conf4 = gui.newLabel(XAutoCopilotBriefingApproach.gui_h, "ignored", "FULL", left + 20, top + 60, width)

    XAutoCopilotBriefingApproach.land_conf = gui.newCheckbox(XAutoCopilotBriefingApproach.gui_h, "XAutoCopilotBriefingApproach_chkLandconf", "", left, top + 60, width - 30)

    XAutoCopilotBriefingApproach.qnh_inHg = gui.newTextBox(XAutoCopilotBriefingApproach.gui_h, "ignored", string.sub(dref.getFloat(xac_barometer_sealevel_inhg), 1, 5), left, top + 85, width)
    XAutoCopilotBriefingApproach.temperature = gui.newTextBox(XAutoCopilotBriefingApproach.gui_h, "ignored", "22", left, top + 100, width)
    XAutoCopilotBriefingApproach.mag = gui.newTextBox(XAutoCopilotBriefingApproach.gui_h, "ignored", "300", left, top + 115, width - 30)
    XAutoCopilotBriefingApproach.wind = gui.newTextBox(XAutoCopilotBriefingApproach.gui_h, "ignored", "7", left + 30, top + 115, width - 30)
    XAutoCopilotBriefingApproach.tower = gui.newTextBox(XAutoCopilotBriefingApproach.gui_h, "ignored", "122.00", left, top + 130, width)
    XAutoCopilotBriefingApproach.station = gui.newTextBox(XAutoCopilotBriefingApproach.gui_h, "ignored", "122.00", left, top + 145, width)

    gui.newButton(XAutoCopilotBriefingApproach.gui_h, "XAutoCopilotBriefingApproach_btnStart", "Confirmed", left, top + 165, width)

    gui.hideWidget(XAutoCopilotBriefingApproach.catI)
    gui.hideWidget(XAutoCopilotBriefingApproach.catII)
    gui.hideWidget(XAutoCopilotBriefingApproach.conf3)
    gui.hideWidget(XAutoCopilotBriefingApproach.conf4)
end

function XAutoCopilotBriefingApproach_chkCat_OnClick()

    local cat = gui.getWidgetValue(XAutoCopilotBriefingApproach.cat)
    if cat then
        --checked CAT II / III
        dref.setInt(xac_approach_catII_III, 1)
        gui.hideWidget(XAutoCopilotBriefingApproach.catI)
        gui.hideWidget(XAutoCopilotBriefingApproach.catx)
        gui.showWidget(XAutoCopilotBriefingApproach.catII)
    else
        --unchecked CAT I
        dref.setInt(xac_approach_catII_III, 0)
        gui.hideWidget(XAutoCopilotBriefingApproach.catII)
        gui.showWidget(XAutoCopilotBriefingApproach.catI)
        gui.hideWidget(XAutoCopilotBriefingApproach.catx)
    end
end

function XAutoCopilotBriefingApproach_chkLandconf_OnClick()

    local land_conf = gui.getWidgetValue(XAutoCopilotBriefingApproach.land_conf)
    if land_conf then
        --checked Full
        dref.setInt(xac_land_conf, 4)
        gui.hideWidget(XAutoCopilotBriefingApproach.conf3)
        gui.showWidget(XAutoCopilotBriefingApproach.conf4)
    else
        --unchecked Conf3
        dref.setInt(xac_land_conf, 3)
        gui.hideWidget(XAutoCopilotBriefingApproach.conf4)
        gui.showWidget(XAutoCopilotBriefingApproach.conf3)
    end
end


function XAutoCopilotBriefingApproach_btnStart_OnClick()
    dref.setInt(xac_click_perf, 1)
    dref.setInt(xac_alt100x, (string.format("%i", gui.getWidgetValue(XAutoCopilotBriefingApproach.desctalt)) / 100)) -- Set Descent Altitude
    --update the value of our dateref
    dref.setInt(xac_approach_transition, tonumber(gui.getWidgetValue(XAutoCopilotBriefingApproach.transition)))
    dref.setInt(xac_approach_goaround, tonumber(gui.getWidgetValue(XAutoCopilotBriefingApproach.goaround)))
    dref.setFloat(xac_approach_qnh_inHg, tonumber(gui.getWidgetValue(XAutoCopilotBriefingApproach.qnh_inHg)))


    local tmr_pagesearch = timer.newTimer("search_approach_page", 0.5)


    function search_approach_page()
        local page = dref.getString(xac_page_now)
        local steptime = 0.3

        if string.find(page, "perf_appr") then
            timer.newOneShot("Approach_Brief_Step1", (steptime * 1))
            timer.newOneShot("Approach_Brief_Step2", (steptime * 2))
            timer.newOneShot("Approach_Brief_Step3", (steptime * 3))
            timer.newOneShot("Approach_Brief_Step4", (steptime * 4))
            timer.newOneShot("Approach_Brief_Step5", (steptime * 5))
            timer.newOneShot("Approach_Brief_Step6", (steptime * 6))
            timer.newOneShot("Approach_Brief_Step7", (steptime * 7))
            timer.destroy(tmr_pagesearch)
        else
            dref.setInt(xac_click_r6, 1)
        end
    end
end

function Approach_Brief_Step1()
    dref.setString(xac_scratchpad, gui.getWidgetValue(XAutoCopilotBriefingApproach.qnh_inHg))
    dref.setInt(xac_click_l1, 1) -- click left 1
end

function Approach_Brief_Step2()
    dref.setString(xac_scratchpad, string.upper(gui.getWidgetValue(XAutoCopilotBriefingApproach.temperature)))
    dref.setInt(xac_click_l2, 1) -- click left 2
end

function Approach_Brief_Step3()
    -- http://www.wikihow.com/Read-an-Aviation-Routine-Weather-Report-(METAR)
    dref.setString(xac_scratchpad, (gui.getWidgetValue(XAutoCopilotBriefingApproach.mag) .. "/" .. gui.getWidgetValue(XAutoCopilotBriefingApproach.wind)))
    dref.setInt(xac_click_l3, 1) -- click left 3
end

function Approach_Brief_Step4()
    dref.setInt(xac_ap_trans_alt_star, tonumber(gui.getWidgetValue(XAutoCopilotBriefingApproach.transition)))
end

function Approach_Brief_Step5()
    if dref.getInt(xac_approach_catII_III) == 0 then
        dref.setString(xac_scratchpad, gui.getWidgetValue(XAutoCopilotBriefingApproach.mda))
        dref.setInt(xac_click_r2, 1) -- click right 2
    end
end

function Approach_Brief_Step6()
    if dref.getInt(xac_approach_catII_III) == 1 then
        dref.setString(xac_scratchpad, gui.getWidgetValue(XAutoCopilotBriefingApproach.dh))
        dref.setInt(xac_click_r3, 1) -- click right 3
    end
end

function Approach_Brief_Step7()
    sound.say("Approach Briefing Confirmed!")
end


ToolXAutoCopilotBriefingApproach = {
    active = true,
    texture = gfx.loadPng(acf.getFolder() .. "scripts/xac_lua/icons/Approach.png"),
    name = "XAutoCopilotApproach",
    run = function(self)
        if (XAutoCopilotBriefingApproach) then
            gui.showWindow(XAutoCopilotBriefingApproach.gui_h)
        else
            self.active = false
        end
    end,
}


if (ToolTray) then
    ToolTray:register(ToolXAutoCopilotBriefingApproach)
end