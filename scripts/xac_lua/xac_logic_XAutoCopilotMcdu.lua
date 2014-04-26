--
-- Created by IntelliJ IDEA.
-- User: larsurban
-- Date: 26.01.14
-- Time: 14:05
--

function XAutoCopilotMcdu_OnUpdate()

end


function XAutoCopilotMcdu_OnBeforeClose()
    dref.setInt(xac_tanker_on, 1)
    dref.setInt(xac_load_on, 1)
end

