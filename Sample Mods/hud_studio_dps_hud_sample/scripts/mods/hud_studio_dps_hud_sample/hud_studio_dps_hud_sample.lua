--- @class mod
local mod = get_mod("hud_studio_dps_hud_sample")

-- First, we call execute and return the library which will do our DPS calculations
-- You are free to use it in your own projects without attribution as you feel fit

--- @type DL_Dps
local DPS = mod:io_dofile("hud_studio_dps_hud_sample/scripts/mods/hud_studio_dps_hud_sample/dps")

-- Then, define functions for retrieving the local player (you) so we only count your damage

local FS_Managers, FS_Unit = _G.Managers, _G.Unit

local function ensure_managers()
	FS_Managers = FS_Managers or _G.Managers
	return FS_Managers
end

local function ensure_unit()
	FS_Unit = FS_Unit or _G.Unit
	return FS_Unit
end

local function player_manager()
	return ensure_managers() and FS_Managers.player or nil
end

-- The local (this client's) player object, or nil if not spawned in yet.
local function local_player_unit()
	if not ensure_unit() or not ensure_managers() then
		return nil
	end

	local pm = player_manager()

	local player = pm and pm:local_player_safe(1) or nil

	local unit = player and player.player_unit

	if unit and FS_Unit.alive(unit) then
		return unit
	end

	return nil
end

-- Initialise a new instance of the DPS tracker with some configuration values
local dps_tracker = DPS.new({
	dps_update_hz = 14,
	dps_window_seconds = 1,
	dps_display_decay_seconds = 1,
})

-- Local dps display state, written to in mod.update
local dps = 0

-- DMF advances mod.update every tick, so we also advance our DPS tracker's clock here
-- We also store the DPS value, rounded down to the nearest whole number.
mod.update = function(dt)
	dps_tracker:advance_clock(dt)
	dps_tracker:tick(dt)
	dps = math.floor(dps_tracker.display)
end

-- Hook into the attack result function so we can retrieve the damage dealt, filtering
-- for attack results matching the local player unit
mod:hook_safe(CLASS.AttackReportManager, "add_attack_result", function(self, _, _, attacking_unit, _, _, _, damage)
	-- Filter results by comparing the attacking_unit as reported by the game against
	-- our local player unit
	if attacking_unit == local_player_unit() then
		dps_tracker:record_damage(damage)
	end
end)

-- Define colors for our readout

local dps_color_high = { 255, 249, 51, 51 } -- red
local dps_color_medium = { 255, 250, 154, 47 } -- orange
local dps_color_low = { 255, 185, 235, 179 } -- mint-green

-- Define functions, stored on our 'mod' handle, which we will
-- retrieve in our HUD element.

mod.dps_display = function()
	return dps
end

mod.dps_color = function()
	if dps >= 1500 then
		return dps_color_high
	elseif dps >= 1000 then
		return dps_color_medium
	else
		return dps_color_low
	end
end

-- Lastly, our HUD registration for HUD Studio to pick up our DPS block and show it in a user's library

-- Registering after all mods have loaded ensures that load order does not matter.
mod.on_all_mods_loaded = function()
	-- grab the HUD Studio handle with get_mod
	local hud_studio = get_mod("hud_studio")

	-- throw an error if it is not found (it must be installed by the end user) and exit
	if not hud_studio then
		mod:error("Error at block registration: HUD Studio is not installed.")
		return
	end

	-- register our blocks here
	hud_studio.register_blocks(

		-- !!!! Remember to localize your mod name !!!!
		-- HUD Studio will attempt to localize "mod_name" to get a readable version
		-- It will fall back to the mod ID if not found, which can be ugly

		-- we are passing our mod (hud_studio_dps_hud_sample) as the first parameter.
		-- HUD Studio will use this to get your mod's name and stash your blocks
		mod,

		-- The second parameter is a table that expects your name (as the author) and the blocks array
		{
			author = "malevhf",
			blocks = {
				-- Add each block as an individual entry
				"scripts/mods/hud_studio_dps_hud_sample/DPS_Display", -- (required) note we are NOT writing file extensions here (.lua)
			},
		}
	)
end
