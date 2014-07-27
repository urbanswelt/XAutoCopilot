--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 23.01.14
-- Time: 19:41
--



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
    XAutoCopilot.fm = gui.newLabel(XAutoCopilot.gui_h, "ignored", "WITH FM CAR", left, top, width)

    gui.hideWidget(XAutoCopilot.beforestart)
    gui.hideWidget(XAutoCopilot.start)
    gui.hideWidget(XAutoCopilot.afterstart)
    gui.hideWidget(XAutoCopilot.taxi)
    gui.hideWidget(XAutoCopilot.atholdingpoint)
    gui.hideWidget(XAutoCopilot.linedup)
    gui.hideWidget(XAutoCopilot.takeoff)
    gui.hideWidget(XAutoCopilot.descent)
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
    XAutoCopilot.chkFM = gui.newCheckbox(XAutoCopilot.gui_h, "XAutoCopilot_chkFM", "", left, top, width)

    gui.hideWidget(XAutoCopilot.btnbeforestart)
    gui.hideWidget(XAutoCopilot.btnstart)
    gui.hideWidget(XAutoCopilot.btnafterstart)
    gui.hideWidget(XAutoCopilot.btntaxi)
    gui.hideWidget(XAutoCopilot.btnatholdingpoint)
    gui.hideWidget(XAutoCopilot.btnlinedup)
    gui.hideWidget(XAutoCopilot.btntakeoff)
    gui.hideWidget(XAutoCopilot.btndescent)
    gui.hideWidget(XAutoCopilot.chkFM)
end



function XAutoCopilot_btnPreparation_OnClick()
    gui.hideWindow(XAutoCopilot.gui_h)
    gui.hideWidget(XAutoCopilot.btnpreparation)
    gui.hideWidget(XAutoCopilot.chkStair)
    gui.hideWidget(XAutoCopilot.stair)
    dref.setIntV(xac_state_preparation, 1, 1)
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

