--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 25.01.14
-- Time: 15:51
--

function XAutoCopilot_OnUpdate()

-- ##################################Preparation BEGIN##############################################

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
        dref.setFloat(xac_parbrake , 1.0)
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
        dref.setInt(xac_atc_mode_sel, 0)
        dref.setInt(xac_atc_ta_tara, 0)
        dref.setInt(xac_ant_skeed, 1)
        dref.setInt(xac_efifs_waether, 0)
        dref.setFloatV(xac_engn_thro, 1, 0.0, 0.0)
		dref.setInt(xac_tanker_on, 1)
		dref.setInt(xac_load_on, 1)
        gui.showWindow( XAutoCopilotMcdu.gui_h )
        prepstate5 = 1
        prepstate4 = 0
    end

    xac_adirs_disp_temp = dref.getString(xac_adirs_disp)

    if string.find(xac_adirs_disp_temp, "ALIGNED") and prepstate5 == 1 then
        sound.say("Cockpit Preparation is finish.")
        prepstate5 = 0
        preparation_finish = 1
    end

-- ##################################Preparation END##############################################


-- ##################################Start BEGIN##############################################
-- befor start checklist
    if XAutoCopilot_btnStart_State == 1  and preparation_finish == 1 or
       XAutoCopilot_btnStart_State == 1 and xac_debugon == 1 then
	    dref.setInt(xac_tanker_on, 0)
		dref.setInt(xac_load_on, 0)
        dref.setInt(xac_p_f_l_kn , 0)
        dref.setInt(xac_p_f_r_kn , 0)
        dref.setInt(xac_p_b_l_kn , 0)
        dref.setInt(xac_p_b_r_kn , 0)
        dref.setInt(xac_c_f_kn , 0)
        dref.setInt(xac_c_b_kn , 0)
        dref.setInt(xac_cater_on, 0)
        dref.setInt(xac_stair_on, 0)
        beforestartstate1 = 1
        XAutoCopilot_btnStart_State = 0
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
        dref.setInt(xac_tanker_on, 0)
        dref.setInt(xac_load_on, 0)
        dref.setInt(xac_fasten_seat_belts , 1)
        dref.setInt(xac_no_smoking , 1)
        dref.setInt(xac_beacon_sw , 1)
        beforestart_finish = 1
        beforestartstate1 = 0

    end
-- onboard auto-checklist

-- engine start

    if beforestart_finish == 1 then
        dref.setInt(xac_t1_pump1 , 1)
        dref.setInt(xac_t1_pump2 , 1)
        dref.setInt(xac_t2_pump1 , 1)
        dref.setInt(xac_t2_pump2 , 1)
        dref.setInt(xac_t3_pump1 , 1)
        dref.setInt(xac_t3_pump2 , 1)
        dref.setInt(xac_startsel , 1)
        dref.setInt(xac_eng1msw, 1)
        enginestartstate1 = 1
        beforestart_finish = 0
    end

    if enginestartstate1 == 1 and
    dref.getFloatV( xac_n2_percent,1,1 )> 50.0 then
        dref.setInt(xac_eng2msw, 1)
        enginestartstate2 = 1
        enginestartstate1 = 0
    end

    if enginestartstate2 == 1 and
    dref.getFloatV( xac_n2_percent,2,1 )> 50.0 then
    enginestartstate2 = 0
    enginestart_finish = 1
    end

    -- after engine start
    if enginestart_finish == 1 then
        dref.setInt(xac_startsel , 0)
        dref.setInt(xac_apu_blvlv, 0)
        dref.setInt(xac_pack1, 1)
        dref.setInt(xac_pack2, 1)
        dref.setFloat(xac_speedbrake, -0.5)
        dref.setInt(xac_brake_auto_max, 1)
        dref.setFloat(xac_rudder_trim, 0.0)
        dref.setInt(xac_APU_switch, 0)
        afterenginestartstate1 = 1
        enginestart_finish = 0

    end

    xac_AutoFlap = dref.getString(xac_line_3b)
    if afterenginestartstate1 == 1 then
        dref.setInt(xac_click_perf, 1)
        afterenginestartstate2 = 1
        afterenginestartstate1 = 0
        timer.newOneShot("AutoFlap", 2.0)
        timer.newOneShot("QNH", 4.0)
    end

    function AutoFlap()

        -- flap adjust from mcdu menu
        -- flap 0 = 0.0
        -- flap 1 = 0.4
        -- flap 2 = 0.6
        -- flap 3 = 0.8
        -- flap 4 = 1.0

        if string.find(xac_AutoFlap, "0/") and afterenginestartstate2 == 1 then
            dref.setFloat(xac_flap, 0.0)
            afterenginestart_finish = 1
            afterenginestartstate2 = 0
        end

        if string.find(xac_AutoFlap, "1/") and afterenginestartstate2 == 1 then
            dref.setFloat(xac_flap, 0.4)
            afterenginestart_finish = 1
            afterenginestartstate2 = 0
        end

        if string.find(xac_AutoFlap, "2/") and afterenginestartstate2 == 1 then
            dref.setFloat(xac_flap, 0.6)
            afterenginestart_finish = 1
            afterenginestartstate2 = 0
        end

        if string.find(xac_AutoFlap, "3/") and afterenginestartstate2 == 1 then
            dref.setFloat(xac_flap, 0.8)
            afterenginestart_finish = 1
            afterenginestartstate2 = 0
        end

        if string.find(xac_AutoFlap, "4/") and afterenginestartstate2 == 1 then
            dref.setFloat(xac_flap, 1.0)
            afterenginestart_finish = 1
            afterenginestartstate2 = 0
        end
    end

-- ##################################Start END##############################################

