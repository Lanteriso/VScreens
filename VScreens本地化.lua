	function TRAININGGROUNDS_FakeDBM_RaidBossEmote(message,duration,clear)
		-- center-screen raid notice is easy
		if(clear)then
			RaidNotice_Clear(RaidBossEmoteFrame)
		end
		RaidNotice_AddMessage(RaidBossEmoteFrame, message, ChatTypeInfo["RAID_BOSS_EMOTE"],duration)
		-- chat messages are trickier
		local i
		for i = 1, NUM_CHAT_WINDOWS do
			local chatframes = { GetChatWindowMessages(i) }			
			local v
			for _, v in ipairs(chatframes) do
				if v == "MONSTER_BOSS_EMOTE" then
					local frame = 'ChatFrame' .. i
					if _G[frame] then
						_G[frame]:AddMessage(message,1.0,1.0,0.0,GetChatTypeIndex(ChatTypeInfo["RAID_BOSS_EMOTE"].id))
					end
					break
				end
			end
		end
	end





	-- the fake DBM functions are strictly temporary.
			-- and we'll just keep telling ourselves that.

	--TODO: probably possible to check if DBM is installed before creating the frame
	local fakedbmframe = CreateFrame("Frame", "TRAININGGROUNDS_Fake_DBMWarning", UIParent)
	local function fake_testWarningEnd()
		fakedbmframe:SetFrameStrata("HIGH")
	end
	-- /run TRAININGGROUNDS_FakeDBM_MajorWarning(DBM,"Fake test alert",1)
	function TRAININGGROUNDS_FakeDBM_MajorWarning(dbm, text, number, noSound)
		local self=dbm	--TODO: also check if DBM is type table (in case we forgot it entirely and passed text as 1st arg)
		if(not self)then print(text) return end
	
		if moving then
			return
		end
		--self:AddSpecialWarning(DBM_CORE_MOVE_SPECIAL_WARNING_TEXT)
		self:AddSpecialWarning(text)
		fakedbmframe:SetFrameStrata("TOOLTIP")
		self:Unschedule(fake_testWarningEnd)
		self:Schedule(self.Options.SpecialWarningDuration2 * 1.3, fake_testWarningEnd)
		if number and not noSound then
			self:PlaySpecialWarningSound(number)
		end
		if self.Options.ShowFlashFrame and number then
			local flashColor = self.Options["SpecialWarningFlashCol"..number]
			local repeatCount = self.Options["SpecialWarningFlashRepeat"..number] and self.Options.SpecialWarningFlashRepeatAmount or 0
			self.Flash:Show(flashColor[1], flashColor[2], flashColor[3], self.Options["SpecialWarningFlashDura"..number], self.Options["SpecialWarningFlashAlph"..number], repeatCount)
		end
	end
	
	local ignore = {}
	local TRAININGGROUNDS_fakeMod=nil -- dummy mod for the, er, for the dummy mod for the countdown sound effects
	
	local function TRAININGGROUNDS_FakeDBM_Setup(dbm)
		--TODO: fix code reuse
		if (dbm and not TRAININGGROUNDS_fakeMod) then
			TRAININGGROUNDS_fakeMod = dbm:NewMod("FakeCreateCountTimerDummy")
			dbm:GetModLocalization("FakeCreateCountTimerDummy"):SetGeneralLocalization{ name = DBM_CORE_MINIMAP_TOOLTIP_HEADER }
			TRAININGGROUNDS_fakeMod.countdown = TRAININGGROUNDS_fakeMod:NewCountdown(0, 0, nil, nil, nil, true)
			--TRAININGGROUNDS_fakeMod.text = TRAININGGROUNDS_fakeMod:NewAnnounce("%s", 1, "Interface\\Icons\\Spell_Holy_BorrowedTime")
			TRAININGGROUNDS_fakeMod.text = TRAININGGROUNDS_fakeMod:NewAnnounce("%s", 1, nil)
			--print("FakeDBM_Setup successful")		
		else
			--print("FakeDBM_Setup unsuccessful (maybe already setup?)")
		end
	end
	
	-- /run TRAININGGROUNDS_FakeDBM_MinorWarning(DBM, "Test break timer")
	function TRAININGGROUNDS_FakeDBM_MinorWarning(dbm, text, broadcast, sender, count, loop, terminate)
		TRAININGGROUNDS_FakeDBM_Setup(dbm)
		local self=dbm	--TODO: also check if DBM is type table (in case we forgot it entirely and passed text as 1st arg)
		if((not self) or (not TRAININGGROUNDS_fakeMod))then print(text) return end		
		local time=0
		

		-- self.Bars:CreateBar(time, text, "Interface\\Icons\\Spell_Holy_BorrowedTime")
		-- --dbm:FireEvent("DBM_TimerStart", "DBMBreakTimer", text, time, "Interface\\Icons\\Spell_Holy_BorrowedTime", "breaktimer", nil, 0)
		-- dbm:FireEvent("DBM_TimerStart", "break", text, timer, "Interface\\Icons\\Spell_Holy_BorrowedTime", "utilitytimer", nil, 0)
		
		TRAININGGROUNDS_fakeMod.text:Cancel()
		TRAININGGROUNDS_fakeMod.text:Show(text)
	
	end
	
	function TRAININGGROUNDS_FakeDBM_Countdown(dbm, time)
		TRAININGGROUNDS_FakeDBM_Setup(dbm)
		local self=dbm	--TODO: also check if DBM is type table (in case we forgot it entirely and passed time as 1st arg)		
		--if((not self) or (not TRAININGGROUNDS_fakeMod))then print("(If you had DBM installed, you would hear a "..tostring(time).."-second countdown.)") return end	
		if((not self) or (not TRAININGGROUNDS_fakeMod))then print("(DBM:  "..tostring(time).."-second countdown.)") return end	
		print("(DBM:  "..tostring(time).."-second countdown.)")

		
		TRAININGGROUNDS_fakeMod.countdown:Cancel()
		TRAININGGROUNDS_fakeMod.countdown:Start(time)			
	end
	
	function TRAININGGROUNDS_FakeDBM_CancelCountdown(dbm)
		TRAININGGROUNDS_FakeDBM_Setup(dbm)
		local self=dbm
		if((not self) or (not TRAININGGROUNDS_fakeMod))then return end
		TRAININGGROUNDS_fakeMod.countdown:Cancel()
	end


