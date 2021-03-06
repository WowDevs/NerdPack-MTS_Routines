local mKey = 'MTSDdFrl'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Druid Feral Settings',
	color = NeP.Core.classColor('player'),
	width = 250,
	height = 500,
	config = {

	}
}

NeP.Interface.buildGUI(config)
local E = MTS.dynEval
local F = function(key) return NeP.Interface.fetchKey(mKey, key, 100) end

local exeOnLoad = function()
	MTS.Splash()
	MTS.ClassSetting(mKey)
end

local Survival = {

}

local Cooldowns = {

}

local AoE = {
	--Thrash to maintain the DoT.
	{'Trash', '!target.debuff(Trash)'},
	--Rake to maintain the DoT.
	{'Rake', '!target.debuff(Rake).duration < 5'},
	--Rip to maintain the DoT.
	{'Rip', 'target.buff(Rip).duration < 5'},
	--Swipe to build CP with 9+ targets.
	{'Swipe', 'player.area(8).enemies >= 9'}
}

--[[Finishing Moves]]
local FM = {
	--Ferocious Bite to refresh Rip when target at <= 25% health.
	{'Ferocious Bite', {
		'target.health <= 25',
		'target.buff(Rip).duration < 5'
	}},
	--Rip to maintain DoT with 5 CP when target at > 25% health.
	{'Rip', 'target.buff(Rip).duration < 5'},
	--Ferocious Bite with 5 CP to dump excess CP.
	{'Ferocious Bite'}
}

local ST = {
	{FM, 'player.combopoints >= 5'},
	--Rake to maintain the DoT at all times.
	{'Rake', '!target.debuff(Rake).duration < 5'},
	--Shred to build CP.
	{'Shred'}
}

local Keybinds = {
	-- Pause
	{'pause', 'modifier.alt'},
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(103, '[|cff'..MTS.Interface.addonColor..'MTS|r] Druid - Feral', 
	{-- In-Combat
		{Keybinds},
		{Survival, 'player.health < 100'},
		{Cooldowns, 'modifier.cooldowns'},
		{AoE, {'toggle.AoE', 'player.area(8).enemies >= 3'}},
		{ST, {'target.range < 8', 'target.infront'}}
	}, outCombat, exeOnLoad)