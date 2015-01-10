-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 01.07.2014
-- Time: 20:49

-- Approach Briefing: QNH, Temperature, Wind, Transition Alt, Flaps, MDA/DH, Go Around Altitude, Tower Frequency, Ground Frequency

XAutoCopilotBriefingApproach = {
    gui_h = gui.newWindow("XAutoCopilotBriefingApproach"),
    l = 825, --left position on screen
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

    local desctalt = xac_prefs.get("XAutoCopilotBriefingApproach.desctalt", "3000")
    local transition = xac_prefs.get("XAutoCopilotBriefingApproach.transition", "18000")
    local goaround = xac_prefs.get("XAutoCopilotBriefingApproach.goaround", "5000")
    local mda = xac_prefs.get("XAutoCopilotBriefingApproach.mda", "460")
    local dh = xac_prefs.get("XAutoCopilotBriefingApproach.dh", "213")

    local temperature = xac_prefs.get("XAutoCopilotBriefingApproach.temperature", "22")
    local mag = xac_prefs.get("XAutoCopilotBriefingApproach.mag", "300")
    local wind = xac_prefs.get("XAutoCopilotBriefingApproach.wind", "7")
    local tower = xac_prefs.get("XAutoCopilotBriefingApproach.tower", "122.00")
    local station = xac_prefs.get("XAutoCopilotBriefingApproach.station", "122.00")

    -- left side
    XAutoCopilotBriefingApproach.desctalt = gui.newTextBox(XAutoCopilotBriefingApproach.gui_h, "ignored", desctalt, left, top, width)
    XAutoCopilotBriefingApproach.transition = gui.newTextBox(XAutoCopilotBriefingApproach.gui_h, "ignored", transition, left, top + 15, width)
    XAutoCopilotBriefingApproach.goaround = gui.newTextBox(XAutoCopilotBriefingApproach.gui_h, "ignored", goaround, left, top + 30, width)
    XAutoCopilotBriefingApproach.mda = gui.newTextBox(XAutoCopilotBriefingApproach.gui_h, "ignored", mda, left, top + 45, width - 30)
    XAutoCopilotBriefingApproach.dh = gui.newTextBox(XAutoCopilotBriefingApproach.gui_h, "ignored", dh, left + 30, top + 45, width - 30)

    XAutoCopilotBriefingApproach.conf3 = gui.newLabel(XAutoCopilotBriefingApproach.gui_h, "ignored", "CONF3", left + 20, top + 60, width)
    XAutoCopilotBriefingApproach.conf4 = gui.newLabel(XAutoCopilotBriefingApproach.gui_h, "ignored", "FULL", left + 20, top + 60, width)

    XAutoCopilotBriefingApproach.land_conf = gui.newCheckbox(XAutoCopilotBriefingApproach.gui_h, "XAutoCopilotBriefingApproach_chkLandconf", "", left, top + 60, width - 30)

    XAutoCopilotBriefingApproach.qnh_inHg = gui.newTextBox(XAutoCopilotBriefingApproach.gui_h, "ignored", string.sub(dref.getFloat(xac_barometer_sealevel_inhg), 1, 5), left, top + 85, width)
    XAutoCopilotBriefingApproach.temperature = gui.newTextBox(XAutoCopilotBriefingApproach.gui_h, "ignored", temperature, left, top + 100, width)
    XAutoCopilotBriefingApproach.mag = gui.newTextBox(XAutoCopilotBriefingApproach.gui_h, "ignored", mag, left, top + 115, width - 30)
    XAutoCopilotBriefingApproach.wind = gui.newTextBox(XAutoCopilotBriefingApproach.gui_h, "ignored", wind, left + 30, top + 115, width - 30)
    XAutoCopilotBriefingApproach.tower = gui.newTextBox(XAutoCopilotBriefingApproach.gui_h, "ignored", tower, left, top + 130, width)
    XAutoCopilotBriefingApproach.station = gui.newTextBox(XAutoCopilotBriefingApproach.gui_h, "ignored", station, left, top + 145, width)

    gui.newButton(XAutoCopilotBriefingApproach.gui_h, "XAutoCopilotBriefingApproach_btnStart", "Confirmed", left, top + 165, width)

    -- help + save icon
    XAutoCopilotBriefingApproach.helpIcon_h = gui.newCustomWidget(XAutoCopilotBriefingApproach.gui_h, "XAutoCopilotBriefingApproach_helpIcon", XAutoCopilotBriefingApproach.w - 20, 20, 17, 17)
    XAutoCopilotBriefingApproach.diskIcon_h = gui.newCustomWidget(XAutoCopilotBriefingApproach.gui_h, "XAutoCopilotBriefingApproach_diskIcon", XAutoCopilotBriefingApproach.w - 40, 20, 17, 17)

    gui.hideWidget(XAutoCopilotBriefingApproach.catI)
    gui.hideWidget(XAutoCopilotBriefingApproach.catII)
    gui.hideWidget(XAutoCopilotBriefingApproach.conf3)
    gui.hideWidget(XAutoCopilotBriefingApproach.conf4)
end

function XAutoCopilotBriefingApproach_helpIcon_OnDraw()
    --icon
    local icon_file = gfx.loadPng(gizmo.getFolder() .. "firmware/icons/" .. tostring("help.png"))
    gfx.texOn()
    --gfx.setColor(color.white)
    gfx.useTexture(icon_file)
    gfx.drawTexturedQuad(0, 0, 16, 16)
end

function XAutoCopilotBriefingApproach_diskIcon_OnDraw()
    --icon
    local icon_file = gfx.loadPng(gizmo.getFolder() .. "firmware/icons/" .. tostring("disk.png"))
    gfx.texOn()
    --gfx.setColor(color.white)
    gfx.useTexture(icon_file)
    gfx.drawTexturedQuad(0, 0, 16, 16)
end

function XAutoCopilotBriefingApproach_helpIcon_OnMouseDown()
    --message
    --toast.newInfo("Approach Window Info", "This Window is only for testing\nHave a nice day!")
end

function XAutoCopilotBriefingApproach_diskIcon_OnMouseDown()
    local filename = acf.getFolder() .. "scripts/xac_lua/prefs/xac_prefs.txt"

    xac_prefs.set("XAutoCopilotBriefingApproach.desctalt", gui.getWidgetValue(XAutoCopilotBriefingApproach.desctalt))
    xac_prefs.set("XAutoCopilotBriefingApproach.transition", gui.getWidgetValue(XAutoCopilotBriefingApproach.transition))
    xac_prefs.set("XAutoCopilotBriefingApproach.goaround", gui.getWidgetValue(XAutoCopilotBriefingApproach.goaround))
    xac_prefs.set("XAutoCopilotBriefingApproach.mda", gui.getWidgetValue(XAutoCopilotBriefingApproach.mda))
    xac_prefs.set("XAutoCopilotBriefingApproach.dh", gui.getWidgetValue(XAutoCopilotBriefingApproach.dh))
    xac_prefs.set("XAutoCopilotBriefingApproach.temperature", gui.getWidgetValue(XAutoCopilotBriefingApproach.temperature))
    xac_prefs.set("XAutoCopilotBriefingApproach.mag", gui.getWidgetValue(XAutoCopilotBriefingApproach.mag))
    xac_prefs.set("XAutoCopilotBriefingApproach.wind", gui.getWidgetValue(XAutoCopilotBriefingApproach.wind))
    xac_prefs.set("XAutoCopilotBriefingApproach.tower", gui.getWidgetValue(XAutoCopilotBriefingApproach.tower))
    xac_prefs.set("XAutoCopilotBriefingApproach.station", gui.getWidgetValue(XAutoCopilotBriefingApproach.station))

    xac_prefs.save(filename)
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
    dref.setInt(xac_baro_ishpa, 0)
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