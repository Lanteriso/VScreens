


local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED") 
frame:SetScript("OnEvent", function(self, event,...) 
        local message, sender, _, _, _, flags, _, _, channelName, _, _, guid = ...
        frameEvent(event,message, sender, flags, channelName,guid)
    if self[event] then

        return self[event](self, event, ...)
    end
end )


--C_ChatInfo.SendAddonMessage("ShortName", data, type, target)   /run C_ChatInfo.SendAddonMessage("ShortName", "测试", "PARTY") /run C_ChatInfo.SendAddonMessage("ShortName", "测试", "SAY")
function JoinChannels()
        local numActiveChannels = C_ChatInfo.GetNumActiveChannels()

        if numActiveChannels and (numActiveChannels >= 1) then
            if GetChannelName('ShortName') == 0 and numActiveChannels < MAX_WOW_CHAT_CHANNELS then
                JoinChannelByName('ShortName', nil, nil, true)

            end
        end
end
function SendChannels()
    local s = "Hello World"
    local index = GetChannelName("ShortName") -- It finds General is a channel at index 1

    if (index~=nil) then 
        print("--------------------------------------")
      SendChatMessage(s , "CHANNEL", nil, index); --在频道发言
      
      
      
    end
end


function frameEvent(event,message, sender, flags, channelName,guid)

    if event == "ADDON_LOADED" then return end
    print(event,message, sender, flags, channelName,guid)
end

function frame:ADDON_LOADED(event,...)
    
    C_ChatInfo.RegisterAddonMessagePrefix("ShortName")

    frame:RegisterEvent("CHAT_MSG_CHANNEL")--来自频道

    JoinChannels()
end









