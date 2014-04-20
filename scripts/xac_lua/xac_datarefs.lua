--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 23.01.14
-- Time: 19:19
--


function OnFirstFrame()

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
xac_brake_auto_max      = dref.getDataref("sim/custom/xap/brakes/auto_max")
xac_rudder_trim         = dref.getDataref("sim/cockpit2/controls/rudder_trim")
xac_flap                = dref.getDataref("sim/cockpit2/controls/flap_ratio")

xac_window_heat         = dref.getDataref("sim/cockpit2/ice/ice_window_heat_on")
xac_pack1               = dref.getDataref("sim/custom/xap/cond/pack1")
xac_pack2               = dref.getDataref("sim/custom/xap/cond/pack2")
xac_temp_cock           = dref.getDataref("sim/custom/xap/cond/ckpt_knob")
xac_temp_fwd_cab        = dref.getDataref("sim/custom/xap/cond/fwd_knob")
xac_temp_aft_cab        = dref.getDataref("sim/custom/xap/cond/aft_knob")

-- adirs
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
xac_fasten_seat_belts   = dref.getDataref("sim/cockpit/switches/fasten_seat_belts")
xac_no_smoking          = dref.getDataref("sim/cockpit2/switches/no_smoking")
xac_beacon_sw           = dref.getDataref("sim/custom/xap/extlight/beacon_sw")

--groundservice

xac_cater_on           = dref.getDataref("sim/custom/xap/groundserv/cater/cat_on")
xac_show_cater         = dref.getDataref("sim/custom/xap/groundserv/cater/show_cater")
xac_move_to_cater      = dref.getDataref("sim/custom/xap/groundserv/cater/move_to_cater")

xac_stair_on           = dref.getDataref("sim/custom/xap/groundserv/stair/str_on")
xac_show_stair         = dref.getDataref("sim/custom/xap/groundserv/stair/show_stair")
xac_move_to_stair      = dref.getDataref("sim/custom/xap/groundserv/stair/move_to_stair")

xac_tanker_on          = dref.getDataref("sim/custom/xap/groundserv/tanker/tanker_on")
xac_load_on            = dref.getDataref("sim/custom/xap/groundserv/load_on")
xac_fm_on              = dref.getDataref("sim/custom/xap/groundserv/gnd_fm_on")
xac_tow_on             = dref.getDataref("sim/custom/xap/groundserv/pwr_tow")
xac_show_tow           = dref.getDataref("sim/custom/xap/groundserv/show_tow")

xac_chk_on             = dref.getDataref("sim/custom/xap/groundserv/pwr_chk")


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

-- mcdu
xac_click_init          = dref.getDataref("sim/custom/xap/mcdu/click_int")
xac_click_perf          = dref.getDataref("sim/custom/xap/mcdu/click_perf")
xac_click_l1            = dref.getDataref("sim/custom/xap/mcdu/click_l1")
xac_click_l2            = dref.getDataref("sim/custom/xap/mcdu/click_l2")
xac_click_l3            = dref.getDataref("sim/custom/xap/mcdu/click_l3")
xac_click_l4            = dref.getDataref("sim/custom/xap/mcdu/click_l4")
xac_click_l5            = dref.getDataref("sim/custom/xap/mcdu/click_l5")
xac_click_l6            = dref.getDataref("sim/custom/xap/mcdu/click_l6")
xac_click_r1            = dref.getDataref("sim/custom/xap/mcdu/click_r1")
xac_click_r2            = dref.getDataref("sim/custom/xap/mcdu/click_r2")
xac_click_r3            = dref.getDataref("sim/custom/xap/mcdu/click_r3")
xac_click_r4            = dref.getDataref("sim/custom/xap/mcdu/click_r4")
xac_click_r5            = dref.getDataref("sim/custom/xap/mcdu/click_r5")
xac_click_r6            = dref.getDataref("sim/custom/xap/mcdu/click_r6")
xac_click_right         = dref.getDataref("sim/custom/xap/mcdu/click_right")
xac_click_clr           = dref.getDataref("sim/custom/xap/mcdu/click_clr")
xac_click_a             = dref.getDataref("sim/custom/xap/mcdu/click_a")
xac_click_b             = dref.getDataref("sim/custom/xap/mcdu/click_b")
xac_click_c             = dref.getDataref("sim/custom/xap/mcdu/click_c")
xac_click_d             = dref.getDataref("sim/custom/xap/mcdu/click_d")
xac_click_e             = dref.getDataref("sim/custom/xap/mcdu/click_e")
xac_click_f             = dref.getDataref("sim/custom/xap/mcdu/click_f")
xac_click_g             = dref.getDataref("sim/custom/xap/mcdu/click_g")
xac_click_h             = dref.getDataref("sim/custom/xap/mcdu/click_h")
xac_click_i             = dref.getDataref("sim/custom/xap/mcdu/click_i")
xac_click_j             = dref.getDataref("sim/custom/xap/mcdu/click_j")
xac_click_k             = dref.getDataref("sim/custom/xap/mcdu/click_k")
xac_click_l             = dref.getDataref("sim/custom/xap/mcdu/click_l")
xac_click_m             = dref.getDataref("sim/custom/xap/mcdu/click_m")
xac_click_n             = dref.getDataref("sim/custom/xap/mcdu/click_n")
xac_click_o             = dref.getDataref("sim/custom/xap/mcdu/click_o")
xac_click_p             = dref.getDataref("sim/custom/xap/mcdu/click_p")
xac_click_q             = dref.getDataref("sim/custom/xap/mcdu/click_q")
xac_click_r             = dref.getDataref("sim/custom/xap/mcdu/click_r")
xac_click_s             = dref.getDataref("sim/custom/xap/mcdu/click_s")
xac_click_t             = dref.getDataref("sim/custom/xap/mcdu/click_t")
xac_click_u             = dref.getDataref("sim/custom/xap/mcdu/click_u")
xac_click_v             = dref.getDataref("sim/custom/xap/mcdu/click_v")
xac_click_w             = dref.getDataref("sim/custom/xap/mcdu/click_w")
xac_click_x             = dref.getDataref("sim/custom/xap/mcdu/click_x")
xac_click_y             = dref.getDataref("sim/custom/xap/mcdu/click_y")
xac_click_z             = dref.getDataref("sim/custom/xap/mcdu/click_z")
xac_scratchpad          = dref.getDataref("sim/custom/xap/mcdu/scratchpad")
xac_line_3b             = dref.getDataref("sim/custom/xap/mcdu/line_3b")

-- fuel, start
xac_t1_pump1            = dref.getDataref("sim/custom/xap/fuel/t1_pump1")
xac_t1_pump2            = dref.getDataref("sim/custom/xap/fuel/t1_pump2")
xac_t2_pump1            = dref.getDataref("sim/custom/xap/fuel/t2_pump1")
xac_t2_pump2            = dref.getDataref("sim/custom/xap/fuel/t2_pump2")
xac_t3_pump1            = dref.getDataref("sim/custom/xap/fuel/t3_pump1")
xac_t3_pump2            = dref.getDataref("sim/custom/xap/fuel/t3_pump2")
xac_startsel            = dref.getDataref("sim/custom/xap/engines/startsel")
xac_eng1msw             = dref.getDataref("sim/custom/xap/engines/eng1msw")
xac_eng2msw             = dref.getDataref("sim/custom/xap/engines/eng2msw")
xac_n2_percent          = dref.getDataref("sim/cockpit2/engine/indicators/N2_percent")


--misc
--xac_timer              = dref.getDataref("sim/cockpit2/clock_timer/local_time_seconds")
end