--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 23.01.14
-- Time: 19:41
--



XAutoCopilot = {
    gui_h = gui.newWindow("XAutoCopilot"),
    l = 10, --left position on screen
    t = 430, --top position on screen
    w = 250, --window width
    h = 180, --window height
    auto_show = false,
}

function XAutoCopilot_OnCreate()
    local w, h = gfx.getScreenSize()

    gui.setWindowSize(XAutoCopilot.gui_h, XAutoCopilot.l, XAutoCopilot.t, XAutoCopilot.w, XAutoCopilot.h)
    gui.setWindowCaption(XAutoCopilot.gui_h, "X-Plane Auto Copilot")

    local left = 80
    local top = 30
    local width = 50

-- right side
    xac_widprep1 = gui.newLabel(XAutoCopilot.gui_h, "ignored", "COCKPIT PREPARATION", left, top, width)
    xac_widstart1 = gui.newLabel(XAutoCopilot.gui_h, "ignored", "START", left, top + 15, width)
    xac_widtaxi1 = gui.newLabel(XAutoCopilot.gui_h, "ignored", "TAXI", left, top + 30, width)
    xac_widhold1 = gui.newLabel(XAutoCopilot.gui_h, "ignored", "AT HOLDING POINT", left, top + 45, width)
    xac_widline1 = gui.newLabel(XAutoCopilot.gui_h, "ignored", "LINED UP", left , top + 60, width)
    xac_widtcc1 = gui.newLabel(XAutoCopilot.gui_h, "ignored", "TAKE OFF/CLIMB/CRUISE", left, top + 75, width)
    xac_widdal1 = gui.newLabel(XAutoCopilot.gui_h, "ignored", "DESCENT/APPROACH/LANDING", left, top + 90, width)


    local left = 10
    local xac_top = 30
    local width = 60
-- left side
    xac_widprep2 = gui.newButton(XAutoCopilot.gui_h, "XAutoCopilot_btnPreparation", "execute", left, xac_top, width)
    xac_widstart2 = gui.newButton(XAutoCopilot.gui_h, "XAutoCopilot_btnStart", "execute", left, xac_top + 15, width)
    xac_widtaxi2 = gui.newButton(XAutoCopilot.gui_h, "XAutoCopilot_btnTaxi", "execute", left, xac_top + 30, width)
    xac_widhold2 = gui.newButton(XAutoCopilot.gui_h, "XAutoCopilot_btnAtHoldingPoint", "execute", left, xac_top + 45, width)
    xac_widline2 = gui.newButton(XAutoCopilot.gui_h, "XAutoCopilot_btnLinedUp", "execute", left, xac_top + 60, width)
    xac_widtcc2 = gui.newButton(XAutoCopilot.gui_h, "XAutoCopilot_btnTakeOff", "execute", left, xac_top + 75, width)
    xac_widdal2 = gui.newButton(XAutoCopilot.gui_h, "XAutoCopilot_btnLanding", "execute", left, xac_top + 90, width)

    XAutoCopilot_btnPreparation_State2 = 1
    XAutoCopilot_btnStart_State2 = 1
    XAutoCopilot_btnTaxi_State2 = 1
    XAutoCopilot_btnAtHoldingPoint_State2 = 1
    XAutoCopilot_btnLinedUp_State2 = 1
    XAutoCopilot_btnTakeOff_State2 = 1
    XAutoCopilot_btnLanding_State2 = 1
end

function XAutoCopilot_btnPreparation_OnClick()
    gui.hideWidget(xac_widprep2)
    prepstate1 = 0
    prepstate2 = 0
    prepstate3 = 0
    prepstate4 = 0
    prepstate5 = 0
    preparation_finish = 0
    XAutoCopilot_btnPreparation_State = 1
end

function XAutoCopilot_btnStart_OnClick()
    if XAutoCopilot_btnPreparation_State2 == 1 then
        return
    else
        gui.hideWidget(xac_widstart2)
        beforestartstate1 = 0
        beforestart_finish = 0
        enginestartstate1 = 0
        enginestartstate2 = 0
        enginestart_finish = 0
        afterenginestartstate1 = 0
        afterenginestartstate2 = 0
        afterenginestart_finish = 0
        XAutoCopilot_btnStart_State = 1
    end
end

function XAutoCopilot_btnTaxi_OnClick()
    if XAutoCopilot_btnStart_State2 == 1 then
        return
    else
        gui.hideWidget(xac_widtaxi2)
        taxi_finish = 0
        XAutoCopilot_btnTaxi_State = 1
    end
end

function XAutoCopilot_btnAtHoldingPoint_OnClick()
    if XAutoCopilot_btnTaxi_State2 == 1 then
        return
    else
        gui.hideWidget(xac_widhold2)
        atholdingpoint_finish = 0
        XAutoCopilot_btnAtHoldingPoint_State = 1
    end
end

function XAutoCopilot_btnLinedUp_OnClick()
    if XAutoCopilot_btnAtHoldingPoint_State2 == 1 then
        return
    else
        gui.hideWidget(xac_widline2)
        linedup_finish = 0
        XAutoCopilot_btnLinedUp_State = 1
    end
end

function XAutoCopilot_btnTakeOff_OnClick()
    if XAutoCopilot_btnLinedUp_State2 == 1 then
        return
    else
        gui.hideWidget(xac_widtcc2)
        xac_deptranspoint = tmp_xac_trans_dep
        xac_flight_begin = 1
        takeoff_finish = 0
        aftertakeoff_finish = 0
        climbstate1 = 0
        climbstate2 = 0
        climbstate3 = 0
        climb_finish = 0
        XAutoCopilot_btnTakeOff_State = 1
    end
end

function XAutoCopilot_btnLanding_OnClick()
    if XAutoCopilot_btnTakeOff_State2 == 1 then
        return
    else
        gui.hideWidget(xac_widdal2)
        landingstate1 = 0
        landing_finish = 0
        XAutoCopilot_btnLanding_State = 1
    end
end


-- Toolbar Widget definition/Integration. --

ToolXAutoCopilot = {
    active = true,
    texture = gfx.loadPng(acf.getFolder() .. "scripts/xac_lua/icons/CoPilot.png"),
    name = "XAutoCopilot",
    run = function(self)
        if (XAutoCopilot) then
            gui.showWindow(XAutoCopilot.gui_h)
        else
            self.active = false
        end
    end,
}


if (ToolTray) then
    ToolTray:register(ToolXAutoCopilot)
end


