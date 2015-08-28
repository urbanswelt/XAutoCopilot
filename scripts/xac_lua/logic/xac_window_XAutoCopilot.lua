--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 23.01.14
-- Time: 19:41

XAutoCopilot = {
    gui_h = gui.newWindow("XAutoCopilot"),
    l = 1, --left position on screen
    t = 20, --top position on screen
    w = 250, --window width
    h = 70, --window height
    auto_show = false,
}

function XAutoCopilot_OnCreate()
    gui.setWindowSize(XAutoCopilot.gui_h, XAutoCopilot.l, XAutoCopilot.t, XAutoCopilot.w, XAutoCopilot.h)
    gui.setWindowCaption(XAutoCopilot.gui_h, "X-Plane Auto Copilot")

    local left = 80
    local top = 30
    local width = 50

    -- right side
    XAutoCopilot.preparation = gui.newLabel(XAutoCopilot.gui_h, "ignored", "COCKPIT PREPARATION", left, top, width)
    XAutoCopilot.beforestart = gui.newLabel(XAutoCopilot.gui_h, "ignored", "BEFORE START", left, top, width)
    XAutoCopilot.start = gui.newLabel(XAutoCopilot.gui_h, "ignored", "START", left, top, width)
    XAutoCopilot.afterstart = gui.newLabel(XAutoCopilot.gui_h, "ignored", "AFTER START", left, top, width)
    XAutoCopilot.taxi = gui.newLabel(XAutoCopilot.gui_h, "ignored", "TAXI", left, top, width)
    XAutoCopilot.atholdingpoint = gui.newLabel(XAutoCopilot.gui_h, "ignored", "AT HOLDING POINT", left, top, width)
    XAutoCopilot.linedup = gui.newLabel(XAutoCopilot.gui_h, "ignored", "LINED UP", left, top, width)
    XAutoCopilot.takeoff = gui.newLabel(XAutoCopilot.gui_h, "ignored", "TAKE OFF/CLIMB/CRUISE", left, top, width)
    XAutoCopilot.descent = gui.newLabel(XAutoCopilot.gui_h, "ignored", "DESCENT/APPROACH/LANDING", left, top, width)

    local left = 80
    local top = 45
    local width = 10

    XAutoCopilot.stair = gui.newLabel(XAutoCopilot.gui_h, "ignored", "WITH STAIR", left, top, width)
    XAutoCopilot.pushback = gui.newLabel(XAutoCopilot.gui_h, "ignored", "WITH PUSHBACK", left, top, width)
    XAutoCopilot.fm = gui.newLabel(XAutoCopilot.gui_h, "ignored", "WITH FM CAR", left, top, width)

    gui.hideWidget(XAutoCopilot.beforestart)
    gui.hideWidget(XAutoCopilot.start)
    gui.hideWidget(XAutoCopilot.afterstart)
    gui.hideWidget(XAutoCopilot.taxi)
    gui.hideWidget(XAutoCopilot.atholdingpoint)
    gui.hideWidget(XAutoCopilot.linedup)
    gui.hideWidget(XAutoCopilot.takeoff)
    gui.hideWidget(XAutoCopilot.descent)
    gui.hideWidget(XAutoCopilot.pushback)
    gui.hideWidget(XAutoCopilot.fm)

    local left = 10
    local top = 30
    local width = 60
    -- left side
    XAutoCopilot.btnpreparation = gui.newButton(XAutoCopilot.gui_h, "XAutoCopilot_btnPreparation", "execute", left, top, width)
    XAutoCopilot.btnbeforestart = gui.newButton(XAutoCopilot.gui_h, "XAutoCopilot_btnbeforeStart", "execute", left, top, width)
    XAutoCopilot.btnstart = gui.newButton(XAutoCopilot.gui_h, "XAutoCopilot_btnStart", "execute", left, top, width)
    XAutoCopilot.btnafterstart = gui.newButton(XAutoCopilot.gui_h, "XAutoCopilot_btnafterStart", "execute", left, top, width)
    XAutoCopilot.btntaxi = gui.newButton(XAutoCopilot.gui_h, "XAutoCopilot_btnTaxi", "execute", left, top, width)
    XAutoCopilot.btnatholdingpoint = gui.newButton(XAutoCopilot.gui_h, "XAutoCopilot_btnAtHoldingPoint", "execute", left, top, width)
    XAutoCopilot.btnlinedup = gui.newButton(XAutoCopilot.gui_h, "XAutoCopilot_btnLinedUp", "execute", left, top, width)
    XAutoCopilot.btntakeoff = gui.newButton(XAutoCopilot.gui_h, "XAutoCopilot_btnTakeOff", "execute", left, top, width)
    XAutoCopilot.btndescent = gui.newButton(XAutoCopilot.gui_h, "XAutoCopilot_btnDescent", "execute", left, top, width)

    local left = 10
    local top = 45
    local width = 10

    XAutoCopilot.chkStair = gui.newCheckbox(XAutoCopilot.gui_h, "XAutoCopilot_chkStair", "", left, top, width)
    XAutoCopilot.chkPushback = gui.newCheckbox(XAutoCopilot.gui_h, "XAutoCopilot_chkPushback", "", left, top, width)
    XAutoCopilot.chkFM = gui.newCheckbox(XAutoCopilot.gui_h, "XAutoCopilot_chkFM", "", left, top, width)

    gui.hideWidget(XAutoCopilot.btnbeforestart)
    gui.hideWidget(XAutoCopilot.btnstart)
    gui.hideWidget(XAutoCopilot.btnafterstart)
    gui.hideWidget(XAutoCopilot.btntaxi)
    gui.hideWidget(XAutoCopilot.btnatholdingpoint)
    gui.hideWidget(XAutoCopilot.btnlinedup)
    gui.hideWidget(XAutoCopilot.btntakeoff)
    gui.hideWidget(XAutoCopilot.btndescent)
    gui.hideWidget(XAutoCopilot.chkPushback)
    gui.hideWidget(XAutoCopilot.chkFM)
end



function XAutoCopilot_btnPreparation_OnClick()
    gui.hideWindow(XAutoCopilot.gui_h)
    gui.hideWidget(XAutoCopilot.btnpreparation)
    gui.hideWidget(XAutoCopilot.chkStair)
    gui.hideWidget(XAutoCopilot.stair)
    dref.setIntV(xac_state_preparation, 1, 1) --SAFETY EXTERIOR INSPECTIONS
    event.register("OnUpdate", "OnUpdate_XAutoCopilot_btnPreparation")
end

function XAutoCopilot_chkStair_OnClick()

    local chkStair = gui.getWidgetValue(XAutoCopilot.chkStair)
    if chkStair then
        --checked Stair
        dref.setIntV(xac_state_chk_box, 1, 1)
    else
        --unchecked Stair
        dref.setIntV(xac_state_chk_box, 1, 0)
    end
end

function SAFETY_EXTERIOR_INSPECTIONS_START1()
    logging.debug("SAFETY_EXTERIOR_INSPECTIONS_START1")
    dref.setString(xac_route_state, "SAFETY EXTERIOR INSPECTIONS")

    if dref.getIntV(xac_state_chk_box, 1, 1) == 1 then
        dref.setInt(dref.getDataref("sim/custom/xap/groundserv/stair/str_on"), 1) --call Stair
    end

    dref.setInt(dref.getDataref("sim/custom/xap/elec/gpu_here"), 1) --call GPU
    dref.setInt(dref.getDataref("sim/custom/xap/doors/p_f_l_kn"), 1) --Left Front Passenger Door
    dref.setInt(dref.getDataref("sim/cockpit2/controls/gear_handle_down"), 1) --Gear is down
    dref.setInt(dref.getDataref("sim/custom/xap/doors/c_f_kn"), 1) --Cargo Front Door
    dref.setInt(dref.getDataref("sim/custom/xap/doors/c_b_kn"), 1) --Cargo Back Door
    dref.setIntV(xac_state_preparation, 1, 0)
    dref.setIntV(xac_state_preparation, 2, 1)
