local _, Addon = ...
local PLAYER_GUID = nil
local GetTime = GetTime
local GetSpellCooldown = GetSpellCooldown
local GetInventoryItemCooldown = GetInventoryItemCooldown
local data = Addon.data

local Cramp = CreateFrame('Frame')
Cramp:SetPoint('CENTER')
Cramp:SetScript('OnEvent', function(self, event, ...) self[event](self, ...) end)
Cramp:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
Cramp:RegisterEvent('UNIT_INVENTORY_CHANGED', 'player')
Cramp:RegisterUnitEvent('PLAYER_SPECIALIZATION_CHANGED', 'player')
Cramp:RegisterEvent('PLAYER_REGEN_ENABLED')
Cramp:RegisterEvent('PLAYER_LOGIN')
Cramp.button = {}
Addon.core = Cramp


local ShowGlow = function(self)
      self.shadow:SetVertexColor(1, 1, 0, .7)
end
local HideGlow = function(self)
      self.shadow:SetVertexColor(0, 0, 0, .7)
end

local function CreateButton(i)
      local button = CreateFrame('Button', nil, Cramp)
      button:EnableMouse(false)
      button:SetSize(32, 32)

      button.icon = button:CreateTexture(nil, 'ARTWORK')
      button.icon:SetTexCoord(.1, .9, .1, .9)
      button.icon:SetSize(26, 26)
      button.icon:SetPoint('CENTER')

      button.cd = CreateFrame('Cooldown', nil, button)
      button.cd:ClearAllPoints()
      button.cd:SetAllPoints(button.icon)

      button.shadow = button:CreateTexture(nil, 'BACKGROUND')
      button.shadow:SetTexture('Interface\\AddOns\\Cramp\\shadow')
      button.shadow:SetSize(40, 40)
      button.shadow:SetPoint('CENTER')

      button.ShowGlow = ShowGlow
      button.HideGlow = HideGlow

      if i == 3 then
            button.stack = button:CreateFontString(nil, 'OVERLAY')
            button.stack:SetFont('Fonts\\HiraginoSansGBW6.otf', 18, 'OUTLINE')
            button.stack:SetPoint('BOTTOM', button, 'TOP', 0, 0)
      end

      return button
end

for i = 1, 7 do
      local button = CreateButton(i)
      if i == 1 then
            button:SetPoint('LEFT', UIParent, 'CENTER', -54, -164)
      else
            button:SetPoint('RIGHT', Cramp.button[i-1], 'LEFT', -4, 0)
      end
      button:HideGlow()
      Cramp.button[i] = button
end

