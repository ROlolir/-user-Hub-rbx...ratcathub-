local RauConfig = {}

RauConfig.HubName = "Rau.cat HUB"
RauConfig.AllowedNames = {
    "player000",
}

function RauConfig.isAllowed(playerName)
    for _, name in ipairs(RauConfig.AllowedNames) do
        if name == playerName then
            return true
        end
    end
    return false
end

return RauConfig
