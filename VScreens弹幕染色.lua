----------------------VScreen弹幕染色--------------------
思路：
一：根据event为每一个弹幕添加SetTextColor属性
二：获取游戏聊天默认的颜色ChatTypeInfo[typeInfo]





local function J_SetObjectColorWithCurrentLogColor(obj,event,channelName)
  if event == "CHAT_MSG_CHANNEL" then
    local J_channelId, J_channelName
    local i
    -- Max: 20 channels
    for i=1,20 do
      J_channelId,J_channelName = GetChannelName(i)
      if channelName ~= nil and J_channelName == channelName then
        events[event].Info = "CHANNEL" .. J_channelId
        break
      end
    end
  end
  if ChatTypeInfo[events[event].Info] then
    obj:SetTextColor(ChatTypeInfo[events[event].Info].r, ChatTypeInfo[events[event].Info].g, ChatTypeInfo[events[event].Info].b, ChatTypeInfo[events[event].Info].a)
  end
end

function frameUpdate(self,elapsed)
    J_SetObjectColorWithCurrentLogColor(MessageScreen,event,channelName)
end









