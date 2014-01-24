--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 23.01.14
-- Time: 19:19
-- To change this template use File | Settings | File Templates.
--
function OnFirstFrame()

xac_eng1msw             = dref.getDataref("sim/custom/xap/engines/eng1msw")
xac_eng2msw             = dref.getDataref("sim/custom/xap/engines/eng2msw")
xac_startsel            = dref.getDataref("sim/custom/xap/engines/startsel")
xac_gear_handle_status  = dref.getDataref("sim/cockpit/switches/gear_handle_status")
xac_gpu_av              = dref.getDataref("sim/custom/xap/elec/gpu_av")
xac_gpu_run             = dref.getDataref("sim/custom/xap/elec/gpu_run")
xac_gpu_here            = dref.getDataref("sim/custom/xap/elec/gpu_here")
xac_gpu_on              = dref.getDataref("sim/custom/xap/elec/gpu_on")
xac_bat1_on             = dref.getDataref("sim/custom/xap/elec/bat1_on")
xac_bat2_on             = dref.getDataref("sim/custom/xap/elec/bat2_on")
xac_apu_firetest        = dref.getDataref("sim/custom/xap/firetest/apu")
xac_firetest_e1         = dref.getDataref("sim/custom/xap/firetest/e1")
xac_firetest_e2         = dref.getDataref("sim/custom/xap/firetest/e2")
xac_APU_switch          = dref.getDataref("sim/cockpit/engine/APU_switch")
xac_apu_blvlv           = dref.getDataref("sim/custom/xap/bleed/apu_blvlv")
xac_bleed_mode_sw       = dref.getDataref("sim/custom/xap/bleed/mode_sw")
xac_start_pb            = dref.getDataref("sim/custom/xap/apu/start_pb")
xac_parbrake            = dref.getDataref("sim/flightmodel/controls/parkbrake")
xac_yellow_pump         = dref.getDataref("sim/custom/xap/hydr/y/elpump/mode")
xac_flap_ratio          = dref.getDataref("sim/cockpit2/controls/flap_ratio")
xac_speedbrake          = dref.getDataref("sim/cockpit2/controls/speedbrake_ratio")
xac_window_heat         = dref.getDataref("sim/cockpit2/ice/ice_window_heat_on")
xac_pack1               = dref.getDataref("sim/custom/xap/cond/pack1")
xac_pack2               = dref.getDataref("sim/custom/xap/cond/pack2")
xac_temp_cock           = dref.getDataref("sim/custom/xap/cond/ckpt_knob")
xac_temp_fwd_cab        = dref.getDataref("sim/custom/xap/cond/fwd_knob")
xac_temp_aft_cab        = dref.getDataref("sim/custom/xap/cond/aft_knob")
xac_adirs_data_sel      = dref.getDataref("sim/custom/xap/adirs/data_sel")
xac_adirs_sys_sel       = dref.getDataref("sim/custom/xap/adirs/sys_sel")
xac_adirs_mode_sel_1    = dref.getDataref("sim/custom/xap/adirs/mode_sel_1")
xac_adirs_mode_sel_3    = dref.getDataref("sim/custom/xap/adirs/mode_sel_3")
xac_adirs_mode_sel_2    = dref.getDataref("sim/custom/xap/adirs/mode_sel_2")
xac_adirs_on_bat        = dref.getDataref("sim/custom/xap/adirs/on_bat")
xac_adirs_enter         = dref.getDataref("sim/custom/xap/adirs/knob_ent")
xac_adirs_disp          = dref.getDataref("sim/custom/xap/adirs/disp")
xac_emer_ext_lt         = dref.getDataref("sim/custom/xap/extlight/emer_ext_lt")
xac_alt_rot             = dref.getDataref("sim/custom/xap/press/alt_rot")
xac_strobe_sw           = dref.getDataref("sim/custom/xap/extlight/strobe_sw")
xac_radio_on            = dref.getDataref("sim/custom/xap/radio/on")
xac_fcu_fd              = dref.getDataref("sim/custom/xap/fcu/fd")
xac_fcu_ils             = dref.getDataref("sim/custom/xap/fcu/ils")
xac_atc_mode_sel        = dref.getDataref("sim/custom/xap/atc/mode_sel")
xac_atc_ta_tara         = dref.getDataref("sim/custom/xap/atc/ta_tara")
xac_ant_skeed           = dref.getDataref("sim/custom/xap/wheels/ant_skeed")
xac_efifs_waether       = dref.getDataref("/sim/cockpit/switches/EFIFS_shows_weather")
xac_engn_thro           = dref.getDataref("sim/flightmodel/engine/ENGN_thro")

-- doors / menu
xac_p_f_l_kn            = dref.getDataref("sim/custom/xap/doors/p_f_l_kn")
xac_p_f_r_kn            = dref.getDataref("sim/custom/xap/doors/p_f_r_kn")
xac_p_b_l_kn            = dref.getDataref("sim/custom/xap/doors/p_b_l_kn")
xac_p_b_r_kn            = dref.getDataref("sim/custom/xap/doors/p_b_r_kn")
xac_c_f_kn              = dref.getDataref("sim/custom/xap/doors/c_f_kn")
xac_c_b_kn              = dref.getDataref("sim/custom/xap/doors/c_b_kn")

-- doors / status
xac_p_f_l_now           = dref.getDataref("sim/custom/xap/doors/p_f_l_now")
xac_p_f_r_now           = dref.getDataref("sim/custom/xap/doors/p_f_r_now")
xac_p_b_l_now           = dref.getDataref("sim/custom/xap/doors/p_b_l_now")
xac_p_b_r_now           = dref.getDataref("sim/custom/xap/doors/p_b_r_now")
xac_c_f_now             = dref.getDataref("sim/custom/xap/doors/c_f_now")
xac_c_b_now             = dref.getDataref("sim/custom/xap/doors/c_b_now")

end