function OnUpdate_XAutoCopilot_btnPreparation()
    if dref.getIntV(xac_state_preparation, 1, 1) == 1 then
        dref.setInt(xac_cover_apu, 1)
        dref.setInt(xac_cover_dn_pres_port_l, 1)
        dref.setInt(xac_cover_dn_pres_port_ll, 1)
        dref.setInt(xac_cover_dn_pres_port_r, 1)
        dref.setInt(xac_cover_engine_l, 1)
        dref.setInt(xac_cover_engine_r, 1)
        dref.setInt(xac_cover_st_pres_port_lf, 1)
        dref.setInt(xac_cover_st_pres_port_lr, 1)
        dref.setInt(xac_cover_st_pres_port_rf, 1)
        dref.setInt(xac_cover_st_pres_port_rr, 1)
        dref.setInt(xac_chocks_l, 1)
        dref.setInt(xac_chocks_r, 1)
        dref.setInt(xac_cone, 1)
        dref.setInt(xac_nv_block_pin, 1)

        dref.setString(xac_route_state, "BOARDING")
        dref.setInt(xac_p_f_l_kn, 1)
        dref.setInt(xac_p_f_r_kn, 1)
        dref.setInt(xac_cater_on, 1)

        if dref.getIntV(xac_state_chk_box, 1, 1) == 1 then
            dref.setInt(xac_stair_on, 1)
        end

        dref.setInt(xac_eng1msw, 0)
        dref.setInt(xac_eng2msw, 0)
        dref.setInt(xac_startsel, 0)
        dref.setInt(xac_gear_handle_status, 1)
        dref.setInt(xac_gpu_here, 1)
        dref.setIntV(xac_state_preparation, 2, 1)
        dref.setIntV(xac_state_preparation, 1, 0)
    end

    if dref.getInt(xac_gpu_av) == 1 and dref.getInt(xac_gpu_run) == 1 and dref.getIntV(xac_state_preparation, 2, 1) == 1 then
        dref.setInt(xac_bat1_on, 1)
        dref.setInt(xac_bat2_on, 1)
        dref.setInt(xac_gpu_on, 1)
        --firetest--
        dref.setInt(xac_APU_switch, 1)
        dref.setInt(xac_start_pb, 1)
        dref.setIntV(xac_state_preparation, 3, 1)
        dref.setIntV(xac_state_preparation, 2, 0)
    end

    if dref.getInt(xac_start_pb) == 3 and dref.getIntV(xac_state_preparation, 3, 1) == 1 then
        dref.setInt(xac_gpu_on, 0)
        dref.setInt(xac_gpu_here, 0)
        --cabine light overhead panel--
        dref.setFloat(xac_parbrake, 1.0)
        dref.setInt(xac_yellow_pump, 1)
        dref.setFloat(xac_flap_ratio, 0.0)
        dref.setFloat(xac_speedbrake, 0.0)
        dref.setInt(xac_window_heat, 1)
        dref.setInt(xac_apu_blvlv, 1)
        dref.setInt(xac_bleed_mode_sw, 1)
        dref.setInt(xac_pack1, 1)
        dref.setInt(xac_pack2, 1)
        dref.setFloat(xac_temp_cock, 24.0)
        dref.setFloat(xac_temp_fwd_cab, 24.0)
        dref.setFloat(xac_temp_aft_cab, 24.0)
        --elac panel--
        --vent panel--
        dref.setInt(xac_adirs_data_sel, 3)
        dref.setInt(xac_adirs_sys_sel, 1)
        dref.setInt(xac_adirs_mode_sel_1, 1)
        dref.setIntV(xac_state_preparation, 4, 1)
        dref.setIntV(xac_state_preparation, 3, 0)
    end

    if dref.getInt(xac_adirs_on_bat) == 0 and dref.getIntV(xac_state_preparation, 4, 1) == 1 then
        dref.setInt(xac_adirs_mode_sel_3, 1)
        dref.setIntV(xac_state_preparation, 5, 1)
        dref.setIntV(xac_state_preparation, 4, 0)
    end

    if dref.getInt(xac_adirs_on_bat) == 0 and dref.getIntV(xac_state_preparation, 5, 1) == 1 then
        dref.setInt(xac_adirs_mode_sel_2, 1)
        dref.setInt(xac_adirs_enter, 1)
        dref.setInt(xac_emer_ext_lt, 1)
        dref.setInt(xac_alt_rot, 0)
        --xac_firetest_e1--
        --xac_firetest_e2--
        dref.setInt(xac_strobe_sw, 1)
        dref.setInt(xac_navlogo_sw, 1)
        dref.setInt(xac_radio_on, 1)
        --radio set--
        --altimter std--
        --ATC clearance--
        dref.setInt(xac_fcu_fd, 1)
        dref.setInt(xac_fcu_ils, 0)
        --nav mode--
        --clock--
        dref.setInt(xac_atc_mode_sel, 0)
        dref.setInt(xac_atc_ta_tara, 0)
        dref.setInt(xac_ant_skeed, 1)
        dref.setInt(xac_efifs_waether, 0)
        dref.setFloatV(xac_engn_thro, 1, 0.0, 0.0)
        dref.setInt(xac_tanker_on, 1)
        dref.setInt(xac_load_on, 1)
        gui.showWindow(XAutoCopilotRoute.gui_h)
        dref.setIntV(xac_state_preparation, 6, 1)
        dref.setIntV(xac_state_preparation, 5, 0)
    end

    if string.find(dref.getString(xac_adirs_disp), "ALIGNED") and dref.getIntV(xac_state_preparation, 6, 1) == 1 then
        sound.say("Cockpit Preparation is finish.")
        dref.setIntV(xac_state_preparation, 7, 1)
        dref.setIntV(xac_state_preparation, 6, 0)
        gui.hideWidget(XAutoCopilot.preparation)
        gui.showWidget(XAutoCopilot.btnbeforestart)
        gui.showWidget(XAutoCopilot.beforestart)
        gui.showWindow(XAutoCopilot.gui_h)
        OnUpdate_XAutoCopilot_btnPreparation = nil
    end
    -- ##################################Preparation END##############################################
