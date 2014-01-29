--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 26.01.14
-- Time: 14:05
--

function XAutoCopilotMcdu_OnUpdate() end


function XAutoCopilotMcdu_OnBeforeClose()
--for variable, wert in pairs(table) do
    logging.debug(" Debug: dumping all variables in current Lua engine:")
    for n,v in pairs(_G) do
        logging.debug(tostring(n) .. " = " .. tostring(v))
    end

end