-- Wonder_x_10.lua
-- Author: tontyoutoure
-- DateCreated: 6/3/2017 1:30:34 AM
--------------------------------------------------------------

-- Globles
-- How many techs/civics are you going to be given after Oxford/Bolshoi complete

local GiveCount=18

-- How many promotion units are given after TCW are built
local PromotionCount = 2

local PromotionRange = 12

-- How many GP stonehenge gives
local GreatProphetCount = 0

-- How many tech boost great lib give after other people get GS
local GreatLibraryTechBoostCount = 2

local BuildingList = {}
local BuildingIndices = {}
local UnitPromotionClassList = {}
local PromotionClassList = {}
local GreatProphetUnitIndex
local GreatPersonClassList = {}


-- Initializing


for BuildingInfo in GameInfo.Buildings() do
	BuildingList[BuildingInfo.Index] = BuildingInfo.BuildingType
	BuildingIndices[BuildingInfo.BuildingType] = BuildingInfo.Index
end

for UnitInfo in GameInfo.Units() do
	if UnitInfo.UnitType == 'UNIT_GREAT_PROPHET' then
		GreatProphetUnitIndex = UnitInfo.Index
	end
	if UnitInfo.PromotionClassReference then
		UnitPromotionClassList[UnitInfo.Index] = UnitInfo.PromotionClassReference.Index
	end
end

for PromotionInfo in GameInfo.UnitPromotionClasses() do
	PromotionClassList[PromotionInfo.Index] = {}
	if #PromotionInfo.PromotionCollection > 0 then 
		for i = 1, #PromotionInfo.PromotionCollection do
			PromotionClassList[PromotionInfo.Index][#PromotionClassList[PromotionInfo.Index]+1] = PromotionInfo.PromotionCollection[i].Index
		end
	end
end

for GreatPersonClassInfo in GameInfo.GreatPersonClasses() do 
	GreatPersonClassList[GreatPersonClassInfo.Index] = GreatPersonClassInfo.UnitType
end


math.randomseed(os.time())


-- Stonehenge give prophets

function StonehengeComplete(WonderX, WonderY, BuildingIndex, PlayerIndex)
	if BuildingList[BuildingIndex] == 'BUILDING_STONEHENGE' then
		local PlayerUnitInfo = Players[PlayerIndex]:GetUnits()
		local CapitalInfo = Players[PlayerIndex]:GetCities():GetCapitalCity()
		for i = 1, GreatProphetCount do
			PlayerUnitInfo:Create(GreatProphetUnitIndex, CapitalInfo:GetX(), CapitalInfo:GetY())
		end
	end
end

Events.WonderCompleted.Add(StonehengeComplete)

function GreatLibraryExtraTechBoost(iPlayer, iCity, iGreatPersonClass, iGreatPersonIndividual)
	if GreatPersonClassList[iGreatPersonClass] ~= "UNIT_GREAT_SCIENTIST" then return end
	for k, v in ipairs(Players) do
		if v:IsMajor() and iPlayer ~= k then
			for iCity, hCity in v:GetCities():Members() do
				if hCity:GetBuildings():HasBuilding(BuildingIndices.BUILDING_GREAT_LIBRARY) then		
					local tAvailableTechs = {}
					local hPlayerTechInfo = v:GetTechs()
					for tTechInfo in GameInfo.Technologies() do
						if not hPlayerTechInfo:HasTech(tTechInfo.Index) and not hPlayerTechInfo:HasBoostBeenTriggered(tTechInfo.Index) then
							table.insert(tAvailableTechs, tTechInfo.Index)
						end
					end
					local iTechsBoosted = 0
					while iTechsBoosted < GreatLibraryTechBoostCount and #tAvailableTechs > 0 do
						local iTechToBoost = math.random(1, #tAvailableTechs)
						hPlayerTechInfo:TriggerBoost(tAvailableTechs[iTechToBoost])
						table.remove(tAvailableTechs, iTechToBoost)		
						iTechsBoosted = iTechsBoosted+1
					end				
				end
			end
		end
	end
end

Events.UnitGreatPersonCreated.Add(GreatLibraryExtraTechBoost)


-- Terracotta Army give all units all promotion and fully heal all units

function TerracottaComplete(WonderX, WonderY, BuildingIndex, PlayerIndex)
	if BuildingList[BuildingIndex] == 'BUILDING_TERRACOTTA_ARMY' then
		local PlayerUnitInfo = Players[PlayerIndex]:GetUnits()
		local UnitCount = PlayerUnitInfo:GetCount()
		local UnitNum = 0
		while true do
			local UnitInfo = PlayerUnitInfo:FindID(UnitNum)
			if UnitInfo then
				local UnitPromotionClass = UnitPromotionClassList[UnitInfo:GetType()]
				if UnitPromotionClass and UnitPromotionClass <= PromotionRange then
					UnitInfo:SetDamage(0)
					local nPromotion = 0
					for i = 1, #PromotionClassList[UnitPromotionClass] do
						if not UnitInfo:GetExperience():HasPromotion(PromotionClassList[UnitPromotionClass][i]) then
							UnitInfo:GetExperience():SetPromotion(PromotionClassList[UnitPromotionClass][i])
						end
						nPromotion = nPromotion+1
						if nPromotion == PromotionCount then
							break
						end
					end
				end				
			elseif UnitNum == 0 then 				
			else
				break
			end
			UnitNum = UnitNum+1
		end
	end
end

Events.WonderCompleted.Add(TerracottaComplete)

print("wonder x 3 loading complete")	