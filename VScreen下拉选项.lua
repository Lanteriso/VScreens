
local favoriteNumber = 44 -- 初始值

-- Create the dropdown, and configure its appearance
local dropDown = CreateFrame("FRAME", "WPDemoDropDown", UIParent, "UIDropDownMenuTemplate")
dropDown:SetPoint("CENTER")
UIDropDownMenu_SetWidth(dropDown, 100)
UIDropDownMenu_SetText(dropDown, "变量值: " .. favoriteNumber)

-- 创建初始化函数并将其绑定到下拉菜单
UIDropDownMenu_Initialize(dropDown, function(self, level, menuList)
   local info = UIDropDownMenu_CreateInfo()




  local fonts = {"GameFontHighlightSmall", "GameFontHighlight", "GameFontHighlightMedium", "GameFontHighlightLarge"}
  local names = {1, 2, 3, 4}
  info.func = function(self)
    favoriteNumber = self.value
    print("___________________"..favoriteNumber)
    UIDropDownMenu_SetText(dropDown, "变量值: " .. favoriteNumber)
  end
  for i, font in next, fonts do

    info.value = i
    info.text, info.arg1, info.checked = font, i, i == favoriteNumber
    UIDropDownMenu_AddButton(info)

  end
end)