function Cramp:UNIT_INVENTORY_CHANGED(unit)
      local itemID = nil

      self.button[7].icon:SetTexture(GetItemIcon(GetInventoryItemID('player', 15)) or 'Interface\\PaperDoll\\UI-PaperDoll-Slot-Chest') -- GetItemSpell(GetInventoryItemID('player',15))
      self.button[7].cd:SetCooldown(GetInventoryItemCooldown('player', 15))

      self.button[6].icon:SetTexture(GetItemIcon(GetInventoryItemID('player', 6)) or 'Interface\\PaperDoll\\UI-PaperDoll-slot-Waist') -- GetItemSpell(GetInventoryItemID('player',6))
      self.button[6].cd:SetCooldown(GetInventoryItemCooldown('player', 6))

      self.button[5].icon:SetTexture(GetItemIcon(GetInventoryItemID('player', 10)) or 'Interface\\PaperDoll\\UI-PaperDoll-slot-Hands') -- GetItemSpell(GetInventoryItemID('player',10))
      self.button[5].cd:SetCooldown(GetInventoryItemCooldown('player', 10))

      itemID = GetInventoryItemID('player', 13)
      self.button[1].icon:SetTexture(GetItemIcon(itemID) or 'Interface\\paperdoll\\UI-PaperDoll-slot-Trinket')
      if data[itemID] then
            self.button[1].icon:SetDesaturated(0)
            self.button[1].Cooldown = data[itemID].Cooldown
            self.button[1].SpellID = data[itemID].SpellID
            self.button[1].Duration = data[itemID].Duration
      else
            self.button[1].icon:SetDesaturated(1)
            self.button[1].Cooldown = nil
            self.button[1].SpellID = nil
            self.button[1].Duration = nil
      end
      if itemID then
            if itemID ~= self.button[1].ItemID then
                  if GetInventoryItemCooldown('player', 13) > 0 then
                        self.button[1].cd:SetCooldown(GetInventoryItemCooldown('player', 13))
                  elseif data[itemID] then
                        self.button[1].cd:SetCooldown(GetTime(), self.button[1].Cooldown)
                  else
                        self.button[1].cd:SetCooldown(0, 0)
                  end
            end
      else
            self.button[1].cd:SetCooldown(0, 0)
      end
      self.button[1].ItemID = itemID

      itemID = GetInventoryItemID('player', 14)
      self.button[2].icon:SetTexture(GetItemIcon(itemID) or 'Interface\\paperdoll\\UI-PaperDoll-slot-Trinket')
      if data[itemID] then
            self.button[2].icon:SetDesaturated(0)
            self.button[2].Cooldown = data[itemID].Cooldown
            self.button[2].SpellID = data[itemID].SpellID
            self.button[2].Duration = data[itemID].Duration
      else
            self.button[2].icon:SetDesaturated(1)
            self.button[2].Cooldown = nil
            self.button[2].SpellID = nil
            self.button[2].Duration = nil
      end
      if itemID then
            if itemID ~= self.button[2].ItemID then
                  if GetInventoryItemCooldown('player', 14) > 0 then
                        self.button[2].cd:SetCooldown(GetInventoryItemCooldown('player', 14))
                  elseif data[itemID] then
                        self.button[2].cd:SetCooldown(GetTime(), self.button[2].Cooldown)
                  else
                        self.button[2].cd:SetCooldown(0, 0)
                  end
            end
      else
            self.button[2].cd:SetCooldown(0, 0)
      end
      self.button[2].ItemID = itemID
end

function Cramp:PLAYER_SPECIALIZATION_CHANGED()
      local spec = GetSpecialization()
      if not spec then return end
      local specID = GetSpecializationInfo(spec)
      if not specID then
            return
      elseif specID == 70 then -- Retribution
            self.button[3].icon:SetTexture(GetSpellTexture(86698))
            self.button[4].icon:SetTexture(GetSpellTexture(31884))
      elseif specID == 66 then -- Protection
            self.button[3].icon:SetTexture(GetSpellTexture(86659))
            self.button[4].icon:SetTexture(GetSpellTexture(31850))
      end 
end

function Cramp:PLAYER_REGEN_ENABLED()
      self.button[3].cd:SetCooldown(GetSpellCooldown(86698))
end

function Cramp:PLAYER_LOGIN()
      PLAYER_GUID = UnitGUID('player')
      self:UNIT_INVENTORY_CHANGED()
      self.button[1].ItemID = GetInventoryItemID('player', 13)
      self.button[2].ItemID = GetInventoryItemID('player', 14)
      self.button[3].icon:SetTexture('Interface\\PaperDoll\\UI-PaperDoll-Slot-Relic')
      self.button[4].icon:SetTexture('Interface\\PaperDoll\\UI-PaperDoll-Slot-Relic')
      self:PLAYER_SPECIALIZATION_CHANGED()
      if ConceptionCORE then self:SetParent(ConceptionCORE) end
end

local CombatEvent = setmetatable({}, {__index = function() return function() end end})

function Cramp:COMBAT_LOG_EVENT_UNFILTERED(_, event, _, sourceGUID, _, destGUID, destName, _, _, _, _, spellID, spellName)
      if sourceGUID ~= PLAYER_GUID then return end
      if event ~= 'SPELL_AURA_APPLIED' and event ~= 'SPELL_AURA_APPLIED_DOSE' and event ~= 'SPELL_AURA_REMOVED' and event ~= 'SPELL_CAST_SUCCESS' then return end
      CombatEvent[event](self, spellID)
end

