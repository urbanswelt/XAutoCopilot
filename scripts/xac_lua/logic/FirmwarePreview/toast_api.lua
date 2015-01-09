--[[
-- Author: Ben Russell, br@x-plugins.com
-- Date: 20/03/14
-- Time: 12:32 PM
--]]

--[[
-- toast API
 -
 Provides an easy to use API for popping toast messages for the User to interact with.
 -
--]]

toast = {}

toast.prefs = {
    width = 240,
    height = 64,
    right_margin = 40,
    top_margin = 20,
    step_margin = 4,
    border_width = 2,
}

--table of toast data
toast.plate = {}


--factory function that creates the data structure.
toast.toaster = function(toast_type, caption, message, custom_icon_file, custom_color)

    if (nil == caption) then error("No caption") end
    if (nil == message) then
        --a blank message can be useful when we want a really short debug message.
        message = ""
    end


    local new_slice = {}
    new_slice.caption = caption
    new_slice.message = message

    local icon_file = "smiley_red.png" --default to embaresed smiley in case something goes wrong with the loader.

    new_slice.type = toast_type

    local font_color = color.red --default to red for max vis. used in toast render function

    if ("error" == toast_type) then
        icon_file = "cancel.png"
        font_color = color.red

    elseif ("warning" == toast_type) then
        icon_file = "error.png"
        font_color = color.yellow


    elseif ("info" == toast_type) then
        icon_file = "exclamation.png"
        local blue = { unpack(color.blue) }
        blue[1] = 0.38
        blue[2] = 0.61
        blue[3] = 0.87
        font_color = blue

    elseif ("help" == toast_type) then
        icon_file = "lifebuoy.png"
        font_color = color.white


    elseif ("custom" == toast_type) then
        icon_file = custom_icon_file
        font_color = custom_color


    elseif ("other" == toast_type) then
        --icon_file = ".png"
    end

    --icon value set as part of factory parser.
    if (type(icon_file) == "number") then
        new_slice.icon = icon_file
    else
        new_slice.icon = icons.get(icon_file)
    end


    new_slice.draw = function(self, mouse_over)

        local font_color = font_color --take a local copy.

        gfx.texOff()
        local new_gray = { unpack(color.black) }
        new_gray[4] = 0.5
        gfx.setColor(new_gray)

        --background layer
        gfx.drawFilledBox(0, 0, toast.prefs.width, toast.prefs.height)

        --border
        local new_white = { unpack(color.white) }
        new_white[4] = 0.5
        gfx.setColor(new_white)

        if (mouse_over) then
            gfx.setColor(color.yellow)
        end



        gl.LineWidth(toast.prefs.border_width)
        gfx.drawBox(0, 0, toast.prefs.width, toast.prefs.height)
        gl.LineWidth(1)

        --icon
        gfx.texOn()
        gfx.setColor(color.white)
        gfx.useTexture(self.icon)
        gfx.drawTexturedQuad(8, 40, 16, 16)

        --draw caption text
        gfx.setColor(font_color)
        gfx.drawString(self.caption, 30, 45)


        --draw multiline content text
        gfx.setColor(color.white)

        local tokens = split(self.message, "\n") --split for newline char

        local msg = tokens[1]
        local px = (toast.prefs.width * 0.5) - (gfx.measureString(msg) * 0.5) --centered text!
        local py = 30
        local pstep = 15
        gfx.drawString(msg, px, py); py = py - pstep

        if (tokens[1] ~= tokens[2]) then
            local msg = tokens[2]
            local px = (toast.prefs.width * 0.5) - (gfx.measureString(msg) * 0.5)
            gfx.drawString(msg, px, py); py = py - pstep
        end

        --finished drawing... do we need a close box?
    end


    return new_slice
end


--[[/**
toast.newError( caption, message )

Returns: nothing

Display an error message on screen.

<code>
toast.newError( "toast", "message data" )
</code>

API: >= 14.04
*/]]
toast.newError = function(caption, message) --cancel.png OR cross.png