end

function PRELIMINARY_COCKPIT_PREPARATION_START1()
    logging.debug("PRELIMINARY_COCKPIT_PREPARATION_START1")
    dref.setString(xac_route_state, "PRELIMINARY COCKPIT PREPARATION")
    dref.setInt(dref.getDataref("sim/custom/xap/elec/gpu_on"), 1) --Exterior Power on
    dref.setInt(dref.getDataref("sim/custom/xap/extlight/cockp_main_br"), 1) --Int Dome Lights on
    dref.setFloat(dref.getDataref("sim/custom/xap/intlight/ovhd_int_lt"), 0.6) --Integrated Lights
    dref.setFloat(dref.getDataref("sim/custom/xap/intlight/int_pan_ped_lt"), 0.6) --Integrated Lights
    dref.setInt(dref.getDataref("sim/custom/xap/bleed/eng1_bl_knob"), 0) --Engine Bleed 1 OFF
    dref.setInt(dref.getDataref("sim/custom/xap/bleed/eng2_bl_knob"), 0) --Engine Bleed 2 OFF
    dref.setInt(dref.getDataref("sim/custom/xap/bleed/apu_blvlv"), 0) --Apu Bleed OFF
    dref.setInt(dref.getDataref("sim/custom/xap/cond/pack1"), 0) --Aircon Pack 1 OFF
    dref.setInt(dref.getDataref("sim/custom/xap/cond/pack2"), 0) --Aircon Pack 2 OFF
    dref.setInt(dref.getDataref("sim/custom/xap/press/alt_rot"), 0) --Landing Elevation AUTO
    dref.setIntV(xac_state_preparation, 2, 0)
    dref.setIntV(xac_state_preparation, 3, 1)
end

function PRELIMINARY_COCKPIT_PREPARATION_START2()
    logging.debug("PRELIMINARY_COCKPIT_PREPARATION_START2")
    dref.setInt(dref.getDataref("sim/custom/xap/bleed/eng1_bl_knob"), 1) --Engine Bleed 1 ON
    dref.setInt(dref.getDataref("sim/custom/xap/bleed/eng2_bl_knob"), 1) --Engine Bleed 2 ON
    dref.setInt(dref.getDataref("sim/custom/xap/elec/gpu_on"), 0) --Exterior Power off
    dref.setInt(dref.getDataref("sim/custom/xap/elec/bat1_on"), 1) --Battery 1 AUTO
    dref.setInt(dref.getDataref("sim/custom/xap/elec/bat2_on"), 1) --Battery 2 AUTO
    dref.setIntV(xac_state_preparation, 3, 0)
    dref.setIntV(xac_state_preparation, 4, 1)
    --dref.setInt(dref.getDataref("sim/custom/xap/elec/gpu_on"),1)--Exterior Power on we do not wait yet TODO
end

function PRELIMINARY_COCKPIT_PREPARATION_START3()
    logging.debug("PRELIMINARY_COCKPIT_PREPARATION_START3")
    dref.setInt(dref.getDataref("sim/custom/xap/elec/gpu_on"), 1) --Exterior Power on
    dref.setIntV(xac_state_preparation, 4, 0)
    dref.setIntV(xac_state_preparation, 5, 1)
end

function INITIAL_COCKPIT_PREPARATION_START1()
    logging.debug("INITIAL_COCKPIT_PREPARATION_START1")
    dref.setString(xac_route_state, "INITIAL COCKPIT PREPARATION")
    dref.setInt(dref.getDataref("sim/custom/xap/extlight/navlogo_sw"), 1) --Nav & Logo Lights ON
    dref.setFloat(dref.getDataref("sim/custom/xap/lght_nd"), 0.0) --Integrated Lights
    dref.setFloat(dref.getDataref("sim/custom/xap/lght_pfd"), 0.0) --Integrated Lights
    dref.setFloat(dref.getDataref("sim/custom/xap/lght_upd"), 0.0) --Integrated Lights
    dref.setFloat(dref.getDataref("sim/custom/xap/lght_dnd"), 0.0) --Integrated Lights
    dref.setInt(dref.getDataref("sim/custom/xap/disp/sys/mode"), 6) --ECAM ELEC BAT Status
    dref.setInt(dref.getDataref("sim/custom/xap/engines/eng1msw"), 0) --Engine Master 1 OFF
    dref.setInt(dref.getDataref("sim/custom/xap/engines/eng2msw"), 0) --Engine Master 2 OFF
    dref.setInt(dref.getDataref("sim/custom/xap/engines/startsel"), 0) --Engine Mode Selector NORM
    dref.setInt(dref.getDataref("sim/cockpit/switches/gear_handle_status"), 1) --Landing Gear Lever|DOWN
    --sim/flightmodel2/gear/deploy_ratio TODO
    dref.setIntV(xac_state_preparation, 5, 0)
    dref.setIntV(xac_state_preparation, 6, 1)
end

function INITIAL_COCKPIT_PREPARATION_START2()
    logging.debug("INITIAL_COCKPIT_PREPARATION_START2")
    dref.setInt(dref.getDataref("sim/custom/xap/disp/sys/mode"), 5) --ECAM WHEEL Gear Indicators
    dref.setInt(dref.getDataref("sim/custom/xap/icerain/wiper_r"), 0) --Wiper right off
    dref.setInt(dref.getDataref("sim/custom/xap/icerain/wiper_l"), 0) --Wiper left off
    dref.setFloat(dref.getDataref("sim/cockpit2/controls/flap_ratio"), 0.0) --Flaps Lever 0
    dref.setFloat(dref.getDataref("sim/cockpit2/controls/speedbrake_ratio"), 0.0) --Spoilers Lever|RETRACT
    dref.setIntV(xac_state_preparation, 6, 0)
    dref.setIntV(xac_state_preparation, 7, 1)
end

function INITIAL_COCKPIT_PREPARATION_START3()
    logging.debug("INITIAL_COCKPIT_PREPARATION_START3")
    dref.setInt(dref.getDataref("sim/custom/xap/disp/sys/mode"), 4) --ECAM F/CTL Spoilers Position
    dref.setInt(dref.getDataref("sim/custom/xap/firetest/apu"), 1) --Apu Fire Extinguisher on
    dref.setIntV(xac_state_preparation, 7, 0)
    dref.setIntV(xac_state_preparation, 8, 1)
end

function INITIAL_COCKPIT_PREPARATION_START4()
    logging.debug("INITIAL_COCKPIT_PREPARATION_START4")
    dref.setInt(dref.getDataref("sim/custom/xap/firetest/apu"), 0) --Apu Fire Extinguisher off
    dref.setInt(dref.getDataref("sim/cockpit/engine/APU_switch"), 1) --Apu Master|ON
    dref.setInt(dref.getDataref("sim/custom/xap/disp/sys/mode"), 2) --ECAM APU Status
    dref.setIntV(xac_state_preparation, 8, 0)
    dref.setIntV(xac_state_preparation, 9, 1)
end

function INITIAL_COCKPIT_PREPARATION_START5()
    logging.debug("INITIAL_COCKPIT_PREPARATION_START5")
    dref.setInt(dref.getDataref("sim/custom/xap/apu/start_pb"), 1) --APU Start
    dref.setIntV(xac_state_preparation, 9, 0)
    dref.setIntV(xac_state_preparation, 10, 1)
end

function INITIAL_COCKPIT_PREPARATION_START6()
    logging.debug("INITIAL_COCKPIT_PREPARATION_START6")
    dref.setInt(dref.getDataref("sim/custom/xap/elec/gpu_on"), 0) --Exterior Power off
    dref.setInt(dref.getDataref("sim/custom/xap/disp/sys/mode"), 6) --ECAM ELEC External Power Status
    dref.setInt(dref.getDataref("sim/custom/xap/elec/gpu_here"), 0) --call GPU
    dref.setFloat(dref.getDataref("sim/flightmodel/controls/parkbrake"), 1.0) --Parking Brake ON
    dref.setIntV(xac_state_preparation, 10, 0)
    dref.setIntV(xac_state_preparation2, 1, 1)
