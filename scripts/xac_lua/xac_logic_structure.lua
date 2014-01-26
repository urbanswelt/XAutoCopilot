--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 23.01.14
-- Time: 19:24
-- To change this template use File | Settings | File Templates.
--

dofile("xac_lua/xac_toolbar.lua")
logging.debug("loaded xac_toolbar..")

dofile("xac_lua/xac_datarefs.lua")
logging.debug("loaded xac_datarefs..")

dofile("xac_lua/xac_preparation.lua")
logging.debug("loaded xac_preparation..")

dofile("xac_lua/xac_beforestart.lua")
logging.debug("loaded xac_beforestart..")

dofile("xac_lua/xac_mcdu.lua")
logging.debug("loaded xac_mcdu..")

function OnUpdate()
    CockpitPreparation_OnUpdate()
    BeforeStart_OnUpdate()
end
