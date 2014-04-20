--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 25.01.14
-- Time: 15:51
--

function XAutoCopilot_OnUpdate()

-- Cockpit preparation checklist

    if XAutoCopilot_btnPreparation_State == 1 then
        dref.setInt(xac_p_f_l_kn, 1)
        dref.setInt(xac_p_f_r_kn, 1)
        dref.setInt(xac_cater_on, 1)
        dref.setInt(xac_stair_on, 1)
        dref.setInt(xac_eng1msw, 0)
        dref.setInt(xac_eng2msw, 0)
        dref.setInt(xac_startsel, 0)
        dref.setInt(xac_gear_handle_status, 1)
        dref.setInt(xac_gpu_here, 1)
        prepstate1 = 1
        XAutoCopilot_btnPreparation_State = 0
    end

    if dref.getInt( xac_gpu_av )== 1 and dref.getInt( xac_gpu_run )== 1 and prepstate1 == 1 then
        dref.setInt(xac_bat1_on, 1)
        dref.setInt(xac_bat2_on, 1)
        dref.setInt(xac_gpu_on, 1)
        --firetest--
        dref.setInt(xac_APU_switch, 1)
        dref.setInt(xac_start_pb, 1)
        prepstate2 = 1
        prepstate1 = 0
    end

    if dref.getInt( xac_start_pb )== 3  and prepstate2 == 1 then
        dref.setInt(xac_gpu_on, 0)
        dref.setInt(xac_gpu_here, 0)
        --cabine light overhead panel--
        dref.setInt(xac_parbrake, 1)
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
        prepstate3 = 1
        prepstate2 = 0
    end

    if dref.getInt( xac_adirs_on_bat )== 0  and prepstate3 == 1 then
        dref.setInt(xac_adirs_mode_sel_3, 1)
        prepstate4 = 1
        prepstate3 = 0
    end

    if dref.getInt( xac_adirs_on_bat )== 0  and prepstate4 == 1 then
        dref.setInt(xac_adirs_mode_sel_2, 1)
        dref.setInt(xac_adirs_enter, 1)
        dref.setInt(xac_emer_ext_lt, 1)
        dref.setInt(xac_alt_rot, 0)
        --xac_firetest_e1--
        --xac_firetest_e2--
        dref.setInt(xac_strobe_sw, 1)
        dref.setInt(xac_radio_on, 1)
        --radio set--
        --altimter std--
        --ATC clearance--
        dref.setInt(xac_fcu_fd, 1)
        dref.setInt(xac_fcu_ils, 0)
        --nav mode--
        --clock--
        --mcdu--
        dref.setInt(xac_atc_mode_sel, 0)
        dref.setInt(xac_atc_ta_tara, 0)
        dref.setInt(xac_ant_skeed, 1)
        dref.setInt(xac_efifs_waether, 0)
        dref.setFloatV(xac_engn_thro, 1, 0.0, 0.0)
        prepstate5 = 1
        prepstate4 = 0
    end

    xac_adirs_disp_temp = dref.getString(xac_adirs_disp)

    if string.find(xac_adirs_disp_temp, "ALIGNED") and prepstate5 == 1 then
        sound.say("Cockpit Preparation is finish. Sir !.")
        prepstate5 = 0
        preparation_finish = 1
    end



-- befor start checklist
    if XAutoCopilot_btnBeforeStart_State == 1  and preparation_finish == 1 then
        dref.setInt(xac_p_f_l_kn , 0)
        dref.setInt(xac_p_f_r_kn , 0)
        dref.setInt(xac_p_b_l_kn , 0)
        dref.setInt(xac_p_b_r_kn , 0)
        dref.setInt(xac_c_f_kn , 0)
        dref.setInt(xac_c_b_kn , 0)
        dref.setInt(xac_cater_on, 0)
        dref.setInt(xac_stair_on, 0)
        beforestartstate1 = 1
        XAutoCopilot_btnBeforeStart_State = 0
    end

    if beforestartstate1 == 1 and
       dref.getFloat( xac_p_f_l_now )== 0.0 and
       dref.getFloat( xac_p_f_r_now )== 0.0 and
       dref.getFloat( xac_p_b_l_now )== 0.0 and
       dref.getFloat( xac_p_b_r_now )== 0.0 and
       dref.getFloat( xac_c_f_now )== 0.0 and
       dref.getFloat( xac_c_b_now )== 0.0 and
       dref.getFloat( xac_move_to_cater )> 19.0 and
       dref.getFloat( xac_move_to_stair )> 37.0
    then
        dref.setInt(xac_show_cater , 0)
        dref.setInt(xac_show_stair , 0)
        dref.setInt(xac_fasten_seat_belts , 1)
        dref.setInt(xac_no_smoking , 1)
        dref.setInt(xac_beacon_sw , 1)
        beforestartstate1 = 0
        beforestart_finish = 1
    end