end

function INITIAL_COCKPIT_PREPARATION_START7()
    logging.debug("INITIAL_COCKPIT_PREPARATION_START7")
    dref.setInt(dref.getDataref("sim/custom/xap/hydr/y/elpump/mode"), 0) --Yellow Electric Pump OFF
    dref.setFloat(dref.getDataref("sim/flightmodel/controls/parkbrake"), 0.0) --Parking Brake OFF
    dref.setIntV(xac_state_preparation2, 1, 0)
    dref.setIntV(xac_state_preparation2, 2, 1)
end

function INITIAL_COCKPIT_PREPARATION_START8()
    logging.debug("INITIAL_COCKPIT_PREPARATION_START8")
    dref.setFloat(dref.getDataref("sim/cockpit2/controls/parking_brake_ratio"), 0.5) --Brake Pedals PRESS/HOLD
    dref.setIntV(xac_state_preparation2, 2, 0)
    dref.setIntV(xac_state_preparation2, 3, 1)
end

function INITIAL_COCKPIT_PREPARATION_START9()
    logging.debug("INITIAL_COCKPIT_PREPARATION_START9")
    dref.setFloat(dref.getDataref("sim/cockpit2/controls/parking_brake_ratio"), 0.0) --Brake Pedals RELEASE
    dref.setIntV(xac_state_preparation2, 3, 0)
    dref.setIntV(xac_state_preparation2, 4, 1)
end

function INITIAL_COCKPIT_PREPARATION_START10()
    logging.debug("INITIAL_COCKPIT_PREPARATION_START10")
    dref.setFloat(dref.getDataref("sim/flightmodel/controls/parkbrake"), 1.0) --Parking Brake ON
    dref.setIntV(xac_state_preparation2, 4, 0)
    dref.setIntV(xac_state_preparation2, 5, 1)
end

function INITIAL_COCKPIT_PREPARATION_START11()
    logging.debug("INITIAL_COCKPIT_PREPARATION_START11")
    dref.setInt(dref.getDataref("sim/custom/xap/hydr/y/elpump/mode"), 1) --Yellow Electric Pump ON
    dref.setInt(dref.getDataref("sim/cockpit/switches/anti_ice_window_heat"), 1) --Probe/Window Heat ON
    dref.setInt(dref.getDataref("sim/custom/xap/disp/sys/mode"), 3) --ECAM PRESS Cabin|OUTFLOW VALVE OPEN
    dref.setInt(dref.getDataref("sim/custom/xap/bleed/apu_blvlv"), 1) --ECAM PRESS Cabin|OUTFLOW VALVE OPEN
    dref.setInt(dref.getDataref("sim/custom/xap/cond/pack1"), 1) --Air Con Pack 1 ON
    dref.setInt(dref.getDataref("sim/custom/xap/cond/pack2"), 1) --Air Con Pack 2 ON
    dref.setFloat(dref.getDataref("sim/custom/xap/cond/ckpt_knob"), 24.0) --Parking Brake ON
    dref.setFloat(dref.getDataref("sim/custom/xap/cond/fwd_knob"), 24.0) --Parking Brake ON
    dref.setFloat(dref.getDataref("sim/custom/xap/cond/aft_knob"), 24.0) --Parking Brake ON
    dref.setIntV(xac_state_preparation2, 5, 0)
    dref.setIntV(xac_state_preparation2, 6, 1)
end

function INITIAL_COCKPIT_PREPARATION_START12()
    logging.debug("INITIAL_COCKPIT_PREPARATION_START12")
    dref.setInt(dref.getDataref("sim/custom/xap/disp/sys/mode"), 9) --ECAM DOOR Oxy Pressure
    dref.setIntV(xac_state_preparation2, 6, 0)
    dref.setIntV(xac_state_preparation2, 7, 1)
end

function INITIAL_COCKPIT_PREPARATION_START13()
    logging.debug("INITIAL_COCKPIT_PREPARATION_START13")
    dref.setInt(dref.getDataref("sim/custom/xap/disp/sys/mode"), 0) --ECAM HYD Quantity
    dref.setIntV(xac_state_preparation2, 7, 0)
    dref.setIntV(xac_state_preparation2, 8, 1)
end

function INITIAL_COCKPIT_PREPARATION_START14()
    logging.debug("INITIAL_COCKPIT_PREPARATION_START14")
    dref.setInt(dref.getDataref("sim/custom/xap/disp/sys/mode"), 11) --ECAM ENG Oil Quantity
    dref.setIntV(xac_state_preparation2, 8, 0)
    dref.setIntV(xac_state_preparation2, 9, 1)
end

function COCKPIT_PREPARATION_START1()
    logging.debug("COCKPIT_PREPARATION_START1")
    dref.setString(xac_route_state, "COCKPIT PREPARATION")
    dref.setInt(dref.getDataref("sim/custom/xap/adirs/data_sel"), 3) --ADIRS Data Sel STS
    dref.setInt(dref.getDataref("sim/custom/xap/adirs/sys_sel"), 1) --ADIRS Sys Sel STS
    dref.setInt(dref.getDataref("sim/custom/xap/adirs/mode_sel_1"), 1) --ADIRS Mode Sel 1
    dref.setIntV(xac_state_preparation2, 9, 0)
    dref.setIntV(xac_state_preparation2, 10, 1)
end

function COCKPIT_PREPARATION_START2()
    logging.debug("COCKPIT_PREPARATION_START2")
    dref.setInt(dref.getDataref("sim/custom/xap/adirs/mode_sel_3"), 1) --ADIRS Mode Sel 2
    dref.setIntV(xac_state_preparation2, 10, 0)
    dref.setIntV(xac_state_preparation3, 1, 1)
end

function COCKPIT_PREPARATION_START3()
    logging.debug("COCKPIT_PREPARATION_START3")
    dref.setInt(dref.getDataref("sim/custom/xap/adirs/mode_sel_2"), 1) --ADIRS Mode Sel 3
    dref.setIntV(xac_state_preparation3, 1, 0)
    dref.setIntV(xac_state_preparation3, 2, 1)
end

function COCKPIT_PREPARATION_START4()
    logging.debug("COCKPIT_PREPARATION_START4")
    dref.setInt(dref.getDataref("sim/custom/xap/adirs/knob_ent"), 1) --ADIRS Enter
    gui.showWindow(XAutoCopilotRoute.gui_h) -- PopUp Window
    dref.setInt(dref.getDataref("sim/custom/xap/extlight/strobe_sw"), 1) --Strobe Lights AUTO
    dref.setInt(dref.getDataref("sim/custom/xap/extlight/beacon_sw"), 0) --Beacon Light OFF
    dref.setInt(dref.getDataref("sim/custom/xap/extlight/emer_ext_lt"), 1) --Emergency Exit Lights ARM
    dref.setInt(dref.getDataref("sim/cockpit/switches/fasten_seat_belts"), 1) --Seatbelt Signs ON
    dref.setInt(dref.getDataref("sim/cockpit2/switches/no_smoking"), 1) --No Smoking Signs ON
    dref.setFloat(dref.getDataref("sim/custom/xap/cond/econ_flow"), 0.5) --Hi Flow
    dref.setString(xac_route_state, "BOARDING")
    dref.setIntV(xac_state_preparation3, 2, 0)
    dref.setIntV(xac_state_preparation3, 3, 1)
end

function COCKPIT_PREPARATION_START5()
    logging.debug("COCKPIT_PREPARATION_START5")
    dref.setInt(dref.getDataref("sim/custom/xap/firetest/e1"), 1) --Engine Fire Extinguisher 1
    dref.setInt(dref.getDataref("sim/custom/xap/firetest/e2"), 1) --Engine Fire Extinguisher 2
    dref.setInt(dref.getDataref("sim/custom/xap/firetest/apu"), 1) --Apu Fire Extinguisher on
    dref.setIntV(xac_state_preparation3, 3, 0)
    dref.setIntV(xac_state_preparation3, 4, 1)
