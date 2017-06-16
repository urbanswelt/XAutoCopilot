--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 19.07.2014
-- Time: 17:02
-- To change this template use File | Settings | File Templates.
--


-- Global extra Functions

--http://stackoverflow.com/questions/11201262/file-read-in-lua
-- http://lua-users.org/wiki/FileInputOutput
-- see if the file exists

--http://lua-users.org/wiki/SplitJoin
function Split(str, delim, maxNb)
    -- Eliminate bad cases...
    if string.find(str, delim) == nil then
        return { str }
    end
    if maxNb == nil or maxNb < 1 then
        maxNb = 0 -- No limit
    end
    local result = {}
    local pat = "(.-)" .. delim .. "()"
    local nb = 0
    local lastPos
    for part, pos in string.gfind(str, pat) do
        nb = nb + 1
        result[nb] = part
        lastPos = pos
        if nb == maxNb then break end
    end
    -- Handle the last field
    if nb ~= maxNb then
        result[nb + 1] = string.sub(str, lastPos)
    end
    return result
end

-- get all lines from a file, returns an empty list/table if the file does not exist
function lines_from(file)
    if not file_exists(file) then return {} end
    local lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = line
    end
    return lines
end

function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

function table_length(table_name)
    local count = 0
    for _ in pairs(table_name) do count = count + 1 end
    return count
end

function fsize(file)
    if not file_exists(file) then return {} end
    local file = assert(io.open(file, "r"))
    local current = file:seek() -- get current position
    local size = file:seek("end") -- get file size
    file:seek("set", current) -- restore position
    file:close()
    return size
end

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

    dref.setString(xac_daparture_info, route_routepart[2] .. ":" .. route_dir1[1] .. " " .. route_pointtype[2] .. ":" .. route_dir2[1])
    dref.setString(xac_daparture_apt, route_dir1[1])
end

function ApproachWaypoint()
    local fmc_count = fmc.getCount()
    local file = acf.getFolder() .. "FlightPlans/tmpplan.txt" --our file destination
    local lines = lines_from(file) -- line seperated table for all entrys

    local actline1 = lines[fmc_count] -- last line is our apt wp
    local result = Split(actline1, ' ') -- split into the sub strings, max21
    local table1 = {
        result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11],
        result[12], result[13], result[14], result[15], result[16], result[17], result[18], result[19], result[20], result[21]
    }

    local actline2 = lines[fmc_count - 1] -- before last line is our apt rwy
    local result2 = Split(actline2, ' ') -- split into the sub strings, max21
    local table2 = {
        result2[1], result2[2], result2[3], result2[4], result2[5], result2[6], result2[7], result2[8], result2[9], result2[10], result2[11],
        result2[12], result2[13], result2[14], result2[15], result2[16], result2[17], result2[18], result2[19], result2[20], result2[21]
    }

    local route_dir1 = Split((table1[2]), '=')
    local route_routepart = Split((table1[4]), '=')
    local route_dir2 = Split((table2[2]), '=')
    local route_pointtype = Split((table2[3]), '=')

    dref.setString(xac_approach_info, route_routepart[2] .. ":" .. route_dir1[1] .. " " .. route_pointtype[2] .. ":" .. route_dir2[1])
    dref.setString(xac_approach_apt, route_dir1[1])
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

    if string.find(xac_AutoFlap, "0/") then
        dref.setFloat(xac_flap, 0.0)
    end

    if string.find(xac_AutoFlap, "1/") then
        dref.setFloat(xac_flap, 0.4)
    end

    if string.find(xac_AutoFlap, "2/") then
        dref.setFloat(xac_flap, 0.6)
    end

    if string.find(xac_AutoFlap, "3/") then
        dref.setFloat(xac_flap, 0.8)
    end

    if string.find(xac_AutoFlap, "4/") then
        dref.setFloat(xac_flap, 1.0)
    end
end

function round(num, idp)
    local mult = 10 ^ (idp or 0)
    return math.floor(num * mult + 0.5) / mult
    --http://snippets.luacode.org/snippets/Round_a_Number_to_given_number_of_decimal_places_17
end

--xac xaccolor table for global use

xaccolor = {}
xaccolor.white = { 1, 1, 1, 1 }
xaccolor.red = { 1, 0, 0, 1 }
xaccolor.yellow = { 1, 1, 0, 1 }
xaccolor.blue = { 0, 0, 1, 1 }
xaccolor.black = { 0, 0, 0, 1 }

--preferences adapted from Gizmo Firmeware FIXME change for more then 1 pref "table" usage
--https://github.com/benrussell/Gizmo-Firmware
xac_prefs = {} --global prefs table
xac_prefs.filename = acf.getFolder() .. "scripts/xac_lua/prefs/xac_prefs.txt"
xac_prefs.values = {} --storage for user pref data