function function_jany()
	-- body

		local totaltime=0
		--TODO: surely there are more than 3 overflows...??
		local overflow_times={16.0,60.0+3.0,60.0+34.0}
		for i=1,#overflow_times do
			local event=TRAININGGROUNDS_TimedDanceEvent.new()
			totaltime=TIME_OFFSET+overflow_times[i]
			if(totaltime>0)then
				event.time=self.scenario.localtime+totaltime
				event.execute=function() 	
							local iconsize="20"
							local icon="\124Tinterface\\icons\\sha_ability_warrior_bloodnova_nightmare:"..iconsize.."\124t"
							local link="\124cffff0000\124Hspell:295346\124h[Overflow]\124h\124r"			
							local message=icon..""..link.." -- drop at edge of room"	
							TRAININGGROUNDS_FakeDBM_RaidBossEmote(message,2.0,false)
							TRAININGGROUNDS_SIVARA_Overflow_AssignRandomOverflowToRaid(self)
						end;tinsert(self.timedevents,event)	
			end		
			-- during overflow, move into position
			local event=TRAININGGROUNDS_TimedDanceEvent.new()
					-- (1 second reaction time)
			totaltime=TIME_OFFSET+overflow_times[i]+1
			if(totaltime>0)then
				event.time=self.scenario.localtime+totaltime
				event.execute=function() 	
						TRAININGGROUNDS_SIVARA_Overflow_MoveOverflowCPUsToDropoffPoints(self)
					end;tinsert(self.timedevents,event)					
			end		
			-- AFTER overflow, move back to position
			
		end
end

function function_jany2()

							local iconsize="20"
							local icon="\124Tinterface\\icons\\sha_ability_warrior_bloodnova_nightmare:"..iconsize.."\124t"
							local link="\124cffff0000\124Hspell:295346\124h[Overflow]\124h\124r"			
							local message=icon..""..link.." -- drop at edge of room"	
							TRAININGGROUNDS_FakeDBM_RaidBossEmote(message,2.0,false)
							

end