end

function XAutoCopilot_btnbeforeStart_OnClick()
    gui.hideWindow(XAutoCopilot.gui_h)
    gui.hideWidget(XAutoCopilot.btnbeforestart)
    dref.setIntV(xac_state_beforestart, 1, 1)
    event.register("OnUpdate", "OnUpdate_XAutoCopilot_btnbeforeStart")
end

function OnUpdate_XAutoCopilot_btnbeforeStart()
    if dref.getIntV(xac_state_beforestart, 1, 1) == 1 then
        dref.setInt(xac_tanker_on, 0)
        dref.setInt(xac_load_on, 0)
        dref.setInt(xac_p_f_l_kn, 0)
        dref.setInt(xac_p_f_r_kn, 0)
        dref.setInt(xac_p_b_l_kn, 0)
        dref.setInt(xac_p_b_r_kn, 0)
        dref.setInt(xac_c_f_kn, 0)
        dref.setInt(xac_c_b_kn, 0)
        dref.setInt(xac_cater_on, 0)

        if dref.getIntV(xac_state_chk_box, 1, 1) == 1 then
            dref.setInt(xac_stair_on, 0)
        end

        dref.setIntV(xac_state_beforestart, 2, 1)
        dref.setIntV(xac_state_beforestart, 1, 0)
    end

    if dref.getIntV(xac_state_beforestart, 2, 1) == 1 and
            dref.getFloat(xac_p_f_l_now) == 0.0 and
            dref.getFloat(xac_p_f_r_now) == 0.0 and
            dref.getFloat(xac_p_b_l_now) == 0.0 and
            dref.getFloat(xac_p_b_r_now) == 0.0 and
            dref.getFloat(xac_c_f_now) == 0.0 and
            dref.getFloat(xac_c_b_now) == 0.0 and
            dref.getFloat(xac_move_to_cater) > 19.0
        -- dref.getFloat(xac_move_to_stair) > 37.0
    then
        dref.setInt(xac_show_cater, 0)
        dref.setInt(xac_show_stair, 0)
        dref.setInt(xac_show_tanker, 0)
        dref.setInt(xac_load_on, 0)
        dref.setInt(xac_fasten_seat_belts, 1)
        dref.setInt(xac_no_smoking, 1)
        dref.setInt(xac_beacon_sw, 1)
        dref.setIntV(xac_state_beforestart, 3, 1)
        dref.setIntV(xac_state_beforestart, 2, 0)
        gui.hideWidget(XAutoCopilot.beforestart)
        gui.showWidget(XAutoCopilot.btnstart)
        gui.showWidget(XAutoCopilot.start)
        gui.showWindow(XAutoCopilot.gui_h)
        OnUpdate_XAutoCopilot_btnbeforeStart = nil
    end
end

function XAutoCopilot_btnStart_OnClick()
    gui.hideWindow(XAutoCopilot.gui_h)
    gui.hideWidget(XAutoCopilot.btnstart)
    dref.setIntV(xac_state_start, 1, 1)
    event.register("OnUpdate", "OnUpdate_XAutoCopilot_btnStart")
end

function OnUpdate_XAutoCopilot_btnStart()

    if dref.getIntV(xac_state_start, 1, 1) == 1 then
        dref.setInt(xac_t1_pump1, 1)
        dref.setInt(xac_t1_pump2, 1)
        dref.setInt(xac_t2_pump1, 1)
        dref.setInt(xac_t2_pump2, 1)
        dref.setInt(xac_t3_pump1, 1)
        dref.setInt(xac_t3_pump2, 1)
        dref.setInt(xac_startsel, 1)
        dref.setInt(xac_eng1msw, 1)
        dref.setIntV(xac_state_start, 2, 1)
        dref.setIntV(xac_state_start, 1, 0)
    end

    if dref.getIntV(xac_state_start, 2, 1) == 1 and
            dref.getFloatV(xac_n2_percent, 1, 1) > 50.0 then
        dref.setInt(xac_eng2msw, 1)
        dref.setIntV(xac_state_start, 3, 1)
        dref.setIntV(xac_state_start, 2, 0)
    end

    if dref.getIntV(xac_state_start, 3, 1) == 1 and
            dref.getFloatV(xac_n2_percent, 2, 1) > 50.0 then
        dref.setIntV(xac_state_start, 4, 1)
        dref.setIntV(xac_state_start, 3, 0)
        gui.hideWidget(XAutoCopilot.start)
        gui.showWidget(XAutoCopilot.btnafterstart)
        gui.showWidget(XAutoCopilot.afterstart)
        gui.showWindow(XAutoCopilot.gui_h)
        OnUpdate_XAutoCopilot_btnStart = nil
    end
