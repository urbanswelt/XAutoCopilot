--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 23.01.14
-- Time: 19:36
-- To change this template use File | Settings | File Templates.
--

function CockpitPreparation_OnUpdate()

    if btnPreparation_State == 1 then
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
        btnPreparation_State = 0
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
    end

end