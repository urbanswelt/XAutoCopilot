--[[
-- Author: Ben Russell, br@x-plugins.com
-- Date: 16/03/14
-- Time: 3:06 PM
--]]





--[[/**
color.read_me()

Gizmo64 provides a table of common color names that can be used to make your code easier to read and write.

Please see this file for more information:
https://github.com/benrussell/Gizmo-Firmware/blob/master/firmware/core/color_api.lua

<code>
gfx.setColor( color.red )
</code>

Colors available as of 2014.04.19

color.red
color.green
color.blue

color.yellow
color.orange
color.magenta

color.black
color.white

color.dark_gray
color.light_gray
color.gray
color.grey

color.bg_gray
color.bg_gray_bright


API: >= 14.04
*/]]



color = {}

color.red = { 1, 0, 0, 1 }
color.green = { 0, 1, 0, 1 }
color.blue = { 0, 0, 1, 1 }

color.yellow = { 1, 1, 0, 1 }
color.orange = { 0.75, 0.5, 0, 1 }
color.magenta = { 1, 0, 1, 1 }

color.black = { 0, 0, 0, 1 }
color.white = { 1, 1, 1, 1 }

color.dark_gray = { 0.25, 0.25, 0.25, 1 }
color.light_gray = { 0.75, 0.75, 0.75, 1 }
color.gray = { 0.5, 0.5, 0.5, 1 }
color.grey = { 0.5, 0.5, 0.5, 1 }

color.bg_gray = { 0.788, 0.788, 0.788, 1 }
color.bg_gray_bright = { 0.888, 0.888, 0.888, 1 }



--eof
