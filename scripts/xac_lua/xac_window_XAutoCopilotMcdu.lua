--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 25.01.14
-- Time: 17:03
-- http://gizmo.x-plugins.com/docs/Gizmo_API.htm / http://lua.gts-stolberg.de/string.php / http://www.torsten-horn.de/techdocs/ascii.htm 
-- http://de.wikipedia.org/wiki/%C3%9Cbergangsh%C3%B6he / http://de.wikipedia.org/wiki/Flugfl%C3%A4che / http://www.pilotundrecht.de/TEXTE/DOWNLOAD/translevneu.pdf
--

XAutoCopilotMcdu = {
    gui_h = gui.newWindow("XAutoCopilotMcdu"),
    l = 300, --left position on screen
    t = 430, --top position on screen
    w = 250, --window width
    h = 180, --window height
    auto_show=false,
}

function XAutoCopilotMcdu_OnCreate()
    local w,h = gfx.getScreenSize()

    --gui.setWindowSize( gui_window_id, left, top, width, height )
    gui.setWindowSize( XAutoCopilotMcdu.gui_h, XAutoCopilotMcdu.l, XAutoCopilotMcdu.t, XAutoCopilotMcdu.w, XAutoCopilotMcdu.h )
    gui.setWindowCaption( XAutoCopilotMcdu.gui_h, "A320 MCDU Settings" )

    local xac_left    = 10
    local xac_top     = 30
    local xac_width   = 100

    gui.newLabel( XAutoCopilotMcdu.gui_h, "ignored", "Company Route",      				xac_left+100, xac_top,    xac_width-50 )
    gui.newLabel( XAutoCopilotMcdu.gui_h, "ignored", "Flight Number",      					xac_left+100, xac_top+15, xac_width-50 )
    gui.newLabel( XAutoCopilotMcdu.gui_h, "ignored", "Cost Index",         					xac_left+100, xac_top+30, xac_width-50 )
    gui.newLabel( XAutoCopilotMcdu.gui_h, "ignored", "Cruize Flightlevel", 					xac_left+100, xac_top+45, xac_width-50 )
	gui.newLabel( XAutoCopilotMcdu.gui_h, "ignored", "Transition Alt DEP APT", 		xac_left+100, xac_top+60, xac_width-50 ) -- Germany 5000ft, USA Canada 18000ft
	gui.newLabel( XAutoCopilotMcdu.gui_h, "ignored", "Transition Alt ARR APT", 		xac_left+100, xac_top+75, xac_width-50 ) -- Germany 5000ft, USA Canada 18000ft	
    gui.newLabel( XAutoCopilotMcdu.gui_h, "ignored", "Flaps",              						xac_left+100, xac_top+90, xac_width-50 )
    gui.newLabel( XAutoCopilotMcdu.gui_h, "ignored", "Flex temp",          					xac_left+100, xac_top+105, xac_width-50 )

    xac_corte			= gui.newTextBox( XAutoCopilotMcdu.gui_h, "ignored", "KMMHKSFO", xac_left, xac_top,    xac_width )
    xac_fltnbr			= gui.newTextBox( XAutoCopilotMcdu.gui_h, "ignored", "KOM123",   	xac_left, xac_top+15, xac_width )
    xac_coi				= gui.newTextBox( XAutoCopilotMcdu.gui_h, "ignored", "99",       			xac_left, xac_top+30, xac_width )
    xac_crzfl			= gui.newTextBox( XAutoCopilotMcdu.gui_h, "ignored", "200",      			xac_left, xac_top+45, xac_width )
	xac_trans_dep	= gui.newTextBox( XAutoCopilotMcdu.gui_h, "ignored", "18000",      		xac_left, xac_top+60, xac_width )
	xac_trans_arr	= gui.newTextBox( XAutoCopilotMcdu.gui_h, "ignored", "6000",      		xac_left, xac_top+75, xac_width )	
    xac_flaps			= gui.newTextBox( XAutoCopilotMcdu.gui_h, "ignored", "2/UP2.0",  		xac_left, xac_top+90, xac_width )
    xac_flex_temp	= gui.newTextBox( XAutoCopilotMcdu.gui_h, "ignored", "F50",      			xac_left, xac_top+105, xac_width )

    gui.newButton( XAutoCopilotMcdu.gui_h, "XAutoCopilotMcdu_btnStart", "Start", 			xac_left, xac_top+125, xac_width-50 )

end


function XAutoCopilotMcdu_btnStart_OnClick()
    dref.setInt(xac_alt100x, gui.getWidgetValue(xac_crzfl))
    tmp_xac_corte			= string.upper(gui.getWidgetValue(xac_corte))
    tmp_xac_corte_l		= string.len	(tmp_xac_corte)
    tmp_xac_fltnbr			= string.upper(gui.getWidgetValue(xac_fltnbr))
    tmp_xac_coi				= string.upper(gui.getWidgetValue(xac_coi))
    tmp_xac_crzfl			= string.upper(gui.getWidgetValue(xac_crzfl))
	tmp_xac_trans_dep	= string.upper(gui.getWidgetValue(xac_trans_dep))
	tmp_xac_trans_arr 	= string.upper(gui.getWidgetValue(xac_trans_arr))
    tmp_xac_flaps			= string.upper(gui.getWidgetValue(xac_flaps))
    tmp_xac_flex_temp 	= string.upper(gui.getWidgetValue(xac_flex_temp))