end

function XAutoCopilot_btnafterStart_OnClick()
    gui.hideWindow(XAutoCopilot.gui_h)
    gui.hideWidget(XAutoCopilot.btnafterstart)
    dref.setIntV(xac_state_afterstart, 1, 1)
    event.register("OnUpdate", "OnUpdate_XAutoCopilot_btnafterStart")
end

function OnUpdate_XAutoCopilot_btnafterStart()

    if dref.getIntV(xac_state_afterstart, 1, 1) == 1 then
        dref.setInt(xac_startsel, 0)
        dref.setInt(xac_apu_blvlv, 0)
        dref.setInt(xac_pack1, 1)
        dref.setInt(xac_pack2, 1)
        dref.setFloat(xac_speedbrake, -0.5)
        dref.setInt(xac_brake_auto_max, 1)
        dref.setFloat(xac_rudder_trim, 0.0)
        dref.setInt(xac_APU_switch, 0)
        dref.setIntV(xac_state_afterstart, 2, 1)
        dref.setIntV(xac_state_afterstart, 1, 0)
    end

    if dref.getIntV(xac_state_afterstart, 2, 1) == 1 then
        dref.setInt(xac_click_perf, 1)
        dref.setIntV(xac_state_afterstart, 3, 1)
        dref.setIntV(xac_state_afterstart, 2, 0)
        timer.newOneShot("AutoFlap", 2.0)
        gui.hideWidget(XAutoCopilot.afterstart)
        gui.showWidget(XAutoCopilot.btntaxi)
        gui.showWidget(XAutoCopilot.taxi)
        gui.showWidget(XAutoCopilot.fm)
        gui.showWidget(XAutoCopilot.chkFM)
        gui.showWindow(XAutoCopilot.gui_h)
        OnUpdate_XAutoCopilot_btnafterStart = nil
    end
end

function XAutoCopilot_btnTaxi_OnClick()
    gui.hideWindow(XAutoCopilot.gui_h)
    gui.hideWidget(XAutoCopilot.btntaxi)
    gui.hideWidget(XAutoCopilot.fm)
    gui.hideWidget(XAutoCopilot.chkFM)

    dref.setIntV(xac_state_taxi, 1, 1)
    event.register("OnUpdate", "OnUpdate_XAutoCopilot_btnTaxi")
end

function XAutoCopilot_chkFM_OnClick()

    local chkFM = gui.getWidgetValue(XAutoCopilot.chkFM)
    if chkFM then
        --checked FM Car
        dref.setIntV(xac_state_chk_box, 2, 1)
    else
        --unchecked FM Car
        dref.setIntV(xac_state_chk_box, 2, 0)
    end
end

function OnUpdate_XAutoCopilot_btnTaxi()
    if dref.getIntV(xac_state_taxi, 1, 1) == 1 then
        dref.setString(xac_route_state, "TAXI OUT")

        if dref.getIntV(xac_state_chk_box, 2, 1) == 1 then
            dref.setInt(xac_fm_on, 1)
        end
        -- speedcontrol
        dref.setInt(xac_nose_sw, 1)
        dref.setFloat(xac_parbrake, 0.0)
        dref.setIntV(xac_state_taxi, 2, 1)
        dref.setIntV(xac_state_taxi, 1, 0)
        gui.hideWidget(XAutoCopilot.taxi)
        gui.showWidget(XAutoCopilot.btnatholdingpoint)
        gui.showWidget(XAutoCopilot.atholdingpoint)
        gui.showWindow(XAutoCopilot.gui_h)
        OnUpdate_XAutoCopilot_btnTaxi = nil
    end
