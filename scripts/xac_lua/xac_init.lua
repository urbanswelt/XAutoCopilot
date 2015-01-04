--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 23.01.14
-- Time: 19:24
--

dofile("xac_lua/xac_datarefs.lua")
logging.debug("loaded xac_datarefs..")

dofile("xac_lua/xac_function_helper.lua")
logging.debug("loaded function_helper..")

dofile("xac_lua/xac_window_XAutoCopilot.lua")
logging.debug("loaded xac_window_XAutoCopilot..")

dofile("xac_lua/xac_window_XAutoCopilotRoute.lua")
logging.debug("loaded xac_window_XAutoCopilotRoute..")

dofile("xac_lua/xac_window_XAutoCopilotBriefingDeparture.lua")
logging.debug("loaded xac_window_XAutoCopilotBriefingDeparture..")

dofile("xac_lua/xac_window_XAutoCopilotBriefingApproach.lua")
logging.debug("loaded xac_window_XAutoCopilotBriefingApproach..")

dofile("xac_lua/xac_window_XAutoCopilotFlightInfo.lua")
logging.debug("loaded xac_window_XAutoCopilotFlightInfo..")

dofile("xac_lua/xac_window_XAutoCopilotUpdater.lua")
logging.debug("loaded xac_window_XAutoCopilotUpdater..")

--dofile("xac_lua/xac_window_XAutoCopilotDebug.lua")
--logging.debug("loaded xac_window_XAutoCopilotDebug..")

-- Dataref in DRE w/o edit the xplane dataref.txt / activate only for testing !(longer loadtime)
--dofile("xac_lua/xac_publish_dataref.lua")
--logging.debug("loaded xac_publish_dataref..")

--New Firmware Features for Gizmo but not released from Ben now
dofile("xac_lua/NewGizmoFirmwarePreview/toast_api.lua")
dofile("xac_lua/NewGizmoFirmwarePreview/color_api.lua")
dofile("xac_lua/NewGizmoFirmwarePreview/icons_api.lua")
logging.debug("loaded NewFeature_api..")