end

function COCKPIT_PREPARATION_START6()
    logging.debug("COCKPIT_PREPARATION_START6")
    dref.setInt(dref.getDataref("sim/custom/xap/firetest/e1"), 0) --Engine Fire Extinguisher 1
    dref.setInt(dref.getDataref("sim/custom/xap/firetest/e2"), 0) --Engine Fire Extinguisher 2
    dref.setInt(dref.getDataref("sim/custom/xap/firetest/apu"), 0) --Apu Fire Extinguisher off
    dref.setInt(dref.getDataref("sim/custom/xap/radio/on"), 1) --Radio Panel ON
    dref.setInt(dref.getDataref("sim/custom/xap/radio/nav_but"), 0) --Radio Panel Nav OFF
    dref.setInt(dref.getDataref("sim/cockpit2/radios/actuators/nav_com_adf_mode"), 2) --Panel VHF 1 SET
    gui.showWindow(XAutoCopilotBriefingDeparture.gui_h) -- PopUp Window
    dref.setIntV(xac_state_preparation3, 4, 0)
    dref.setIntV(xac_state_preparation3, 5, 1)
end

function MCDU_INITIALISATION_START1()
    logging.debug("MCDU_INITIALISATION_START1")
    dref.setString(xac_route_state, "MCDU INITIALISATION")
    dref.setInt(dref.getDataref("sim/cockpit/switches/EFIS_dme_1_selector"), 2) --ILS/ADF Selector SET TO ILS
    dref.setInt(dref.getDataref("sim/cockpit/switches/EFIS_dme_2_selector"), 2) --VOR/ADF Selector SET TO VOR
    dref.setInt(dref.getDataref("sim/custom/xap/groundserv/load_on"), 1) --Loadsheet SET
    dref.setInt(dref.getDataref("sim/custom/xap/groundserv/tanker/tanker_on"), 1) --Fuel Truck
    dref.setIntV(xac_state_preparation3, 5, 0)
    dref.setIntV(xac_state_preparation3, 6, 1)
end

function FINAL_COCKPIT_PREPARATION_START1()
    logging.debug("FINAL_COCKPIT_PREPARATION_START1")
    dref.setString(xac_route_state, "FINAL COCKPIT PREPARATION")
    dref.setInt(dref.getDataref("sim/custom/xap/fcu/fd"), 1) --Flight Director ON
    dref.setInt(dref.getDataref("sim/custom/xap/fcu/ils"), 1) --ILS
    dref.setInt(dref.getDataref("sim/custom/xap/fcu/nd_mode"), 3)
    dref.setInt(dref.getDataref("sim/cockpit2/EFIS/map_range"), 2)
    dref.setInt(dref.getDataref("sim/cockpit/switches/EFIS_dme_1_selector"), 1) --ILS/ADF Selector SET TO OFF
    dref.setInt(dref.getDataref("sim/cockpit/switches/EFIS_dme_2_selector"), 1) --VOR/ADF Selector SET TO OFF
    dref.setInt(dref.getDataref("sim/custom/xap/ap/spdmanaged"), 1) --FCU-Speed Window
    dref.setInt(dref.getDataref("sim/custom/xap/oxy/crewsupp"), 0) --Oxygen Crew Supply ON
    dref.setInt(dref.getDataref("sim/operation/sound/sound_on"), 1) --Loudspeakers ON
    dref.setInt(dref.getDataref("sim/custom/xap/oxy/oxyhiss"), 1) --Oxygen Mask Test
    dref.setInt(dref.getDataref("sim/cockpit2/clock_timer/timer_running"), 1) --Chrono OFF
    dref.setFloat(dref.getDataref("sim/custom/xap/et_timer/all"), 0.0) --Clock Elapsed Time BLANK OR ZERO
    dref.setInt(dref.getDataref("sim/custom/xap/wheels/ant_skeed"), 1) --Antiskid ON
    dref.setIntV(xac_state_preparation3, 6, 0)
    dref.setIntV(xac_state_preparation3, 7, 1)
end

function FINAL_COCKPIT_PREPARATION_START2()
    logging.debug("FINAL_COCKPIT_PREPARATION_START2")
    dref.setInt(dref.getDataref("sim/cockpit/switches/EFIFS_shows_weather"), 0) --Weather Radar OFF
    dref.setInt(dref.getDataref("sim/custom/xap/wx_radar/au_gn_mx"), 1) --Weather Radar Gain
    dref.setInt(dref.getDataref("sim/custom/xap/wx_radar/wv_map"), 1) --WX/TURB
    dref.setFloat(dref.getDataref("sim/cockpit/switches/EFIS_weather_alpha"), 0.7) --Weather Radar Tilt|4° UP
    dref.setInt(dref.getDataref("sim/custom/xap/disp/sys/mode"), 3) --ECAM PRESS Cabin LDG ELEV AUTO
    dref.setInt(dref.getDataref("sim/custom/xap/engines/eng1msw"), 0) --Engine Master 1 OFF
    dref.setInt(dref.getDataref("sim/custom/xap/engines/eng2msw"), 0) --Engine Master 2 OFF
    dref.setInt(dref.getDataref("sim/custom/xap/engines/startsel"), 0) --Engine Mode Selector NORM
    dref.setFloat(dref.getDataref("sim/flightmodel/controls/parkbrake"), 1.0) --Parking Brake ON
    dref.setIntV(xac_state_preparation3, 7, 0)
    dref.setIntV(xac_state_preparation3, 8, 1)
end

function FINAL_COCKPIT_PREPARATION_START3()
    logging.debug("FINAL_COCKPIT_PREPARATION_START3")
    dref.setFloat(dref.getDataref("sim/flightmodel/controls/parkbrake"), 0.0) --Parking Brake OFF
    dref.setIntV(xac_state_preparation3, 8, 0)
    dref.setIntV(xac_state_preparation3, 9, 1)
end

function FINAL_COCKPIT_PREPARATION_START4()
    logging.debug("FINAL_COCKPIT_PREPARATION_START4")
    dref.setFloat(dref.getDataref("sim/cockpit2/controls/parking_brake_ratio"), 0.5) --Brake Pedals PRESS/HOLD
    dref.setIntV(xac_state_preparation3, 9, 0)
    dref.setIntV(xac_state_preparation3, 10, 1)
end

function FINAL_COCKPIT_PREPARATION_START5()
    logging.debug("FINAL_COCKPIT_PREPARATION_START5")
    dref.setFloat(dref.getDataref("sim/cockpit2/controls/parking_brake_ratio"), 0.0) --Brake Pedals RELEASE

    dref.setInt(dref.getDataref("sim/custom/xap/atc/mode_sel"), 0) --ATC Mode|STBY
    dref.setInt(dref.getDataref("sim/custom/xap/atc/sel_12"), 0) --ATC System|1
    dref.setInt(dref.getDataref("sim/custom/xap/atc/alt_rptg"), 1) --Alt Rptg|ON
    dref.setInt(dref.getDataref("sim/custom/xap/atc/ta_tara"), 0) --TCAS|STBY
    dref.setInt(dref.getDataref("sim/custom/xap/disp/sys/mode"), 1) --ECAM FUEL|CHECK
    dref.setIntV(xac_state_preparation3, 10, 0)
    dref.setIntV(xac_state_preparation4, 1, 1)
end