end


function XAutoCopilot_btnAtHoldingPoint_OnClick()
    gui.hideWindow(XAutoCopilot.gui_h)
    gui.hideWidget(XAutoCopilot.btnatholdingpoint)
    dref.setIntV(xac_state_atholdingpoint, 1, 1)
    event.register("OnUpdate", "OnUpdate_XAutoCopilot_btnAtHoldingPoint")
end

function OnUpdate_XAutoCopilot_btnAtHoldingPoint()
    if dref.getIntV(xac_state_atholdingpoint, 1, 1) == 1 then
        if dref.getIntV(xac_state_chk_box, 2, 1) == 1 then
            dref.setInt(xac_fm_on, 0)
        end
        dref.setInt(xac_efifs_waether, 1)
        dref.setIntV(xac_state_atholdingpoint, 2, 1)
        dref.setIntV(xac_state_atholdingpoint, 1, 0)
        gui.hideWidget(XAutoCopilot.atholdingpoint)
        gui.showWidget(XAutoCopilot.btnlinedup)
        gui.showWidget(XAutoCopilot.linedup)
        gui.showWindow(XAutoCopilot.gui_h)
        OnUpdate_XAutoCopilot_btnAtHoldingPoint = nil
    end
end


function XAutoCopilot_btnLinedUp_OnClick()
    gui.hideWindow(XAutoCopilot.gui_h)
    gui.hideWidget(XAutoCopilot.btnlinedup)
    dref.setIntV(xac_state_linedup, 1, 1)
    event.register("OnUpdate", "OnUpdate_XAutoCopilot_btnLinedUp")
end

function OnUpdate_XAutoCopilot_btnLinedUp()
    if dref.getIntV(xac_state_linedup, 1, 1) == 1 then
        dref.setInt(xac_atc_mode_sel, 2)
        dref.setInt(xac_atc_ta_tara, 2)
        dref.setInt(xac_pack1, 0)
        dref.setInt(xac_pack2, 0)
        dref.setInt(xac_nose_sw, 2)
        dref.setInt(xac_landr_sw, 2)
        dref.setInt(xac_landl_sw, 2)
        dref.setIntV(xac_state_linedup, 2, 1)
        dref.setIntV(xac_state_linedup, 1, 0)
        gui.hideWidget(XAutoCopilot.linedup)
        gui.showWidget(XAutoCopilot.btntakeoff)
        gui.showWidget(XAutoCopilot.takeoff)
        gui.showWindow(XAutoCopilot.gui_h)
        OnUpdate_XAutoCopilot_btnLinedUp = nil
    end
end

function XAutoCopilot_btnTakeOff_OnClick()
    gui.hideWindow(XAutoCopilot.gui_h)
    gui.hideWidget(XAutoCopilot.btntakeoff)
    dref.setIntV(xac_state_takeoff, 1, 1)
    event.register("OnUpdate", "OnUpdate_XAutoCopilot_btnTakeOff")
end

