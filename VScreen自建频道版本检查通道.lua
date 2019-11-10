----------------------VScreen获取聊天信息--------------------
--[[
定义要注册的事件
等会遍历注册
--]]
events = {


  ['CHAT_MSG_ACHIEVEMENT'] = {
    type = "ACHIEVEMENT",
  },
  ['CHAT_MSG_BG_SYSTEM_ALLIANCE'] = {
    type = "BG_SYSTEM_ALLIANCE",
  },
  ['CHAT_MSG_BG_SYSTEM_HORDE'] = {
    type = "BG_SYSTEM_HORDE",
  },
  ['CHAT_MSG_BG_SYSTEM_NEUTRAL'] = {
    type = "BG_SYSTEM_NEUTRAL",
  },
  ['CHAT_MSG_BN_WHISPER'] = {
    type = "BN_WHISPER",
  },
  ['CHAT_MSG_BN_WHISPER_INFORM'] = {
    type = "BN_WHISPER_INFORM",
  },
  ['CHAT_MSG_CHANNEL'] = {
    type = "CHANNEL",
  },
  ['CHAT_MSG_CHANNEL_NOTICE'] = {
    type = "CHANNEL_NOTICE",
  },
  ['CHAT_MSG_EMOTE'] = {
    type = "EMOTE",
  },
  ['CHAT_MSG_GUILD'] = {
    type = "GUILD",
  },
  ['CHAT_MSG_GUILD_ACHIEVEMENT'] = {
    type = "GUILD_ACHIEVEMENT",
  },
  ['CHAT_MSG_INSTANCE_CHAT'] = {
    type = "INSTANCE_CHAT",
  },
  ['CHAT_MSG_INSTANCE_CHAT_LEADER'] = {
    type = "INSTANCE_CHAT",
  },
  ['CHAT_MSG_LOOT'] = {
    type = "LOOT",
  },
  ['CHAT_MSG_MONEY'] = {
    type = "MONEY",
  },
  ['CHAT_MSG_CURRENCY'] = {
    type = "CURRENCY",
  },
  ['CHAT_MSG_MONSTER_EMOTE'] = {
    type = "MONSTER_EMOTE",
  },
  ['CHAT_MSG_MONSTER_SAY'] = {
    type = "MONSTER_SAY",
  },
  ['CHAT_MSG_MONSTER_WHISPER'] = {
    type = "MONSTER_WHISPER",
  },
  ['CHAT_MSG_MONSTER_YELL'] = {
    type = "MONSTER_YELL",
  },
  ['CHAT_MSG_OFFICER'] = {
    type = "OFFICER",
  },
  ['CHAT_MSG_PARTY'] = {
    type = "PARTY",
  },
  ['CHAT_MSG_PARTY_LEADER'] = {
    type = "PARTY_LEADER",
  },
  ['CHAT_MSG_RAID'] = {
    type = "RAID", 
  },
  ['CHAT_MSG_RAID_LEADER'] = {
    type = "RAID_LEADER", 
  },
  ['CHAT_MSG_RAID_WARNING'] = {
    type = "RAID_WARNING", 
  },
  ['CHAT_MSG_SAY'] = {
    type = "SAY",
  },
  ['CHAT_MSG_SYSTEM'] = {
    type = "SYSTEM",
  },
  ['CHAT_MSG_TEXT_EMOTE'] = {
    type = "TEXT_EMOTE",
  },
  ['CHAT_MSG_WHISPER'] = {
    type = "WHISPER",
  },
  ['CHAT_MSG_WHISPER_INFORM'] = {
    type = "WHISPER_INFORM",
  },
  ['CHAT_MSG_YELL'] = {
    type = "YELL",
  },
  ['PARTY_LOOT_METHOD_CHANGED'] = {
    type = "SYSTEM",
  },
}


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
      C_ChatInfo.SendAddonMessage('ShortName', "测试", 'CHANNEL', GetChannelName('ShortName'))--在频道发测试
      
    end
end

function frame:SendMessages()
    local ShortName = GetChannelName('ShortName')
    if ShortName and ShortName > 0 then
        C_ChatInfo_SendAddonMessage('ShortName', "E.version", 'CHANNEL', GetChannelName('ShortName'))
    elseif IsInGuild() then
        C_ChatInfo_SendAddonMessage('ShortName', "E.version", 'GUILD')
    end
end
function frameEvent(event,message, sender, flags, channelName,guid)


    print(event,message, sender, flags, channelName,guid)
end

function frame:ADDON_LOADED(event,...)
    
    C_ChatInfo.RegisterAddonMessagePrefix("ShortName")
    frame:RegisterEvent('CHAT_MSG_ADDON')
    frame:RegisterEvent("CHAT_MSG_COMMUNITIES_CHANNEL")--社区渠道
    frame:RegisterEvent("CHAT_MSG_CHANNEL")--来自频道

    JoinChannels()
end
--local channel_type, channel_name = JoinChannelByName("Community:839528655:1", nil, ChatFrame1:GetID(), 1);




--RegisterAddonMessagePrefix

--  1 注册       C_ChatInfo.RegisterAddonMessagePrefix("ShortName")
--              frame:RegisterEvent('CHAT_MSG_ADDON')
--              frame:RegisterEvent("CHAT_MSG_COMMUNITIES_CHANNEL")--社区渠道
--              frame:RegisterEvent("CHAT_MSG_CHANNEL")--来自频道


--  2   function JoinChannels()  加入频道
--  3   function SendChannels()  发送信息