function CombatEvent:SPELL_AURA_APPLIED(spellID)
      if spellID == self.button[1].SpellID then -- trinket 1
            self.button[1]:ShowGlow()
            self.button[1].start = GetTime()
            self.button[1].cd:SetCooldown(GetTime(), self.button[1].Duration)
            return
      elseif spellID == self.button[2].SpellID then -- trinket 2
            self.button[2]:ShowGlow()
            self.button[2].start = GetTime()
            self.button[2].cd:SetCooldown(GetTime(), self.button[2].Duration)
            return
      elseif spellID == 86659 then -- 遠古豬王守護者 (防護)
            self.button[3]:ShowGlow()
            self.button[3].cd:SetCooldown(GetTime(), 12)
            return
      elseif spellID == 86698 then -- 遠古豬王守護者 (懲戒)
            self.button[3].cd:SetCooldown(GetTime(), 30)
            return
      elseif spellID == 86700 then -- 遠古力量
            self.button[3]:ShowGlow()
            self.button[3].stack:SetText('1')
            return
      elseif spellID == 31850 then -- 忠誠防衛者
            self.button[4]:ShowGlow()
            self.button[4].cd:SetCooldown(GetTime(), 10)
      elseif spellID == 31884 then -- 復仇之怒
            self.button[4]:ShowGlow()
            self.button[4].cd:SetCooldown(GetTime(), 30)
            return
      elseif spellID == 96229 then -- 神經突觸彈簧
            self.button[5]:ShowGlow()
            self.button[5].cd:SetCooldown(GetTime(), 10)
            return
      elseif spellID == 54861 then -- 硝基推進器
            self.button[6]:ShowGlow()
            self.button[6].cd:SetCooldown(GetTime(), 5)
            return
      elseif spellID == 126389 then -- 哥布林滑翔裝置
            self.button[7]:ShowGlow()
            self.button[7].cd:SetCooldown(GetTime(), 120)
            return
      elseif spellID == 146194 then -- 雪怒亂舞
            self.button[7]:ShowGlow()
            return
      end
end

function CombatEvent:SPELL_AURA_APPLIED_DOSE(spellID)
      if spellID == 86700 then  -- 遠古力量
            self.button[3].stack:SetText(1 + tonumber(self.button[3].stack:GetText()) or 0)
      end
end

function CombatEvent:SPELL_AURA_REMOVED(spellID)
      if spellID == self.button[1].SpellID then -- trinket 1
            self.button[1]:HideGlow()
            self.button[1].cd:SetCooldown(self.button[1].start or 0, self.button[1].Cooldown)
            return
      elseif spellID == self.button[2].SpellID then -- trinket 2
            self.button[2]:HideGlow()
            self.button[2].cd:SetCooldown(self.button[2].start or 0, self.button[2].Cooldown)
            return
      elseif spellID == 86659 then -- 遠古豬王守護者 (防護)
            self.button[3]:HideGlow()
            self.button[3].cd:SetCooldown(GetSpellCooldown(spellID))
            return
      elseif spellID == 86698 then -- 遠古豬王守護者 (懲戒)
            self.button[3].cd:SetCooldown(GetSpellCooldown(spellID))
            return
      elseif spellID == 86700 then -- 遠古力量
            self.button[3]:HideGlow()
            self.button[3].stack:SetText(nil)
            return
      elseif spellID == 31850 then -- 忠誠防衛者
            self.button[4]:HideGlow()
            self.button[4].cd:SetCooldown(GetSpellCooldown(spellID))
      elseif spellID == 31884 then -- 復仇之怒
            self.button[4]:HideGlow()
            self.button[4].cd:SetCooldown(GetSpellCooldown(spellID))
            return
      elseif spellID == 96229 then -- 神經突觸彈簧
            self.button[5]:HideGlow()
            self.button[5].cd:SetCooldown(GetInventoryItemCooldown('player', 10))
            return
      elseif spellID == 54861 then -- 硝基推進器
            self.button[6]:HideGlow()
            self.button[6].cd:SetCooldown(GetInventoryItemCooldown('player', 6))
            return
      elseif spellID == 126389 then -- 哥布林滑翔裝置
            self.button[7]:HideGlow()
            self.button[7].cd:SetCooldown(GetInventoryItemCooldown('player', 15))
            return
      elseif spellID == 146194 then -- 雪怒亂舞
            self.button[7]:HideGlow()
            return
      end
end

function CombatEvent:SPELL_CAST_SUCCESS(spellID)
      if spellID == 54735 then -- 電磁脈衝
            self.button[6].cd:SetCooldown(GetTime(), 60)
      end
end