function OnUpdate_XAutoCopilot_btnPreparation()
    --- -SAFETY EXTERIOR INSPECTIONS STATUS
    if dref.getIntV(xac_state_preparation, 1, 1) == 1 then
        local tmr_safety = timer.newOneShot("SAFETY_EXTERIOR_INSPECTIONS_START1", 1.0)
    end

    if dref.getIntV(xac_state_preparation, 1, 1) == 1 and
            dref.getInt(dref.getDataref("sim/custom/xap/elec/gpu_run")) == 1 and --GPU is running
            dref.getInt(dref.getDataref("sim/custom/xap/elec/gpu_av")) == 1 and --GPU is available
            dref.getFloat(dref.getDataref("sim/custom/xap/doors/p_f_l_now")) == 1.0 and --Left Front Passenger Door|OPEN
            dref.getInt(dref.getDataref("sim/cockpit/switches/gear_handle_status")) == 1 and --Gear is down
            dref.getInt(dref.getDataref("sim/custom/xap/groundserv/pins_covers")) == 1 and --Pins and Covers there
            dref.getFloat(dref.getDataref("sim/custom/xap/doors/c_f_now")) == 1.0 and --Cargo Front Door is open
            dref.getFloat(dref.getDataref("sim/custom/xap/doors/c_b_now")) == 1.0 --Cargo Back Door is open
    then
        dref.setIntV(xac_state_preparation, 2, 1)
        dref.setIntV(xac_state_preparation, 1, 0)
    end

    --- -PRELIMINARY COCKPIT PREPARATION STATUS
    if dref.getIntV(xac_state_preparation, 2, 1) == 1 and
            dref.getIntV(xac_state_chk_box, 1, 1) == 1 and
            dref.getFloat(dref.getDataref("sim/custom/xap/groundserv/stair/conect_stair")) > 1.0 --STAIR is available
    then
        local tmr_precock1 = timer.newOneShot("PRELIMINARY_COCKPIT_PREPARATION_START1", 10.0)
    end

    if dref.getIntV(xac_state_preparation, 2, 1) == 1 and
            dref.getIntV(xac_state_chk_box, 1, 1) == 0
    then
        local tmr_precock1 = timer.newOneShot("PRELIMINARY_COCKPIT_PREPARATION_START1", 10.0)
    end


    if dref.getIntV(xac_state_preparation, 3, 1) == 1 then
        local tmr_precock2 = timer.newOneShot("PRELIMINARY_COCKPIT_PREPARATION_START2", 5.0)
    end

    if dref.getIntV(xac_state_preparation, 4, 1) == 1 then
        local tmr_precock3 = timer.newOneShot("PRELIMINARY_COCKPIT_PREPARATION_START3", 3.0)
    end

    --- -INITIAL COCKPIT PREPARATION STATUS
    if dref.getIntV(xac_state_preparation, 5, 1) == 1 then
        local tmr_inicock1 = timer.newOneShot("INITIAL_COCKPIT_PREPARATION_START1", 1.0)
    end

    if dref.getIntV(xac_state_preparation, 6, 1) == 1 then
        local tmr_inicock2 = timer.newOneShot("INITIAL_COCKPIT_PREPARATION_START2", 10.0)
    end

    if dref.getIntV(xac_state_preparation, 7, 1) == 1 then
        local tmr_inicock3 = timer.newOneShot("INITIAL_COCKPIT_PREPARATION_START3", 10.0)
    end

    if dref.getIntV(xac_state_preparation, 8, 1) == 1 then
        local tmr_inicock4 = timer.newOneShot("INITIAL_COCKPIT_PREPARATION_START4", 2.0)
    end

    if dref.getIntV(xac_state_preparation, 9, 1) == 1 and
            dref.getFloat(dref.getDataref("sim/custom/xap/apu/flap")) > 100.0 then
        local tmr_inicock5 = timer.newOneShot("INITIAL_COCKPIT_PREPARATION_START5", 1.0)
    end

    if dref.getIntV(xac_state_preparation, 10, 1) == 1 and
            dref.getInt(dref.getDataref("sim/custom/xap/apu/start_pb")) == 3 then
        local tmr_inicock6 = timer.newOneShot("INITIAL_COCKPIT_PREPARATION_START6", 1.0)
    end

    if dref.getIntV(xac_state_preparation2, 1, 1) == 1 and
            dref.getFloat(dref.getDataref("sim/custom/xap/brakes/accu_press")) > 3.0 and
            dref.getFloat(dref.getDataref("sim/custom/xap/brakes/rght_br_press")) > 1.5 and
            dref.getFloat(dref.getDataref("sim/custom/xap/brakes/left_br_press")) > 1.5 then
        local tmr_inicock7 = timer.newOneShot("INITIAL_COCKPIT_PREPARATION_START7", 1.0)
    end

    if dref.getIntV(xac_state_preparation2, 2, 1) == 1 then
        local tmr_inicock8 = timer.newOneShot("INITIAL_COCKPIT_PREPARATION_START8", 1.0)
    end

    if dref.getIntV(xac_state_preparation2, 3, 1) == 1 and
            dref.getFloat(dref.getDataref("sim/custom/xap/brakes/rght_br_press")) > 0.9 and
            dref.getFloat(dref.getDataref("sim/custom/xap/brakes/left_br_press")) > 0.9 then
        local tmr_inicock9 = timer.newOneShot("INITIAL_COCKPIT_PREPARATION_START9", 1.0)
    end

    if dref.getIntV(xac_state_preparation2, 4, 1) == 1 then
        local tmr_inicock10 = timer.newOneShot("INITIAL_COCKPIT_PREPARATION_START10", 1.0)
    end

    if dref.getIntV(xac_state_preparation2, 5, 1) == 1 and
            dref.getFloat(dref.getDataref("sim/custom/xap/brakes/accu_press")) > 3.0 and
            dref.getFloat(dref.getDataref("sim/custom/xap/brakes/rght_br_press")) > 1.5 and
            dref.getFloat(dref.getDataref("sim/custom/xap/brakes/left_br_press")) > 1.5 then
        local tmr_inicock11 = timer.newOneShot("INITIAL_COCKPIT_PREPARATION_START11", 1.0)
    end


    if dref.getIntV(xac_state_preparation2, 6, 1) == 1 then
        local tmr_inicock10 = timer.newOneShot("INITIAL_COCKPIT_PREPARATION_START12", 3.0)
    end

    if dref.getIntV(xac_state_preparation2, 7, 1) == 1 then
        local tmr_inicock10 = timer.newOneShot("INITIAL_COCKPIT_PREPARATION_START13", 3.0)
    end

    if dref.getIntV(xac_state_preparation2, 8, 1) == 1 then
        local tmr_inicock10 = timer.newOneShot("INITIAL_COCKPIT_PREPARATION_START14", 3.0)
    end

    --- -COCKPIT PREPARATION STATUS

    if dref.getIntV(xac_state_preparation2, 9, 1) == 1 then
        local tmr_cock1 = timer.newOneShot("COCKPIT_PREPARATION_START1", 3.0)
    end

    if dref.getIntV(xac_state_preparation2, 10, 1) == 1 and
            dref.getInt(dref.getDataref("sim/custom/xap/adirs/on_bat")) == 0 then
        local tmr_cock2 = timer.newOneShot("COCKPIT_PREPARATION_START2", 3.0)
    end

    if dref.getIntV(xac_state_preparation3, 1, 1) == 1 and
            dref.getInt(dref.getDataref("sim/custom/xap/adirs/on_bat")) == 0 then
        local tmr_cock3 = timer.newOneShot("COCKPIT_PREPARATION_START3", 3.0)
    end

    if dref.getIntV(xac_state_preparation3, 2, 1) == 1 and
            dref.getInt(dref.getDataref("sim/custom/xap/adirs/on_bat")) == 0 then
        local tmr_cock4 = timer.newOneShot("COCKPIT_PREPARATION_START4", 3.0)
    end

    if dref.getIntV(xac_state_preparation3, 3, 1) == 1 then
        local tmr_cock5 = timer.newOneShot("COCKPIT_PREPARATION_START5", 3.0)
    end

    if dref.getIntV(xac_state_preparation3, 4, 1) == 1 then
        local tmr_cock6 = timer.newOneShot("COCKPIT_PREPARATION_START6", 2.0)
    end

    --- -MCDU INITIALISATION
    if dref.getIntV(xac_state_preparation3, 5, 1) == 1 then
        local tmr_mcdu6 = timer.newOneShot("MCDU_INITIALISATION_START1", 5.0)
    end

    --- -FINAL COCKPIT PREPARATION
    if dref.getIntV(xac_state_preparation3, 6, 1) == 1 then
        local tmr_fcock1 = timer.newOneShot("FINAL_COCKPIT_PREPARATION_START1", 5.0)
    end

    if dref.getIntV(xac_state_preparation3, 7, 1) == 1 then
        local tmr_fcock2 = timer.newOneShot("FINAL_COCKPIT_PREPARATION_START2", 5.0)
    end

    if dref.getIntV(xac_state_preparation3, 8, 1) == 1 and
            dref.getFloat(dref.getDataref("sim/custom/xap/brakes/accu_press")) > 3.0 and
            dref.getFloat(dref.getDataref("sim/custom/xap/brakes/rght_br_press")) > 1.5 and
            dref.getFloat(dref.getDataref("sim/custom/xap/brakes/left_br_press")) > 1.5 and
            XAutoCopilotRoute.fuelfinish == 1 then
        dref.setInt(dref.getDataref("sim/custom/xap/groundserv/tanker/tanker_on"), 0) --Fuel Truck
        local tmr_fcock3 = timer.newOneShot("FINAL_COCKPIT_PREPARATION_START3", 30.0)
    end

    if dref.getIntV(xac_state_preparation3, 9, 1) == 1 then
        local tmr_fcock4 = timer.newOneShot("FINAL_COCKPIT_PREPARATION_START4", 5.0)
    end

    if dref.getIntV(xac_state_preparation3, 10, 1) == 1 and
            dref.getFloat(dref.getDataref("sim/custom/xap/brakes/rght_br_press")) > 0.9 and
            dref.getFloat(dref.getDataref("sim/custom/xap/brakes/left_br_press")) > 0.9 then
        local tmr_fcock5 = timer.newOneShot("FINAL_COCKPIT_PREPARATION_START5", 1.0)
    end

    if string.find(dref.getString(xac_adirs_disp), "ALIGNED") and
            dref.getIntV(xac_state_preparation4, 1, 1) == 1 then
        sound.say("Cockpit Preparation is finish.")
        gui.hideWidget(XAutoCopilot.preparation)
        gui.showWidget(XAutoCopilot.btnbeforestart)
        gui.showWidget(XAutoCopilot.beforestart)
        gui.showWindow(XAutoCopilot.gui_h)
        gui.showWidget(XAutoCopilot.pushback)
        gui.showWidget(XAutoCopilot.chkPushback)
        OnUpdate_XAutoCopilot_btnPreparation = nil
    end
