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

local xx = 1



local VScreens_OptionsFrame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
VScreens_OptionsFrame:Hide()
VScreens_OptionsFrame.name = "VScreens"
VScreens_OptionsFrame:SetScript("OnShow", function(self)
    if self.show then return end
    local guangao = VScreens_OptionsFrame:CreateFontString(nil,"ARTWORK","GameFontNormal")
    guangao:SetTextColor(255,255,0)
    guangao:SetPoint("RIGHT",0,-220)
    guangao:SetText("Author:JANYROO")
  local counta = 0
  for key,value in pairs(VScreens_Options_v) do
    local dptitle = VScreens_OptionsFrame:CreateFontString(nil,"ARTWORK","GameFontNormal")
    dptitle:SetTextColor(1,1,1)
    dptitle:SetPoint("RIGHT",0,-40*counta+20)
    dptitle:SetText(key)
    local editBox = CreateFrame("EditBox", "VScreens_Options_v_"..key, VScreens_OptionsFrame, "InputBoxTemplate")
    editBox:SetSize(100, 20)
    editBox:SetPoint("RIGHT",0,-40*counta)
    editBox:SetAutoFocus(false)
    editBox:SetText(value)
    editBox:SetCursorPosition(0)
    counta=counta+1
  end


    local count,countx=0,0
    for key,value in pairs(VScreens_Options) do
        count=count+1
        if count>15 then countx,count=countx+1,0 end
        local button = CreateFrame("CheckButton", "VScreens_Options_"..key, VScreens_OptionsFrame, "InterfaceOptionsCheckButtonTemplate")
        button:SetPoint("TOPLEFT", 32+200*countx, -32-32*count)
        getglobal(button:GetName().."Text"):SetText(key)
        if value == true then button:SetChecked(true) else button:SetChecked(false) end
    end 
    self.show = true
    VScreens_OptionsFrame:SetScript("OnHide", function(self)
        for key,value in pairs(VScreens_Options) do
            if _G["VScreens_Options_"..key]:GetChecked() then
                if VScreens_Options[(key)] ~= true then
                    VScreens_Options[(key)] = true
    
                end
            else
                if VScreens_Options[(key)] ~= false then
                    VScreens_Options[(key)] = false

                end
            end
        end

    for key,value in pairs(VScreens_Options_v) do
      if _G["VScreens_Options_v_"..key]:GetText() then
        VScreens_Options_v[key]=_G["VScreens_Options_v_"..key]:GetText()

      end
    end   
    end)
end)
InterfaceOptions_AddCategory(VScreens_OptionsFrame)


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
    xx = xx + elapsed*VScreens_Options_v["ScreenSpeed"]
    frame:SetPoint("CENTER", VScreens_Options_v["ScreenRight"]-xx, 0)
end
function frameEvent(event,message, sender, flags, channelName,guid)
    if VScreens_Options_v == nil or VScreens_Options == nil then return end

    if VScreens_Options[event] == false then return end
    MessageScreen = frame:CreateFontString(nil, "ARTWORK")
    MessageScreen:SetFont(GameFontNormal:GetFont(), VScreens_Options_v["ScreenFontsize"])
    MessageScreen:SetWidth(500)
    MessageScreen:SetJustifyH("LEFT")
    MessageScreen:SetPoint("CENTER", frame, "CENTER", VScreens_Options_v["ScreenRight"]+xx, random(VScreens_Options_v["ScreenBottom"],VScreens_Options_v["ScreenTop"]))
    MessageScreen:SetText(message)
end

function frame:ADDON_LOADED(event,...)
    frame:SetScript("OnUpdate", frameUpdate)


    if VScreens_Options_v == nil then VScreens_Options_v = {} end
    if VScreens_Options_v["ScreenRight"] == nil then VScreens_Options_v["ScreenRight"] = 600 end
    if VScreens_Options_v["ScreenTop"] == nil then VScreens_Options_v["ScreenTop"] = 500 end
    if VScreens_Options_v["ScreenBottom"] == nil then VScreens_Options_v["ScreenBottom"] = -500 end
    if VScreens_Options_v["ScreenFontsize"] == nil then VScreens_Options_v["ScreenFontsize"] = 20 end
    if VScreens_Options_v["ScreenSpeed"] == nil then VScreens_Options_v["ScreenSpeed"] = 50 end

    if VScreens_Options == nil then VScreens_Options = {} end
    for event,v in pairs(events) do
        if VScreens_Options[event] == nil then VScreens_Options[event] = true end
        frame:RegisterEvent(event)
    end



end














