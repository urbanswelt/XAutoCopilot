--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 19.07.2014
-- Time: 17:02
-- To change this template use File | Settings | File Templates.
--

function DepartureWaypoint()
    local file = acf.getFolder() .. "FlightPlans/tmpplan.txt" --our file destination
    local lines = lines_from(file) -- line seperated table for all entrys

    local actline1 = lines[1] -- first line is our apt wp
    local result = Split(actline1, ' ') -- split into the sub strings, max21
    local table1 = {
        result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11],
        result[12], result[13], result[14], result[15], result[16], result[17], result[18], result[19], result[20], result[21]
    }

    local actline2 = lines[2] -- second line is our apt rwy
    local result2 = Split(actline2, ' ') -- split into the sub strings, max21
    local table2 = {
        result2[1], result2[2], result2[3], result2[4], result2[5], result2[6], result2[7], result2[8], result2[9], result2[10], result2[11],
        result2[12], result2[13], result2[14], result2[15], result2[16], result2[17], result2[18], result2[19], result2[20], result2[21]
    }

    local route_dir1 = Split((table1[2]), '=')
    local route_routepart = Split((table1[4]), '=')
    local route_dir2 = Split((table2[2]), '=')
    local route_pointtype = Split((table2[3]), '=')

    dref.setString(xac_daparture_info, route_routepart[2] ..":"..route_dir1[1] .." " ..route_pointtype[2] ..":" ..route_dir2[1])

end

function ApproacheWaypoint()
    local fmc_count = fmc.getCount()
    local file = acf.getFolder() .. "FlightPlans/tmpplan.txt" --our file destination
    local lines = lines_from(file) -- line seperated table for all entrys

    local actline1 = lines[fmc_count] -- last line is our apt wp
    local result = Split(actline1, ' ') -- split into the sub strings, max21
    local table1 = {
        result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11],
        result[12], result[13], result[14], result[15], result[16], result[17], result[18], result[19], result[20], result[21]
    }

    local actline2 = lines[fmc_count-1] -- before last line is our apt rwy
    local result2 = Split(actline2, ' ') -- split into the sub strings, max21
    local table2 = {
        result2[1], result2[2], result2[3], result2[4], result2[5], result2[6], result2[7], result2[8], result2[9], result2[10], result2[11],
        result2[12], result2[13], result2[14], result2[15], result2[16], result2[17], result2[18], result2[19], result2[20], result2[21]
    }

    local route_dir1 = Split((table1[2]), '=')
    local route_routepart = Split((table1[4]), '=')
    local route_dir2 = Split((table2[2]), '=')
    local route_pointtype = Split((table2[3]), '=')

    dref.setString(xac_approach_info, route_routepart[2] ..":"..route_dir1[1] .." " ..route_pointtype[2] ..":" ..route_dir2[1])

end