end

--- -BEFORE START UP
function XAutoCopilot_btnbeforeStart_OnClick()
    dref.setString(xac_route_state, "BEFORE START UP")
    gui.hideWindow(XAutoCopilot.gui_h)
    gui.hideWidget(XAutoCopilot.btnbeforestart)
    gui.hideWidget(XAutoCopilot.pushback)
    gui.hideWidget(XAutoCopilot.chkPushback)
    gui.hideWidget(XAutoCopilot.beforestart)
    dref.setIntV(xac_state_beforestart, 1, 1)
    event.register("OnUpdate", "OnUpdate_XAutoCopilot_btnbeforeStart")
end


function XAutoCopilot_chkPushback_OnClick()

    local chkPushback = gui.getWidgetValue(XAutoCopilot.chkPushback)
    if chkPushback then
        --checked pushback
        dref.setIntV(xac_state_chk_box, 2, 1)
    else
        --unchecked pushback
        dref.setIntV(xac_state_chk_box, 2, 0)
    end
end

function BEFORE_START_START1()
    logging.debug("BEFORE_START_START1")
    dref.setInt(dref.getDataref("sim/custom/xap/groundserv/call_tow"), 1) --call pushback Truck
    dref.setInt(dref.getDataref("sim/custom/xap/chklst/chklst01"), 2) --Jardesign Checklist
    dref.setIntV(xac_state_beforestart, 3, 1)
    dref.setIntV(xac_state_beforestart, 2, 0)
end

function BEFORE_START_START2()
    logging.debug("BEFORE_START_START2")
    dref.setFloat(dref.getDataref("sim/flightmodel/controls/parkbrake"), 1.0) --Parking Brake ON
    dref.setInt(dref.getDataref("sim/custom/xap/chklst/chklst01"), 2) --Jardesign Checklist
    dref.setIntV(xac_state_beforestart, 3, 1)
    dref.setIntV(xac_state_beforestart, 2, 0)
end

function BEFORE_START_START3()
    logging.debug("BEFORE_START_START3")
    gui.hideWidget(XAutoCopilot.chkPushback)

    gui.showWidget(XAutoCopilot.btnstart)
    gui.showWidget(XAutoCopilot.start)
    gui.showWindow(XAutoCopilot.gui_h)

    dref.setIntV(xac_state_beforestart, 4, 1)
    dref.setIntV(xac_state_beforestart, 3, 0)
    OnUpdate_XAutoCopilot_btnbeforeStart = nil
end

function OnUpdate_XAutoCopilot_btnbeforeStart()

    if dref.getIntV(xac_state_beforestart, 1, 1) == 1 then
        logging.debug("OnUpdate_XAutoCopilot_btnbeforeStart")
        dref.setInt(dref.getDataref("sim/custom/xap/doors/p_f_l_kn"), 0) --Left Front Passenger Door|CLOSE
        dref.setInt(dref.getDataref("sim/custom/xap/doors/c_f_kn"), 0) --Cargo Door, Front CLOSE
        dref.setInt(dref.getDataref("sim/custom/xap/doors/c_b_kn"), 0) --Cargo Door, Back CLOSE
        dref.setInt(dref.getDataref("sim/custom/xap/groundserv/stair/str_on"), 0) --Stairway/Gangway|DISS
        dref.setInt(dref.getDataref("sim/custom/xap/groundserv/load_on"), 0) --loadsheet off
        dref.setInt(dref.getDataref("sim/custom/xap/wheels/ant_skeed"), 0) --Antiskid|DISC
        dref.setInt(dref.getDataref("sim/custom/xap/disp/sys/mode"), 9) --ECAM DOOR Condition
        dref.setInt(dref.getDataref("sim/custom/xap/extlight/beacon_sw"), 1) --ECAM DOOR Condition
        dref.setIntV(xac_state_beforestart, 2, 1)
        dref.setIntV(xac_state_beforestart, 1, 0)
    end


    if dref.getIntV(xac_state_chk_box, 2, 1) == 1 and dref.getIntV(xac_state_beforestart, 2, 1) == 1 then
        local tmr_bstart1 = timer.newOneShot("BEFORE_START_START1", 10.0)
    end

    if dref.getIntV(xac_state_chk_box, 2, 1) == 0 and dref.getIntV(xac_state_beforestart, 2, 1) == 1 then
        local tmr_bstart2 = timer.newOneShot("BEFORE_START_START2", 10.0)
    end


    if dref.getIntV(xac_state_beforestart, 3, 1) == 1 then
        local tmr_bstart3 = timer.newOneShot("BEFORE_START_START3", 25.0)
    end
end

--- -START UP
function XAutoCopilot_btnStart_OnClick()
    dref.setString(xac_route_state, "START UP")
    gui.hideWindow(XAutoCopilot.gui_h)
    gui.hideWidget(XAutoCopilot.btnstart)
    dref.setIntV(xac_state_start, 1, 1)
    event.register("OnUpdate", "OnUpdate_XAutoCopilot_btnStart")
end