--[[    if tmp_xac_corte_l == 0 or tmp_xac_corte_l > 3 then
        gui.setFocus( xac_corte )
        sound.say("CO-RTE FILE NOT FOUND")
    end]]

	local xac_multip 		= 0.3
	
    timer.newOneShot("step1", (xac_multip * 1))
    timer.newOneShot("step2", (xac_multip * 2))
    timer.newOneShot("step3", (xac_multip * 3))
    timer.newOneShot("step4", (xac_multip * 4))
    timer.newOneShot("step5", (xac_multip * 5))
    timer.newOneShot("step6", (xac_multip * 6))
    timer.newOneShot("step7", (xac_multip * 7))
    timer.newOneShot("step8", (xac_multip * 8))
    timer.newOneShot("step9", (xac_multip * 9))
    timer.newOneShot("step10", (xac_multip * 10))
	timer.newOneShot("step11", (xac_multip * 11))
	timer.newOneShot("step12", (xac_multip * 12))
	timer.newOneShot("step13", (xac_multip * 13))
	timer.newOneShot("step14", (xac_multip * 14))
	timer.newOneShot("step15", (xac_multip * 15))
	timer.newOneShot("step16", (xac_multip * 16))
	timer.newOneShot("step17", (xac_multip * 17))
end

-- ##################################INIT PAGE BEGIN##############################################
function step1()
    dref.setInt(xac_click_init, 1) 								-- go to init page
    dref.setString(xac_scratchpad, tmp_xac_corte) 	-- Copy Company Route to scratchpad
    dref.setInt(xac_click_l1, 1) 									-- click left 1
end

function step2()
    dref.setString(xac_scratchpad, tmp_xac_fltnbr) 	-- Copy Flight Number to scratchpad
    dref.setInt(xac_click_l3, 1)									-- click left 3
end

function step3 ()
    dref.setString(xac_scratchpad, tmp_xac_coi)		-- Copy Cost Index to scratchpad
    dref.setInt(xac_click_l5, 1)									-- click left 5
end

function step4 ()
    dref.setString(xac_scratchpad, tmp_xac_crzfl)		-- Copy Cruize Flightlevel to scratchpad
    dref.setInt(xac_click_l6, 1)									-- click left 6
end

function step5 ()
    dref.setInt(xac_click_right, 1)								-- second init page
end

function step6 ()
    dref.setInt(xac_click_r1, 1)									-- ZFWCG / ZFW
    dref.setInt(xac_click_r2, 1)									-- BLOCK
end

-- sim/cockpit2/fuel_quantity

-- ##################################INIT PAGE END##############################################

-- ##################################PERF PAGE TAKE OFF BEGIN#################################
function step7 ()
    dref.setInt(xac_click_perf, 1)									-- go to performance page
    dref.setInt(xac_click_l1, 1)										-- click V1
    dref.setInt(xac_click_l2, 1)										-- click VR
    dref.setInt(xac_click_l3, 1)										-- click V2
end

function step8 ()
    dref.setString(xac_scratchpad, tmp_xac_flaps)			-- Copy Flaps to scratchpad
    dref.setInt(xac_click_r3, 1)										-- click right 3
end

function step9 ()
	dref.setString(xac_scratchpad, tmp_xac_trans_dep)	-- Copy Transition Altitude to scratchpad
	dref.setInt(xac_click_l4, 1)										-- click left 4
end

function step10 ()
    dref.setString(xac_scratchpad, tmp_xac_flex_temp)	-- Copy Flex trmp to scratchpad
    dref.setInt(xac_click_r4, 1)										-- click right 4
end

function step11 ()
    dref.setInt(xac_click_r6, 1)										-- click next phase
end
-- ##################################PERF PAGE TAKE OFF END##################################

-- ##################################PERF PAGE CLIMB PHASE BEGIN#############################
function step12 ()
    dref.setInt(xac_click_r6, 1)										-- click next phase
end
-- ##################################PERF PAGE CLIMB PHASE END###############################

-- ##################################PERF PAGE CRZ PHASE BEGIN###############################
function step13 ()
    dref.setInt(xac_click_r6, 1)										-- click next phase
end
-- ##################################PERF PAGE CRZ PHASE END#################################

-- ##################################PERF PAGE DES PHASE BEGIN###############################
function step14 ()
    dref.setInt(xac_click_r6, 1)										-- click next phase
end
-- ##################################PERF PAGE DES PHASE END#################################

-- ##################################PERF PAGE APPR PHASE BEGIN##############################
function step15 ()
	--set qnh for ARR ARP
    --dref.setInt(xac_click_l1, 1)										-- click left 1
end

function step16 ()
	dref.setString(xac_scratchpad, tmp_xac_trans_arr)	-- Copy Transition Altitude to scratchpad
    dref.setInt(xac_click_l4, 1)										-- click left 4
end
-- ##################################PERF PAGE APPR PHASE END###############################

-- ##################################INIT PAGE BEGIN############################################
function step17 ()
    dref.setInt(xac_click_init, 1) -- go to init page
    dref.setInt(xac_click_r3, 1) -- press Allign IRS
end
-- ##################################INIT PAGE END##############################################

-- Toolbar Widget definition/Integration. --

ToolXAutoCopilotMcdu = {
    active = true,
    texture = gfx.loadPng(gizmo.getFolder() .. "firmware/icons/hammer_screwdriver.png"),
    name = "XAutoCopilotMcdu",
    run = function(self)
        if (XAutoCopilotMcdu) then
            gui.showWindow(XAutoCopilotMcdu.gui_h)
        else
            self.active = false
        end
    end,
}

if (ToolTray) then
    ToolTray:register(ToolXAutoCopilotMcdu)
end