-- onboard auto-checklist

-- pushback
    if XAutoCopilot_btnPushback_State == 1 and
       beforestart_finish == 1 and
       xac_show_tow == 1 then
        -- dref .....
        pushback_finish = 1
        XAutoCopilot_btnPushback_State = 0
    end

-- engine start

    if XAutoCopilot_btnEngineStart_State == 1 then
        dref.setInt(xac_t1_pump1 , 1)
        dref.setInt(xac_t1_pump2 , 1)
        dref.setInt(xac_t2_pump1 , 1)
        dref.setInt(xac_t2_pump2 , 1)
        dref.setInt(xac_t3_pump1 , 1)
        dref.setInt(xac_t3_pump2 , 1)
        dref.setInt(xac_startsel , 1)
        dref.setInt(xac_eng1msw, 1)
        enginestartstate1 = 1
        XAutoCopilot_btnEngineStart_State = 0
    end

    if enginestartstate1 == 1 and
    dref.getFloatV( xac_n2_percent,1,1 )> 50.0 then
        dref.setInt(xac_eng2msw, 1)
        enginestartstate1 = 0
        enginestartstate2 = 1
    end

    if enginestartstate2 == 1 and
    dref.getFloatV( xac_n2_percent,2,1 )> 50.0 then
    sound.say("Engine start finish. Sir !.")
    enginestartstate2 = 0
    enginestart_finish = 1
    end

    -- after engine start
    if XAutoCopilot_btnAfterEngineStart_State == 1 then
        dref.setInt(xac_startsel , 0)
        dref.setInt(xac_apu_blvlv, 0)
        dref.setInt(xac_pack1, 1)
        dref.setInt(xac_pack2, 1)
        dref.setFloat(xac_speedbrake, -0.5)
        dref.setInt(xac_brake_auto_max, 1)
        dref.setFloat(xac_rudder_trim, 0.0)
        dref.setInt(xac_APU_switch, 0)
        afterenginestartstate1 = 1
        XAutoCopilot_btnAfterEngineStart_State = 0

    end

    xac_test = dref.getString(xac_line_3b)
    if afterenginestartstate1 == 1 then
        dref.setInt(xac_click_perf, 1)
        afterenginestartstate2 = 1
        afterenginestartstate1 = 0
        timer.newOneShot("test", 2.0)
    end

    function test()

        -- flap adjust from mcdu menu
        -- flap 0 = 0.0
        -- flap 1 = 0.4
        -- flap 2 = 0.6
        -- flap 3 = 0.8
        -- flap 4 = 1.0

        if string.find(xac_test, "0/") and afterenginestartstate2 == 1 then
            dref.setFloat(xac_flap, 0.0)
            afterenginestart_finish = 1
            afterenginestartstate2 = 0
        end

        if string.find(xac_test, "1/") and afterenginestartstate2 == 1 then
            dref.setFloat(xac_flap, 0.4)
            afterenginestart_finish = 1
            afterenginestartstate2 = 0
        end

        if string.find(xac_test, "2/") and afterenginestartstate2 == 1 then
            dref.setFloat(xac_flap, 0.6)
            afterenginestart_finish = 1
            afterenginestartstate2 = 0
        end

        if string.find(xac_test, "3/") and afterenginestartstate2 == 1 then
            dref.setFloat(xac_flap, 0.8)
            afterenginestart_finish = 1
            afterenginestartstate2 = 0
        end

        if string.find(xac_test, "4/") and afterenginestartstate2 == 1 then
            dref.setFloat(xac_flap, 1.0)
            afterenginestart_finish = 1
            afterenginestartstate2 = 0
        end
    end


    -- auto anti ice

    if dref.getFloat( xac_outside_air_temp_degc )< 0.0 and dref.getFloatV( xac_n2_percent,2,1 )> 50.0 then
        dref.setInt(xac_ice_eng1_knob, 1)
        dref.setInt(xac_ice_eng2_knob, 1)
        dref.setInt(xac_ice_window, 1)
        dref.setInt(xac_ice_wing_knob, 1)
    end

    if dref.getFloat( xac_outside_air_temp_degc )> 1.0 and dref.getFloatV( xac_n2_percent,2,1 )> 50.0 then
        dref.setInt(xac_ice_eng1_knob, 0)
        dref.setInt(xac_ice_eng2_knob, 0)
        dref.setInt(xac_ice_window, 0)
        dref.setInt(xac_ice_wing_knob, 0)
    end




end

function XAutoCopilot_OnBeforeClose() end
