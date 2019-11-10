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


function frameEvent(event,message, sender, flags, channelName,guid)
	print(event,message, sender, flags, channelName,guid)
end

function frame:ADDON_LOADED(event,...)
    for event,v in pairs(events) do
      frame:RegisterEvent(event)
    end
    
end


--[[
1.创建一个frame
2.注册ADDON_LOADED事件
3.OnEvent事件触发时指向函数 分别是frameEven 和 self[event] 这两个
4.当触发ADDON_LOADED事件时 注册events列表的事件
5.当触发events列表的事件时 指向frameEvent函数 
--]]













