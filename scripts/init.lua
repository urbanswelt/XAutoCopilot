--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 23.01.14
-- Time: 19:47
--
-- You would like use more than one script ?
-- make a new folder put it in here
dofile("xac_lua/xac_init.lua")


-- don`t use Global Functions, use event.register instead

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

--Undefined function
--[[
function OnDraw_BeforeGauges_3D() end
function OnDraw_Gauges_3D() end
function OnUpdate() end
function OnPluginEnable () end
function OnAircraftUnload () end
function OnBeforeReboot () end
function OnPluginEnable () end
function OnAircraftUnload () end
function OnBeforeReboot () end
function OnBoot  () end
function OnAircraftLoad () end
function OnSceneryLoaded () end
function OnAirportChanged () end
function OnLiveryChanged () end
function OnXPlaneDialog () end
function main () end
function XA_Activation_OnCreate () end
function OnDraw_BeforeGauges () end
function OnDraw_Gauges () end
function OnDraw_BeforeFirstScene () end
function OnDraw_FirstScene () end
function OnDraw_BeforeTerrain () end
function OnDraw_BeforeAirports () end
function OnDraw_Airports () end
function OnDraw_Terrain () end
function OnDraw_World () end
function OnDraw_BeforeAirplanes () end
function OnDraw_Airplanes () end
function OnDraw_BeforeLastScene () end
function OnDraw_LastScene () end
function OnDraw_BeforeFirstCockpit () end
function OnDraw_FirstCockpit () end
function OnDraw_BeforeLastCockpit () end
function OnDraw_LastCockpit () end
function OnDraw_BeforeWindows () end
function OnDraw_Windows() end
function OnForceRedraw () end
function Console_OnUpdate () end
function OnMouseClick () end
function Console_ConsoleCanvas_OnMouseOver () end
function Console_ConsoleCanvas_OnMouseDown () end]]
