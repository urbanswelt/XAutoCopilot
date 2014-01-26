--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 25.01.14
-- Time: 15:51
-- To change this template use File | Settings | File Templates.
--

function BeforeStart_OnUpdate()
    if btnBeforeStart_State == 1 then
        dref.setInt(xac_p_f_l_kn , 0)
        dref.setInt(xac_p_f_r_kn , 0)
        dref.setInt(xac_p_b_l_kn , 0)
        dref.setInt(xac_p_b_r_kn , 0)
        dref.setInt(xac_c_f_kn , 0)
        dref.setInt(xac_c_b_kn , 0)
        dref.setInt(xac_cater_on, 0)
        dref.setInt(xac_stair_on, 0)
        beforestartstate1 = 1
        btnBeforeStart_State = 0
    end

    if dref.getFloat( xac_p_f_l_now )== 0.0 and
       dref.getFloat( xac_p_f_r_now )== 0.0 and
       dref.getFloat( xac_p_b_l_now )== 0.0 and
       dref.getFloat( xac_p_b_r_now )== 0.0 and
       dref.getFloat( xac_c_f_now )== 0.0 and
       dref.getFloat( xac_c_b_now )== 0.0 and
       dref.getFloat( xac_move_to_cater )> 19.0 and
       dref.getFloat( xac_move_to_stair )> 37.0 and beforestartstate1 == 1
    then
        dref.setInt(xac_show_cater , 0)
        dref.setInt(xac_show_stair , 0)
        dref.setInt(xac_fasten_seat_belts , 1)
        dref.setInt(xac_no_smoking , 1)
        dref.setInt(xac_beacon_sw , 1)
        beforestartstate1 = 0
    end
end