xac_prefs.load = function(filename)

    --console.log("prefs.load()..")

    local prefs_data = "--disk_read_failure" --Real value will be read from disk.

    local prefs_path = filename

    --read prefs data
    local fh = io.open(prefs_path, "rb")
    if (fh) then
        prefs_data = fh:read("*all")
        fh:close()
        fh = nil

    else
        logging.warning("xac_prefs.load(): No prefs file found!")
        return
    end




    --import prefs data if read was good
    if (prefs_data) then

        local prefs_f, error = loadstring(prefs_data)
        if (prefs_f) then

            local blank_env = {}
            setfenv(prefs_f, blank_env)
            local new_prefs = prefs_f()

            if (new_prefs) then
                xac_prefs.values = new_prefs
            end


        else
            logging.warning("xac corrupt prefs data: " .. error)
            logging.debug(" xac prefs data size: " .. #prefs_data .. " bytes")
            logging.debug(" xac prefs data raw:\n" .. tostring(prefs_data))
        end
    end
end --prefs.load()

xac_prefs.save = function(filename)

    --console.log("prefs.save()..")

    local prefs_blob = "--Auto Generated Gizmo Preferences Data\nreturn" .. vardump_lua2(xac_prefs.values)
    --console.log( prefs_blob )

    local prefs_path = filename

    --write prefs data
    local fh = io.open(prefs_path, "wb")
    if (fh) then
        --prefs_data = fh:read("*all")
        fh:write(prefs_blob)
        fh:close()
        fh = nil

        --logging.warning("prefs saved. (" .. prefs_path ..  ")")

    else
        error("xac_prefs.save(): Failed: (" .. prefs_path .. ")")
    end --check file handle is not nil
end --prefs.save()

xac_prefs.set = function(key, value)

    --Check to see if we already have a prefs value for this item.
    --If we do we will update it. If we do not we will create a new item.

    if (xac_prefs.get(key, nil) == nil) then
        --We could not find a prefs item for this key, create a new one.

        local new_prefs_pair = {
            name = key,
            value = value
        }
        table.insert(xac_prefs.values, new_prefs_pair)

    else
        --Record already exists, locate and modify

        for k, v in pairs(xac_prefs.values) do
            if (v) then
                if (v.name == key) then
                    --logging.debug("xac_prefs.set: " .. tostring(key) .. "  updated to: " .. tostring(v.value) )
                    v.value = value --set the new value
                    return
                end
            end
        end
    end
end --xac_prefs.set

xac_prefs.get = function(key, default)
    if (xac_prefs.values) then

        for k, v in pairs(xac_prefs.values) do
            --console.log(k)
            --console.log(v)

            if (v) then
                if (v.name == key) then
                    --console.log("xac_prefs.get: " .. tostring(key) .. "  return: " .. tostring(v.value) )
                    return v.value
                end
            else
                --blank value?
                error("xac_prefs.get: found key: " .. tostring(key) .. " but value is blank.")
            end
        end

        --console.warn("prefs.get: no value found for: " .. tostring(key))
        return default

    else
        error("xac_prefs.values == nil")
        return default
    end
end --xac_prefs.get

xac_prefs.debug = function()
    logging.debug((vardump_lua2(xac_prefs.values)))
end --prefs.debug

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

function vardump_lua2(value, depth, key)

    if (depth == nil) then
        --console.log("fw vardump_lua v14.03.16.1747")
    end


    local linePrefix = ""
    local spaces = ""

    local ret_blob = ""


    if key ~= nil then
        linePrefix = ""
        if (depth > 0) then
            linePrefix = key .. " = "
        end
    end


    if depth == nil then
        depth = 0
    else
        depth = depth + 1
        for i = 1, depth - 1 do
            spaces = spaces .. " "
        end
    end





    if type(value) == 'table' then

        local mTable = getmetatable(value)
        if mTable == nil then
            if (depth > 0) then
                --b_print(spaces ..linePrefix.."{")
                ret_blob = ret_blob .. (spaces .. linePrefix .. "{") .. "\n"
            end

        else
            --b_print(spaces .."{")
            ret_blob = ret_blob .. (spaces .. "{") .. "\n"
            value = mTable
        end

        --recursion happens here.
        for tableKey, tableValue in pairs(value) do
            ret_blob = ret_blob .. vardump_lua2(tableValue, depth, tableKey)
        end


        if (depth > 1) then
            --comma on the end
            ret_blob = ret_blob .. (spaces .. "},") .. "\n"

        elseif (depth > 0) then
            --NO comma on the end
            ret_blob = ret_blob .. (spaces .. "},") .. "\n"
        end



    elseif
    type(value) == 'function' or
            type(value) == 'thread' or
            type(value) == 'userdata' or
            value == nil
    then

        --b_print(spaces..tostring(value))
        --do nothing



    else

        local d_type = type(value)
        if (d_type) == "string" then
            --b_print(spaces..linePrefix.. "\"" .. tostring(value) .. "\"," )
            ret_blob = ret_blob .. (spaces .. linePrefix .. "\"" .. tostring(value) .. "\"")

            if (depth > 1) then
                ret_blob = ret_blob .. ","
            end

            ret_blob = ret_blob .. "\n"


        elseif (d_type) == "number" then
            --b_print(spaces..linePrefix..tostring(value)..",")
            ret_blob = ret_blob .. (spaces .. linePrefix .. tostring(value))

            if (depth > 1) then
                ret_blob = ret_blob .. ","
            end

            ret_blob = ret_blob .. "\n"


            --this never runs - see code above that deals with tables and recursion.
            --elseif( d_type ) == "table" then
            --	b_print(spaces..linePrefix.."{"..tostring(value))

        else
            --booleans are rendered here.
            --b_print(spaces..linePrefix..tostring(value)..",")
            ret_blob = ret_blob .. (spaces .. linePrefix .. tostring(value))

            if (depth > 1) then
                ret_blob = ret_blob .. ","
            end

            --data type info
            --ret_blob = ret_blob .. " --".. type(value)

            ret_blob = ret_blob .. "\n"
        end
    end --end data type detect.


    if (depth > 0) then
        return ret_blob
    else
        --parent wrapper, turns the entire blob into a nice easy to digest table.
        return "{\n" .. ret_blob .. "}"
    end
end