function OnUpdate_XAutoCopilot_btnStart()

    if dref.getIntV(xac_state_start, 1, 1) == 1 then
        logging.debug("OnUpdate_XAutoCopilot_btnStart")
        dref.setInt(dref.getDataref("sim/custom/xap/fuel/t1_pump1"), 1) --Fuel Pumps|ON
        dref.setInt(dref.getDataref("sim/custom/xap/fuel/t1_pump2"), 1) --Fuel Pumps|ON
        dref.setInt(dref.getDataref("sim/custom/xap/fuel/t3_pump1"), 1) --Fuel Pumps|ON
        dref.setInt(dref.getDataref("sim/custom/xap/fuel/t3_pump2"), 1) --Fuel Pumps|ON
        dref.setInt(dref.getDataref("sim/custom/xap/fuel/t2_pump1"), 1) --Fuel Pumps|ON
        dref.setInt(dref.getDataref("sim/custom/xap/fuel/t2_pump2"), 1) --Fuel Pumps|ON
        dref.setInt(dref.getDataref("sim/custom/xap/disp/sys/mode"), 1) --ECAM FUEL Pumps|ALL GREEN
        dref.setInt(dref.getDataref("sim/custom/xap/engines/startsel"), 1) --Engine Mode Selector|IGN
        dref.setInt(dref.getDataref("sim/custom/xap/engines/eng2msw"), 1) --Eng2 Master|ON
        dref.setIntV(xac_state_start, 2, 1)
        dref.setIntV(xac_state_start, 1, 0)
    end

    if dref.getIntV(xac_state_start, 2, 1) == 1 and
            dref.getFloatV(dref.getDataref("sim/cockpit2/engine/indicators/N2_percent"), 2, 1) > 50.0 then
        dref.setInt(dref.getDataref("sim/custom/xap/engines/eng1msw"), 1) --Eng1 Master|ON
        dref.setIntV(xac_state_start, 3, 1)
        dref.setIntV(xac_state_start, 2, 0)
    end

    if dref.getIntV(xac_state_start, 3, 1) == 1 and
            dref.getFloatV(dref.getDataref("sim/cockpit2/engine/indicators/N2_percent"), 1, 1) > 50.0 then
        dref.setIntV(xac_state_start, 4, 1)
        dref.setIntV(xac_state_start, 3, 0)
        gui.hideWidget(XAutoCopilot.start)
        gui.showWidget(XAutoCopilot.btnafterstart)
        gui.showWidget(XAutoCopilot.afterstart)
        gui.showWindow(XAutoCopilot.gui_h)
        OnUpdate_XAutoCopilot_btnStart = nil
    end
end

--- -AFTER ENGINE START
function XAutoCopilot_btnafterStart_OnClick()
    dref.setString(xac_route_state, "AFTER ENGINE START")
    gui.hideWindow(XAutoCopilot.gui_h)
    gui.hideWidget(XAutoCopilot.btnafterstart)
    dref.setIntV(xac_state_afterstart, 1, 1)
    event.register("OnUpdate", "OnUpdate_XAutoCopilot_btnafterStart")
end

function OnUpdate_XAutoCopilot_btnafterStart()

    if dref.getIntV(xac_state_afterstart, 1, 1) == 1 then
        logging.debug("OnUpdate_XAutoCopilot_btnafterStart")

        dref.setInt(dref.getDataref("sim/custom/xap/engines/startsel"), 0) --Engine Mode Selector|NORM
        dref.setInt(dref.getDataref("sim/custom/xap/groundserv/show_tow"), 0) --Tow Truck|DISS
        dref.setFloat(dref.getDataref("sim/flightmodel/controls/parkbrake"), 1.0) --Parking Brake|ON
        dref.setInt(dref.getDataref("sim/custom/xap/wheels/ant_skeed"), 1) --Afterpush Antiskid|ON
        dref.setInt(dref.getDataref("sim/custom/xap/ewd_clr"), 0) --ECAM Anti Skid/NWS off Memo
        dref.setInt(dref.getDataref("sim/custom/xap/indicators/mastcaut"), 0) --Master Caution Button|CLEAR
        dref.setInt(dref.getDataref("sim/custom/xap/bleed/apu_blvlv"), 0) --Apu Bleed|OFF
        dref.setFloat(dref.getDataref("sim/cockpit2/controls/speedbrake_ratio"), -0.5) --Spoilers|ARM
        dref.setFloat(dref.getDataref("sim/cockpit2/controls/rudder_trim"), 0.0) --Rudder Trim|ZERO
-- TODO ANti Ice + APU check failure in Autocheck
        timer.newOneShot("AutoFlap", 2.0)
        --dref.setInt(dref.getDataref("sim/cockpit/engine/APU_switch"), 0) --Apu Master|OFF
        dref.setInt(dref.getDataref("sim/custom/xap/disp/sys/mode"), 9) --ECAM DOOR Condition|SLIDES ARMED
       -- dref.setIntV(xac_state_afterstart, 2, 1)
        dref.setIntV(xac_state_afterstart, 1, 0)
    end

    if dref.getIntV(xac_state_afterstart, 2, 1) == 1 then
        --dref.setInt(xac_click_perf, 1)
        gui.hideWidget(XAutoCopilot.afterstart)
        gui.showWidget(XAutoCopilot.btntaxi)
        gui.showWidget(XAutoCopilot.taxi)
        gui.showWidget(XAutoCopilot.fm)
        gui.showWidget(XAutoCopilot.chkFM)
        gui.showWindow(XAutoCopilot.gui_h)
        --dref.setIntV(xac_state_afterstart, 3, 1)
        dref.setIntV(xac_state_afterstart, 2, 0)
        OnUpdate_XAutoCopilot_btnafterStart = nil
    end
end

--- -TAXI
function XAutoCopilot_btnTaxi_OnClick()
    gui.hideWindow(XAutoCopilot.gui_h)
    gui.hideWidget(XAutoCopilot.btntaxi)
    gui.hideWidget(XAutoCopilot.fm)
    gui.hideWidget(XAutoCopilot.chkFM)

    dref.setIntV(xac_state_taxi, 1, 1)
    event.register("OnUpdate", "OnUpdate_XAutoCopilot_btnTaxi")
end
--
function XAutoCopilot_chkFM_OnClick()

    local chkFM = gui.getWidgetValue(XAutoCopilot.chkFM)
    if chkFM then
        --checked FM Car
        dref.setIntV(xac_state_chk_box, 3, 1)
    else
        --unchecked FM Car
        dref.setIntV(xac_state_chk_box, 3, 0)
    end
end

function OnUpdate_XAutoCopilot_btnTaxi()
    if dref.getIntV(xac_state_taxi, 1, 1) == 1 then
        logging.debug("OnUpdate_XAutoCopilot_btnTaxi")
        dref.setString(xac_route_state, "TAXI OUT")

        if dref.getIntV(xac_state_chk_box, 2, 1) == 1 then
            dref.setInt(dref.getDataref("sim/custom/xap/groundserv/gnd_fm_on"), 1)
        end
        -- speedcontrol
--        dref.setInt(xac_nose_sw, 1)
--        dref.setFloat(xac_parbrake, 0.0)
--        dref.setIntV(xac_state_taxi, 2, 1)
--        dref.setIntV(xac_state_taxi, 1, 0)
--        gui.hideWidget(XAutoCopilot.taxi)
--        gui.showWidget(XAutoCopilot.btnatholdingpoint)
--        gui.showWidget(XAutoCopilot.atholdingpoint)
--        gui.showWindow(XAutoCopilot.gui_h)
--        OnUpdate_XAutoCopilot_btnTaxi = nil
    end