function OnUpdate_XAutoCopilot_btnTakeOff()

    if dref.getIntV(xac_state_takeoff, 1, 1) == 1 then
        dref.setString(xac_route_state, "TAKEOFF")
        dref.setInt(xac_pack1, 1)
        dref.setInt(xac_pack2, 1)
        dref.setIntV(xac_state_takeoff, 2, 1)
        dref.setIntV(xac_state_takeoff, 3, 1)
        dref.setIntV(xac_state_takeoff, 4, 1)
        dref.setIntV(xac_state_takeoff, 5, 1)
        dref.setIntV(xac_state_takeoff, 1, 0)
    end

    if dref.getIntV(xac_state_takeoff, 2, 1) == 1 and dref.getFloat(xac_altitude_ft_pilot) > 10000 then
        --sound.say("passing 10000 feet")
        dref.setInt(xac_landr_sw, 0)
        dref.setInt(xac_landl_sw, 0)
        dref.setInt(xac_nose_sw, 0)
        dref.setInt(xac_click_perf, 1)
        dref.setIntV(xac_state_takeoff, 2, 0)
    end

    if dref.getFloat(xac_altitude_ft_pilot) >= dref.getInt(xac_departure_transition) and dref.getIntV(xac_state_takeoff, 3, 1) == 1 then
        dref.setInt(xac_push_baro, 1)
        dref.setIntV(xac_state_takeoff, 3, 0)
    end

    local acf_alt_agl = acf.getAltAgl()
    if dref.getIntV(xac_state_takeoff, 4, 1) == 1 and acf_alt_agl > 100 then
        dref.setString(xac_route_state, "CLIMB")
        dref.setInt(xac_nav_com_adf_mode, 2) -- VHF1 active
        dref.setInt(xac_com1_stdby_freq_hz, dref.getInt(xac_daparture_station)) -- Set Departure Frequency on Standby COM1
        dref.setIntV(xac_state_linedup, 4, 0)
    end

    if dref.getFloat(xac_altitude_ft_pilot) >= dref.getInt(xac_route_crzflinft) and dref.getIntV(xac_state_takeoff, 5, 1) == 1 then
        dref.setString(xac_route_state, "CRUISE")
        dref.setInt(xac_fasten_seat_belts, 0)
        dref.setIntV(xac_state_linedup, 6, 1)
        dref.setIntV(xac_state_linedup, 5, 0)
        gui.hideWidget(XAutoCopilot.takeoff)
        gui.showWidget(XAutoCopilot.btndescent)
        gui.showWidget(XAutoCopilot.descent)
        gui.showWindow(XAutoCopilot.gui_h)
        OnUpdate_XAutoCopilot_btnTakeOff = nil
    end
end


function XAutoCopilot_btnDescent_OnClick()
    gui.hideWindow(XAutoCopilot.gui_h)
    gui.hideWidget(XAutoCopilot.btndescent)
    dref.setIntV(xac_state_descent, 1, 1)
    event.register("OnUpdate", "OnUpdate_XAutoCopilot_btnDescent")
end

function OnUpdate_XAutoCopilot_btnDescent()

    if string.find(dref.getString(xac_route_dir), "T/D") and dref.getIntV(xac_state_descent, 1, 1) == 1 and dref.getFloat(xac_gps_dme_dist_m) < 4.0 then
        dref.setString(xac_route_state, "DESCENT")
        dref.setInt(xac_fasten_seat_belts, 1)
        dref.setInt(xac_alt_pull_bat, 1)
        dref.setIntV(xac_state_descent, 2, 1)
        dref.setIntV(xac_state_descent, 3, 1)
        dref.setIntV(xac_state_descent, 1, 0)
    end

    if dref.getFloat(xac_altitude_ft_pilot) <= dref.getInt(xac_approach_transition) and dref.getIntV(xac_state_descent, 2, 1) == 1 then
        dref.setInt(xac_push_baro, 1)
        dref.setFloat(xac_barometer_setting, dref.getFloat(xac_approach_qnh_inHg)) --  set QNH Pilot
        dref.setFloat(xac_barometer_setting2, dref.getFloat(xac_approach_qnh_inHg)) --  set QNH CoPilot
        dref.setIntV(xac_state_descent, 2, 0)
    end

    if dref.getIntV(xac_state_descent, 3, 1) == 1 and dref.getFloat(xac_altitude_ft_pilot) < 10000 then
        --sound.say("passing 10000 feet")
        dref.setInt(xac_landr_sw, 2)
        dref.setInt(xac_landl_sw, 2)
        dref.setInt(xac_nose_sw, 2)
        dref.setIntV(xac_state_descent, 4, 1)
        dref.setIntV(xac_state_descent, 3, 0)
        gui.hideWidget(XAutoCopilot.descent)
        gui.showWindow(XAutoCopilot.gui_h)
        OnUpdate_XAutoCopilot_btnDescent = nil
    end

    --spoilers arm
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