function nextWaypoint()
   -- local fmc_count = fmc.getCount()
    local fmc_displayed = fmc.getDisplayed()
    --    local fmc_dest = fmc.getDestination()
    --    logging.debug(fmc_count)
    --    logging.debug(fmc_displayed)
    --    logging.debug(fmc_dest)


    local file = acf.getFolder() .. "FlightPlans/tmpplan.txt" --our file destination
    local lines = lines_from(file) -- line seperated table for all entrys

    --    logging.debug(lines[fmc_displayed]) --give us the string for the actual wp from file
    --    logging.debug(lines[fmc_count + 1]) --the last entry in this file is the distance information

    local actline = lines[fmc_displayed] -- give us the string for the actual wp from file
    local result = Split(actline, ' ') -- split into the sub strings, max21
    local table = {
        result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11],
        result[12], result[13], result[14], result[15], result[16], result[17], result[18], result[19], result[20], result[21]
    }

    local route_step = Split((table[1]), '=')
    local route_dir = Split((table[2]), '=')
    local route_pointtype = Split((table[3]), '=')
    local route_routepart = Split((table[4]), '=')
    local route_show_nom = Split((table[5]), '=')
    local route_next_act = Split((table[6]), '=')
    local route_lat = Split((table[7]), '=')
    local route_lon = Split((table[8]), '=')
    local route_alt_min = Split((table[9]), '=')
    local route_alt_max = Split((table[10]), '=')
    local route_cst_min = Split((table[11]), '=')
    local route_cst_max = Split((table[12]), '=')
    local route_prof = Split((table[13]), '=')
    local route_eutc = Split((table[14]), '=')
    local route_efob = Split((table[15]), '=')
    local route_part = Split((table[16]), '=')
    local route_dist = Split((table[17]), '=')
    local route_brg = Split((table[18]), '=')
    local route_awy = Split((table[19]), '=')
    local route_freq = Split((table[20]), '=')
    local route_crs = Split((table[21]), '=')

    dref.setInt(xac_route_step, route_step[1])
    dref.setString(xac_route_dir, route_dir[1])
    dref.setString(xac_route_pointtype, route_pointtype[2])
    dref.setString(xac_route_routepart, route_routepart[2])
    dref.setInt(xac_route_show_nom, route_show_nom[2])
    dref.setInt(xac_route_next_act, route_next_act[2])
    dref.setFloat(xac_route_lat, route_lat[2])
    dref.setFloat(xac_route_lon, route_lon[2])
    dref.setInt(xac_route_alt_min, route_alt_min[2])
    dref.setInt(xac_route_alt_max, route_alt_max[2])
    dref.setInt(xac_route_cst_min, route_cst_min[2])
    dref.setInt(xac_route_cst_max, route_cst_max[2])
    dref.setFloat(xac_route_prof, route_prof[2])
    dref.setFloat(xac_route_eutc, route_eutc[2])
    dref.setFloat(xac_route_efob, route_efob[2])
    dref.setString(xac_route_part, route_part[2])
    dref.setFloat(xac_route_dist, route_dist[2])
    dref.setInt(xac_route_brg, route_brg[2])
    dref.setString(xac_route_awy, route_awy[2])
    dref.setFloat(xac_route_freq, route_freq[2])
    dref.setFloat(xac_route_crs, route_crs[2])
end


function AutoFlap()
    local xac_AutoFlap = dref.getString(xac_line_3b)

    -- flap adjust from mcdu menu
    -- flap 0 = 0.0
    -- flap 1 = 0.4
    -- flap 2 = 0.6
    -- flap 3 = 0.8
    -- flap 4 = 1.0

    if string.find(xac_AutoFlap, "0/")  then
        dref.setFloat(xac_flap, 0.0)
    end

    if string.find(xac_AutoFlap, "1/")  then
        dref.setFloat(xac_flap, 0.4)
    end

    if string.find(xac_AutoFlap, "2/")  then
        dref.setFloat(xac_flap, 0.6)
    end

    if string.find(xac_AutoFlap, "3/")  then
        dref.setFloat(xac_flap, 0.8)
    end

    if string.find(xac_AutoFlap, "4/")  then
        dref.setFloat(xac_flap, 1.0)
    end
end




-- ##################################Helper BEGIN##############################################

-- auto anti ice on
--[[    if dref.getFloat(xac_outside_air_temp_degc) < 0.0 and
            dref.getFloatV(xac_n2_percent, 1, 1) > 50.0 and
            dref.getFloatV(xac_n2_percent, 2, 1) > 50.0 then
        dref.setInt(xac_ice_eng1_knob, 1)
        dref.setInt(xac_ice_eng2_knob, 1)
        dref.setInt(xac_ice_window, 1)
        dref.setInt(xac_ice_wing_knob, 1)
    end

    -- auto anti ice off
    if dref.getFloat(xac_outside_air_temp_degc) > 1.0 and
            dref.getFloatV(xac_n2_percent, 1, 1) > 50.0 and
            dref.getFloatV(xac_n2_percent, 2, 1) > 50.0 then
        dref.setInt(xac_ice_eng1_knob, 0)
        dref.setInt(xac_ice_eng2_knob, 0)
        dref.setInt(xac_ice_window, 0)
        dref.setInt(xac_ice_wing_knob, 0)
    end]]

-- ##################################Helper END##############################################




