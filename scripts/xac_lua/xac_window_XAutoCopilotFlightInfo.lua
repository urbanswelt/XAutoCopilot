--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 01.07.2014
-- Time: 20:49
--
XAutoCopilotFlightInfo_visible = false
menu.newItem("Flight Info", "XAutoCopilotFlightInfo")

--this function will run when the user clicks the "Toggle Popup" menu item.
function XAutoCopilotFlightInfo_OnClick()

    --all we have to do here is switch the value from on to off   or   off to on.

    if (XAutoCopilotFlightInfo_visible) then
        XAutoCopilotFlightInfo_visible = false
    else
        XAutoCopilotFlightInfo_visible = true
    end
end

function xac_InfoBoard()

    if (XAutoCopilotFlightInfo_visible) then
        local w, h = gfx.getScreenSize()
        local XAutoCopilotFlight = {
            top = h,
            left = 0,
            width = w,
            height = 20,
            testClick = function(self, x, y)
                if ((x > self.left) and (x < (self.left + self.width))
                        and
                        (y < self.top) and (y > (self.top - self.height))) then
                    return true

                else
                    return false
                end
            end
        }

        local red = { 1, 0, 0, 1 }
        local black = { 0, 0, 0, 1 }
        local grey = { 3, 3, 3, 0.15 }
        local grey2 = { 3, 3, 3, 1 }
        local blue = { 0, 102, 255, 1 }
        local pc = XAutoCopilotFlight

        gfx.texOff()
        gfx.setColor(black)

        gfx.drawFilledBox(pc.left, pc.top - pc.height, pc.width, pc.height)

        gfx.setColor(grey)
        gfx.drawFilledBox(pc.left + 20, pc.top - pc.height + 1, 200, 18)
        gfx.drawFilledBox(pc.left + 385, pc.top - pc.height + 1, 1410, 18)
        gfx.drawFilledBox(pc.left + 1800, pc.top - pc.height + 1, 80, 18)

        gfx.setColor(blue)
        local fltnbr = dref.getString(xac_flt_nbr)
        local state = dref.getString(xac_route_state)
        local route_info = dref.getString(xac_route_info)
        local route_dir = dref.getString(xac_route_dir)
        local departure_info = dref.getString(xac_daparture_info)
        local departure_apt = dref.getString(xac_daparture_apt)
        local approach_info = dref.getString(xac_approach_info)
        local approach_apt = dref.getString(xac_approach_apt)
        local qnh = string.sub(dref.getFloat(xac_barometer_sealevel_inhg), 1, 5)
        local wind_heading = string.format("%0.0f", dref.getFloat(xac_wind_heading_deg_mag))
        local wind_speed = string.format("%0.0f", dref.getFloat(xac_wind_speed_kts))

        gfx.drawString(fltnbr, pc.left + 24, pc.top - pc.height + 8)
        gfx.drawString(state, pc.left + 120, pc.top - pc.height + 8)

        local fmc_count = fmc.getCount()
        --[[        if fmc_count == 1 then
                    gfx.setColor(grey2)
                    gfx.drawString(route_info, pc.left + 1680, pc.top - pc.height + 8)
                end]]

        if string.find(state, "BOARDING") or
                string.find(state, "TAXI OUT") and fmc_count > 1 then
            gfx.setColor(blue)
            dref.setString(xac_route_info, "WINDS: " .. wind_heading .. "°" .. " / " .. wind_speed .. " kt")
            gfx.drawString(route_info, pc.left + 1680, pc.top - pc.height + 8)
            gfx.drawString(departure_info, pc.left + 1500, pc.top - pc.height + 8)
        end

        if string.find(state, "TAKEOFF") or
                string.find(state, "CLIMB") and fmc_count > 1 then
            gfx.setColor(blue)
            dref.setString(xac_route_info, "WINDS: " .. wind_heading .. "°" .. " / " .. wind_speed .. " kt")
            gfx.drawString(route_info, pc.left + 1680, pc.top - pc.height + 8)
            --gfx.drawString(route_dir, pc.left + 1500, pc.top - pc.height + 8)
        end

        if string.find(state, "CRUISE") and fmc_count > 1 then
            gfx.setColor(blue)
            gfx.drawString("Enroute from: " .. departure_apt, pc.left + 1560, pc.top - pc.height + 8)
            gfx.drawString("to: " .. approach_apt, pc.left + 1680, pc.top - pc.height + 8)
        end

        if string.find(state, "DESCENT") and fmc_count > 1 then
            gfx.setColor(blue)
            dref.setString(xac_route_info, "WINDS: " .. wind_heading .. "°" .. " / " .. wind_speed .. " kt")
            gfx.drawString(route_info, pc.left + 1680, pc.top - pc.height + 8)
            gfx.drawString(approach_info, pc.left + 1500, pc.top - pc.height + 8)
        end


        if fmc_count > 1 then
            timer.newTimer("nextWaypoint", 1.0)
            timer.newTimer("DepartureWaypoint", 1.0)
            timer.newTimer("ApproachWaypoint", 1.0)
        end

        gfx.setColor(grey2)
        gfx.drawString("QNH " .. qnh, pc.left + 1810, pc.top - pc.height + 8)
    end
end

local Toolhook = {}

ToolXAutoCopilotFlightInfo = {
    active = true,
    texture = gfx.loadPng(acf.getFolder() .. "scripts/xac_lua/icons/Flight.png"),
    name = "XAutoCopilotFlightInfo",
    run = function(self)
        if (Toolhook) then
            XAutoCopilotFlightInfo_visible = true
        else
            self.active = false
        end
    end,
}


if (ToolTray) then
    ToolTray:register(ToolXAutoCopilotFlightInfo)
end