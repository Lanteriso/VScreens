


local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED") 
frame:SetScript("OnEvent", function(self, event,...) 
		local message, sender, _, _, _, flags, _, _, channelName, _, _, guid = ...
		frameEvent(event,message, sender, flags, channelName,guid)
	if self[event] then

		return self[event](self, event, ...)
	end
end )
local function J_UnitFullName(unit)
    if not unit then return UNKNOWNOBJECT end
    local name, realm = UnitName(unit)
    if not realm or realm=="" then
        if not PLAYER_REALM or PLAYER_REALM=="" then
            PLAYER_REALM = GetRealmName()
        end
        realm = PLAYER_REALM
    end
    return name.."-"..realm
end

function frameEvent(event,message, sender, flags, channelName,guid)
if event == "CHAT_MSG_COMMUNITIES_CHANNEL" then
  local c_index,c_name = GetChannelName("Community:839528655:1")
	print(message, J_UnitFullName("player"),c_index,c_name)
end
end

function frame:ADDON_LOADED(event,...)

    frame:RegisterEvent("CHAT_MSG_COMMUNITIES_CHANNEL")
end
--local channel_type, channel_name = JoinChannelByName("Community:839528655:1", nil, ChatFrame1:GetID(), 1);

print("LRN")
local s = "Hello World"..J_UnitFullName("player")
local index = GetChannelName("Community:839528655:1") -- It finds General is a channel at index 1
if (index~=nil) then 
  SendChatMessage(s , "CHANNEL", nil, index); 
end













