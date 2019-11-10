----------------------VScreen让弹幕动起来--------------------
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

local x = 1

local frame = CreateFrame("Frame", nil, UIParent)

frame:SetFrameStrata("BACKGROUND")
frame:SetWidth(64) -- Set these to whatever height/width is needed 
frame:SetHeight(64) -- for your Texture
frame:SetPoint("CENTER",0,0)
frame:Show()

local MessageScreen = frame:CreateFontString(nil, "ARTWORK")
MessageScreen:SetFont(GameFontNormal:GetFont(), 20)
MessageScreen:SetWidth(500)
MessageScreen:SetJustifyH("LEFT")


frame:RegisterEvent("ADDON_LOADED") 

frame:SetScript("OnEvent", function(self, event,...) 
	local message, sender, _, _, _, flags, _, _, channelName, _, _, guid = ...
	frameEvent(event,message, sender, flags, channelName,guid)
	if self[event] then

		return self[event](self, event, ...)
	end
end )

function frameUpdate(self,elapsed)
	x = x + elapsed*50
	frame:SetPoint("CENTER", 600-x, 0)
end
function frameEvent(event,message, sender, flags, channelName,guid)
	MessageScreen = frame:CreateFontString(nil, "ARTWORK")
	MessageScreen:SetFont(GameFontNormal:GetFont(), 20)
	MessageScreen:SetWidth(500)
	MessageScreen:SetJustifyH("LEFT")
	MessageScreen:SetPoint("CENTER", frame, "CENTER", 600+x, random(-500,500))
	MessageScreen:SetText(message)
end

function frame:ADDON_LOADED(event,...)
	frame:SetScript("OnUpdate", frameUpdate)

    for event,v in pairs(events) do
      frame:RegisterEvent(event)
    end
end




--[[
思路：在frame上放文字MessageScreen 然后不停的移动frame 这样就是弹幕的效果

1.给frame添加一个父类 UIParent 让它在魔兽UI上滚
2.给frame添加一些基本属性 SetFrameStrata SetWidth SetHeight SetPoint ..
3.继承frame 创建 CreateFontString 用来添加文字 
4.当有信息时 创建新的 CreateFontString 这样文字就被添加到  frame 上
5.滚动 frame，这里用的是OnUpdate方法，先在frame:ADDON_LOADED里注册OnUpdate，让它指向frameUpdate，然后不停的SetPoint

--]]