end
--
--
--function XAutoCopilot_btnAtHoldingPoint_OnClick()
--    gui.hideWindow(XAutoCopilot.gui_h)
--    gui.hideWidget(XAutoCopilot.btnatholdingpoint)
--    dref.setIntV(xac_state_atholdingpoint, 1, 1)
--    event.register("OnUpdate", "OnUpdate_XAutoCopilot_btnAtHoldingPoint")
--end
--
--function OnUpdate_XAutoCopilot_btnAtHoldingPoint()
--    if dref.getIntV(xac_state_atholdingpoint, 1, 1) == 1 then
--        if dref.getIntV(xac_state_chk_box, 2, 1) == 1 then
--            dref.setInt(xac_fm_on, 0)
--        end
--        dref.setInt(xac_efifs_waether, 1)
--        dref.setIntV(xac_state_atholdingpoint, 2, 1)
--        dref.setIntV(xac_state_atholdingpoint, 1, 0)
--        gui.hideWidget(XAutoCopilot.atholdingpoint)
--        gui.showWidget(XAutoCopilot.btnlinedup)
--        gui.showWidget(XAutoCopilot.linedup)
--        gui.showWindow(XAutoCopilot.gui_h)
--        OnUpdate_XAutoCopilot_btnAtHoldingPoint = nil
--    end
--end
--
--
--function XAutoCopilot_btnLinedUp_OnClick()
--    gui.hideWindow(XAutoCopilot.gui_h)
--    gui.hideWidget(XAutoCopilot.btnlinedup)
--    dref.setIntV(xac_state_linedup, 1, 1)
--    event.register("OnUpdate", "OnUpdate_XAutoCopilot_btnLinedUp")
--end
--
--function OnUpdate_XAutoCopilot_btnLinedUp()
--    if dref.getIntV(xac_state_linedup, 1, 1) == 1 then
--        dref.setInt(xac_atc_mode_sel, 2)
--        dref.setInt(xac_atc_ta_tara, 2)
--        dref.setInt(xac_pack1, 0)
--        dref.setInt(xac_pack2, 0)
--        dref.setInt(xac_nose_sw, 2)
--        dref.setInt(xac_landr_sw, 2)
--        dref.setInt(xac_landl_sw, 2)
--        dref.setIntV(xac_state_linedup, 2, 1)
--        dref.setIntV(xac_state_linedup, 1, 0)
--        gui.hideWidget(XAutoCopilot.linedup)
--        gui.showWidget(XAutoCopilot.btntakeoff)
--        gui.showWidget(XAutoCopilot.takeoff)
--        gui.showWindow(XAutoCopilot.gui_h)
--        OnUpdate_XAutoCopilot_btnLinedUp = nil
--    end
--end
--
--function XAutoCopilot_btnTakeOff_OnClick()
--    gui.hideWindow(XAutoCopilot.gui_h)
--    gui.hideWidget(XAutoCopilot.btntakeoff)
--    dref.setIntV(xac_state_takeoff, 1, 1)
--    event.register("OnUpdate", "OnUpdate_XAutoCopilot_btnTakeOff")
--end
--
--function OnUpdate_XAutoCopilot_btnTakeOff()
--
--    if dref.getIntV(xac_state_takeoff, 1, 1) == 1 then
--        dref.setString(xac_route_state, "TAKEOFF")
--        dref.setInt(xac_pack1, 1)
--        dref.setInt(xac_pack2, 1)
--        dref.setIntV(xac_state_takeoff, 2, 1)
--        dref.setIntV(xac_state_takeoff, 3, 1)
--        dref.setIntV(xac_state_takeoff, 4, 1)
--        dref.setIntV(xac_state_takeoff, 5, 1)
--        dref.setIntV(xac_state_takeoff, 1, 0)
--    end
--
--    if dref.getIntV(xac_state_takeoff, 2, 1) == 1 and dref.getFloat(xac_altitude_ft_pilot) > 10000 then
--        --sound.say("passing 10000 feet")
--        dref.setInt(xac_landr_sw, 0)
--        dref.setInt(xac_landl_sw, 0)
--        dref.setInt(xac_nose_sw, 0)
--        dref.setInt(xac_click_perf, 1)
--        dref.setIntV(xac_state_takeoff, 2, 0)
--    end
--
--    if dref.getFloat(xac_altitude_ft_pilot) >= dref.getInt(xac_departure_transition) and dref.getIntV(xac_state_takeoff, 3, 1) == 1 then
--        dref.setInt(xac_baro_pull_bat, 1)
--        dref.setIntV(xac_state_takeoff, 3, 0)
--    end
--
--    local acf_alt_agl = acf.getAltAgl()
--    if dref.getIntV(xac_state_takeoff, 4, 1) == 1 and acf_alt_agl > 100 then
--        dref.setString(xac_route_state, "CLIMB")
--        dref.setInt(xac_nav_com_adf_mode, 2) -- VHF1 active
--        dref.setInt(xac_com1_stdby_freq_hz, dref.getInt(xac_daparture_station)) -- Set Departure Frequency on Standby COM1
--        dref.setIntV(xac_state_linedup, 4, 0)
--    end
--
--    if dref.getFloat(xac_altitude_ft_pilot) >= dref.getInt(xac_route_crzflinft) and dref.getIntV(xac_state_takeoff, 5, 1) == 1 then
--        dref.setString(xac_route_state, "CRUISE")
--        dref.setInt(xac_fasten_seat_belts, 0)
--        dref.setIntV(xac_state_linedup, 6, 1)
--        dref.setIntV(xac_state_linedup, 5, 0)
--        gui.hideWidget(XAutoCopilot.takeoff)
--        gui.showWidget(XAutoCopilot.btndescent)
--        gui.showWidget(XAutoCopilot.descent)
--        gui.showWindow(XAutoCopilot.gui_h)
--        OnUpdate_XAutoCopilot_btnTakeOff = nil
--    end
--end
--
--
--function XAutoCopilot_btnDescent_OnClick()
--    gui.hideWindow(XAutoCopilot.gui_h)
--    gui.hideWidget(XAutoCopilot.btndescent)
--    dref.setIntV(xac_state_descent, 1, 1)
--    event.register("OnUpdate", "OnUpdate_XAutoCopilot_btnDescent")
--end
--
--function OnUpdate_XAutoCopilot_btnDescent()
--
--    if string.find(dref.getString(xac_route_dir), "T/D") and dref.getIntV(xac_state_descent, 1, 1) == 1 and dref.getFloat(xac_gps_dme_dist_m) < 4.0 then
--        dref.setString(xac_route_state, "DESCENT")
--        dref.setInt(xac_fasten_seat_belts, 1)
--        dref.setInt(xac_alt_pull_bat, 1)
--        dref.setIntV(xac_state_descent, 2, 1)
--        dref.setIntV(xac_state_descent, 3, 1)
--        dref.setIntV(xac_state_descent, 1, 0)
--    end
--
--    if dref.getFloat(xac_altitude_ft_pilot) <= dref.getInt(xac_approach_transition) and dref.getIntV(xac_state_descent, 2, 1) == 1 then
--        dref.setInt(xac_baro_push_bat, 1)
--        local tmr_oneshot = timer.newOneShot("xac_set_approach_qnh", 5.0)
--        dref.setIntV(xac_state_descent, 2, 0)
--    end
--
--
--
--
--    if dref.getIntV(xac_state_descent, 3, 1) == 1 and dref.getFloat(xac_altitude_ft_pilot) < 10000 then
--        --sound.say("passing 10000 feet")
--        dref.setInt(xac_landr_sw, 2)
--        dref.setInt(xac_landl_sw, 2)
--        dref.setInt(xac_nose_sw, 2)
--        dref.setIntV(xac_state_descent, 4, 1)
--        dref.setIntV(xac_state_descent, 3, 0)
--        gui.hideWidget(XAutoCopilot.descent)
--        gui.showWindow(XAutoCopilot.gui_h)
--        OnUpdate_XAutoCopilot_btnDescent = nil
--    end
--
--    --spoilers arm
--end
--
--function xac_set_approach_qnh()
--    dref.setFloat(xac_barometer_setting, dref.getFloat(xac_approach_qnh_inHg)) --  set QNH Pilot
--    dref.setFloat(xac_barometer_setting2, dref.getFloat(xac_approach_qnh_inHg)) --  set QNH CoPilot
--end
--
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