function QNH()
    if (math.abs(dref.getFloat(xac_barometer_setting_in_hg_pilot)-dref.getFloat(xac_barometer_sealevel_inhg)) > 0.01) then
        dref.setFloat(xac_barometer_setting_in_hg_pilot,   dref.getFloat(xac_barometer_sealevel_inhg))
        dref.setFloat(xac_barometer_setting_in_hg_copilot, dref.getFloat(xac_barometer_sealevel_inhg))
        sound.say("QNH adjusted!")
    end
end

-- taxi

    if XAutoCopilot_btnTaxi_State == 1 and
       afterenginestart_finish == 1 or XAutoCopilot_btnTaxi_State == 1 and xac_debugon == 1 then
        dref.setInt(xac_fm_on , 1)
        -- speedcontrol
        dref.setInt(xac_nose_sw , 1)
        dref.setFloat(xac_parbrake , 0.0)
        taxi_finish = 1
        XAutoCopilot_btnTaxi_State = 0
    end

-- holding point

    if XAutoCopilot_btnAtHoldingPoint_State == 1 and
       taxi_finish == 1 or XAutoCopilot_btnAtHoldingPoint_State == 1 and xac_debugon == 1 then
        dref.setInt(xac_fm_on , 0)
        dref.setInt(xac_efifs_waether, 1)
        atholdingpoint_finish = 1
        XAutoCopilot_btnAtHoldingPoint_State = 0
    end

-- lined up

    if XAutoCopilot_btnLinedUp_State == 1 and
        atholdingpoint_finish == 1 or XAutoCopilot_btnLinedUp_State == 1 and xac_debugon == 1 then
        dref.setInt(xac_atc_mode_sel, 2)
        dref.setInt(xac_atc_ta_tara, 2)
        dref.setInt(xac_pack1, 0)
        dref.setInt(xac_pack2, 0)
        dref.setInt(xac_nose_sw, 2)
        dref.setInt(xac_landr_sw, 2)
        dref.setInt(xac_landl_sw, 2)
        linedup_finish = 1
        XAutoCopilot_btnLinedUp_State = 0
    end

-- ##################################TakeOff BEGIN##############################################

    if XAutoCopilot_btnTakeOff_State == 1 and
        linedup_finish == 1 and XAutoCopilot_btnTakeOff_State == 1 or xac_debugon == 1 then
        takeoff_finish = 1
        XAutoCopilot_btnTakeOff_State = 0
    end

    if takeoff_finish == 1 then
        dref.setInt(xac_pack1, 1)
        dref.setInt(xac_pack2, 1)
        aftertakeoff_finish = 1
        takeoff_finish = 0
    end

	if xac_gear_handle_status == 0 and aftertakeoff_finish == 1 then
		dref.setFloat(xac_speedbrake, 0.0)
	   	dref.setInt(xac_nose_sw , 0)
	end
	

    if aftertakeoff_finish == 1 and
    dref.getFloat(xac_altitude_ft_pilot) > 10000 then
        sound.say("passing 10000 feet")
		dref.setInt(xac_landr_sw, 0)
		dref.setInt(xac_landl_sw, 0)
        climbstate1 = 1
        aftertakeoff_finish = 0
    end

	xac_cruisealt = dref.getFloat(xac_alt100x) *100
	
    if climbstate1 == 1 and
            dref.getFloat(xac_altitude_ft_pilot) >  xac_cruisealt then
        dref.setInt(xac_fasten_seat_belts, 0)
        climb_finish = 1
        climbstate1 = 0
    end

	-- STD ?
	
-- ##################################TakeOff END##############################################

-- ##################################Landing BEGIN############################################

    xac_ToD = dref.getString(xac_line_2b)
    if XAutoCopilot_btnLanding_State == 1 and
       string.find(xac_ToD, "T/D") and dref.getFloat(xac_gps_dme_dist_m) < 4.0 or XAutoCopilot_btnLanding_State == 1 and xac_debugon == 1 then
        --string.find(xac_ToD, "DECEL") and dref.getFloat(xac_gps_dme_dist_m) < 17.0 then
        --climb_finish == 1 then
        --FMGS Check Radio Nav Frequency|CHECK
        dref.setInt(xac_alt100x, 30)
        dref.setInt(xac_alt_pull_bat, 1)
        landingstate1 = 1
        XAutoCopilot_btnLanding_State = 0
    end

    if dref.getFloat(xac_altitude_ft_pilot) < 4500 and landingstate == 1 then
    dref.setInt(xac_push_baro, 1)
    --timer.newOneShot("QNH", 1.0)
        landingstate1 = 0
    end

	--spoilers arm
	
-- ##################################Landing END############################################
-- ##################################Helper BEGIN##############################################

    -- auto anti ice on

    if dref.getFloat( xac_outside_air_temp_degc )< 0.0 and
            dref.getFloatV( xac_n2_percent,1,1 )> 50.0 and
            dref.getFloatV( xac_n2_percent,2,1 )> 50.0 then
        dref.setInt(xac_ice_eng1_knob, 1)
        dref.setInt(xac_ice_eng2_knob, 1)
        dref.setInt(xac_ice_window, 1)
        dref.setInt(xac_ice_wing_knob, 1)
    end

    -- auto anti ice off
    if dref.getFloat( xac_outside_air_temp_degc )> 1.0 and
            dref.getFloatV( xac_n2_percent,1,1 )> 50.0 and
            dref.getFloatV( xac_n2_percent,2,1 )> 50.0 then
        dref.setInt(xac_ice_eng1_knob, 0)
        dref.setInt(xac_ice_eng2_knob, 0)
        dref.setInt(xac_ice_window, 0)
        dref.setInt(xac_ice_wing_knob, 0)
    end

-- ##################################Helper END##############################################

end

function XAutoCopilot_OnBeforeClose() end
