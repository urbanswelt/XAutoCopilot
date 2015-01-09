--[[
-- Author: Ben Russell, br@x-plugins.com
-- Date: 18/03/14
-- Time: 5:56 PM

This file provides a caching layer on top of the icons resources so that we can consolidate our usage.
Icons may be used by many different bits of code.

--]]


icons = {}

icons.cache = {}


--[[/**
icons.get( icon_name, OPT_no_cache )

Returns: texture_id

Load an icon from Gizmo64.plugin/firmware/icons/

Acts as a common gateway to shared icon resources, provides caching so that we load a minimal set of texture copies.

Set no_cache to True if you require a unique copy of the icon texture.

<code>
local icon_save = icons.get("save.png")
</code>

API: >= 14.04
*/]]
icons.get = function(icon_name, no_cache)

    --console.log("icons.get: " .. icon_name)


    if (icon_name == nil) then
        --FIXME: return a nice broke-image icon
        return 0
    end




    local filename = gizmo.getFolder() .. "firmware/icons/" .. tostring(icon_name)

    --console.log("full filename: " .. filename)


    --define a local function that includes desired error handling.
    local function f_loadPng(filename)
        local ret, err = gfx.loadPng(filename)
        if (ret == nil) then
            console.warn(err)
            return icons.get("page_white_error.png")
        else
            return ret
        end
    end


    --caller can override caching and still retain easy access to icons.
    if (no_cache) then
        --return assert( gfx.loadPng( filename ) )
        return assert(f_loadPng(filename))
    end


    --normal ops. check cache.
    if (icons.cache[filename] == nil) then
        --icons.cache[ filename ] = assert( gfx.loadPng( filename ) )
        icons.cache[filename] = assert(f_loadPng(filename))
        --else
        --	console.log("icons: cache hit!")
    end


    return icons.cache[filename]
end



-- eof