local new_slice = toast.toaster("error", caption, message)
table.insert(toast.plate, new_slice)
end


--[[/**
toast.newWarning( caption, message )

Returns: nothing

Display an warning message on screen.

<code>
toast.newWarning( "toast", "message data" )
</code>

API: >= 14.04
*/]]
toast.newWarning = function(caption, message) --error.png OR exclamation_octagon_fram

local new_slice = toast.toaster("warning", caption, message)
table.insert(toast.plate, new_slice)
end


--[[/**
toast.newInfo( caption, message )

Returns: nothing

Display an info message on screen.

<code>
toast.newInfo( "toast", "message data" )
</code>

API: >= 14.04
*/]]
toast.newInfo = function(caption, message) --exclamation.png

local new_slice = toast.toaster("info", caption, message)
table.insert(toast.plate, new_slice)
end


--[[/**
toast.newHelp( caption, message )

Returns: nothing

Display an help message on screen.

<code>
toast.newHelp( "toast", "message data" )
</code>

API: >= 14.04
*/]]
toast.newHelp = function(caption, message) --lifebuoy.png

local new_slice = toast.toaster("help", caption, message)
table.insert(toast.plate, new_slice)
end




-- Code to draw the items --

event.register("OnDraw_Windows", "toast_Windows_OnDraw")
function toast_Windows_OnDraw()


    local mx, my = mouse.getXY()


    gfx.setColor(color.red)
    gl.PushMatrix()

    --gl.Translate( 500,384,0 )

    local win_width, win_height = gfx.getScreenSize()

    --top right
    local top = win_height - ((toast.prefs.height + toast.prefs.step_margin) + toast.prefs.top_margin)
    local left = win_width - ((toast.prefs.width + toast.prefs.step_margin) + toast.prefs.right_margin)
    gl.Translate(left, top, 0)


    local px = left
    local py = top

    for si = 1, #toast.plate do
        local slice = toast.plate[si]

        --handle mouse_over detection
        local mouse_over = false
        local l, b, w, h = px, py, toast.prefs.width, toast.prefs.height

        if (PointCollisionTest:testQuad(l, b, w, h, mx, my)) then

            if (toast.click_data) then
                if (toast.click_data.x == mx) and (toast.click_data.y == my) then
                    slice.destroy = true
                    toast.click_data = nil --destroy click data so we don't get any accidental double events
                end
            end
            mouse_over = true
        end

        slice:draw(mouse_over)

        py = py - (toast.prefs.height + toast.prefs.step_margin) --update mouse_over tracking vars
        gl.Translate(0, -(toast.prefs.height + toast.prefs.step_margin), 0) --update GL
    end --loop all toast items

    toast.click_data = nil --reset any click data

    gl.PopMatrix()



    --All items have been drawn, we'll now do some cleanup to see if an item was clicked and set for destruction.
    for si = #toast.plate, 1, -1 do
        local slice = toast.plate[si]
        if (slice.destroy) then
            table.remove(toast.plate, si)
        end
    end --reverse loop of toast items to check for destruction flags
end

--toast_Windows_OnDraw()




event.register("OnMouseClick", "toast_OnMouseClick")
function toast_OnMouseClick()
    --This click_data is used inside the "toast_Windows_OnDraw" function to test for toast-region clicks.
    toast.click_data = mouse.click

    --need to do button region test here to work with click handling properly.

    --return 1
end





toast.test = function()
    toast.newError("Engine Failure", "Engine One has Over Heated\nLand A S A P.")
    toast.newWarning("Low Fuel", "Your fuel is running low.\nReview tank settings.")
    toast.newInfo("Perfect Landing", "Congratulations!\nYou Win!")
    toast.newHelp("Engine Tuning", "Your engine is running lean.\nReview mixture settings.")
end


--toast.test()




--eof
