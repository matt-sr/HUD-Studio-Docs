-- Rolling-window DPS tracker
local mod = get_mod("hud_studio_dps_hud_sample")

if mod.dps then
	return mod.dps
end

local math_min = math.min

local DPS_DISPLAY_RISE = 18.0
local MAX_DPS_SAMPLES = 128

-- Ring index for the sample `offset` slots after `head` (0 = head itself),
-- wrapping around the MAX_DPS_SAMPLES-slot buffer.
---@param head integer
---@param offset integer
---@return integer
local function ring_index(head, offset)
	return (head - 1 + offset) % MAX_DPS_SAMPLES + 1
end

-- Tuning read live of fthe tracker's config each tick. All fields optional;
-- missing/invalid values fall back to sane defaults inside the tracker.
---@class DL_DpsConfig
---@field dps_window_seconds? number Trailing window length in seconds (default 1).
---@field dps_update_hz? number Target recompute rate in Hz; <= 0 recomputes every tick.
---@field dps_display_decay_seconds? number How fast the displayed value falls (default 2).

---@class DL_Dps
---@field config DL_DpsConfig
---@field clock number Monotonic tracker clock; sample timestamps are relative to it.
---@field sample_time number[] Ring buffer of sample timestamps.
---@field sample_damage number[] Ring buffer of sample damage, parallel to sample_time.
---@field sample_head integer Ring index of the oldest live sample.
---@field sample_count integer Number of live samples in the ring.
---@field target number Instantaneous DPS over the window (recompute output).
---@field display number Eased value shown on the statline.
---@field recompute_timer number Seconds until the next target recompute.
local DPS = {}
DPS.__index = DPS

---@param config DL_DpsConfig
---@return DL_Dps
function DPS.new(config)
	local self = setmetatable({}, DPS)

	self.config = config or {}
	self.sample_time = {} -- ring buffer of sample timestamps
	self.sample_damage = {} -- ring buffer of sample damage, parallel to sample_time
	self:reset()

	return self
end

-- Trailing window length in seconds; clamped to a positive value.
---@return number
function DPS:window()
	local window_seconds = self.config.dps_window_seconds

	if not window_seconds or window_seconds <= 0 then
		return 1
	end

	return window_seconds
end

-- Seconds between target recomputes; 0 means recompute every tick.
---@return number
function DPS:recompute_interval()
	local update_hz = self.config.dps_update_hz

	if not update_hz or update_hz <= 0 then
		return 0
	end

	return 1 / update_hz
end

-- Per-second rate at which the displayed value eases downward toward target.
---@return number
function DPS:display_fall_rate()
	local decay_seconds = self.config.dps_display_decay_seconds

	if not decay_seconds or decay_seconds <= 0 then
		decay_seconds = 2
	end

	return 3 / decay_seconds
end

-- Advances sample_head past samples that have aged out of the rolling window,
-- shrinking the live count. O(dropped) and allocation-free.
function DPS:prune_samples()
	local cutoff = self.clock - self:window()
	local times = self.sample_time
	local head = self.sample_head
	local count = self.sample_count

	while count > 0 and times[head] < cutoff do
		head = head % MAX_DPS_SAMPLES + 1
		count = count - 1
	end

	self.sample_head = head
	self.sample_count = count
end

-- Sum of damage across all live samples in the ring, divided by the window.
---@return number
function DPS:compute_target()
	local window = self:window()
	local damages = self.sample_damage
	local head = self.sample_head
	local count = self.sample_count

	if count == 0 then
		return 0
	end

	local total_damage = 0

	for offset = 0, count - 1 do
		total_damage = total_damage + damages[ring_index(head, offset)]
	end

	return total_damage / window
end

function DPS:refresh_target()
	self.target = self:compute_target()
end

-- Clears live samples and display state. Retains the ring-buffer arrays so no
-- allocation happens; only the head/count/clock/display cursors reset.
function DPS:reset()
	self.clock = 0
	self.sample_head = 1
	self.sample_count = 0
	self.target = 0
	self.display = 0
	self.recompute_timer = 0
end

-- Records a damage event at the current clock time. No-op for nil/<=0 damage.
---@param damage? number
function DPS:record_damage(damage)
	if not damage or damage <= 0 then
		return
	end

	self:prune_samples()

	local head = self.sample_head
	local count = self.sample_count

	-- Buffer full: drop the oldest sample to make room for this one.
	if count >= MAX_DPS_SAMPLES then
		head = head % MAX_DPS_SAMPLES + 1
		count = count - 1
		self.sample_head = head
	end

	local tail = ring_index(head, count)
	self.sample_time[tail] = self.clock
	self.sample_damage[tail] = damage
	self.sample_count = count + 1

	self:refresh_target()
end

-- Per-frame update: prunes aged samples, recomputes the target on its cadence,
-- then eases the displayed value toward it.
---@param dt number
function DPS:tick(dt)
	self:prune_samples()

	local interval = self:recompute_interval()

	if interval <= 0 then
		self:refresh_target()
	else
		self.recompute_timer = self.recompute_timer - dt

		if self.recompute_timer <= 0 then
			self:refresh_target()
			self.recompute_timer = interval
		end
	end

	-- Ease the displayed value toward the target: rise quickly on new damage,
	-- fall more gently (rate tunable via dps_display_decay_seconds) once it stops.
	local display = self.display
	local target = self.target
	local rate = target > display and DPS_DISPLAY_RISE or self:display_fall_rate()
	local step = math_min(1, dt * rate)

	self.display = display + (target - display) * step

	if target <= 0 and self.display < 0.5 then
		self.display = 0
	end
end

-- Advances the tracker clock. Call once per frame before recording damage so
-- sample timestamps line up with the window.
---@param dt number
function DPS:advance_clock(dt)
	self.clock = self.clock + dt
end

-- Current displayed DPS (eased), for the statline.
---@return number
function DPS:value()
	return self.display
end

mod.dps = DPS

return DPS
