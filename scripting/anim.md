`anim` is a global in every block and node script. It holds the maths for motion and reactions: easing toward a target, timing since a value changed, repeating ticks, oscillation, and timed sequences.

Every signature is listed on the [anim Reference](anim_reference.md) page.

## Time

None of the functions take `dt`. They read the time since the calling block or node last updated, set before its script runs. Outside an update this is 0: `approach` holds its value and `since` stands still.

`t` and `dt` are still globals for scripts that do their own timing.

## State and keys

Functions that remember something between updates take the script's `state` table and a key. The key names the record inside `state`, so two calls in one script need different keys.

Records are stored under `__anim_<key>`, so they never clash with your own fields in `state`.

## Easing toward a target

`approach(current, target, speed)` moves `current` toward `target` and returns the new value. It is framerate independent. `speed` defaults to 8; higher is faster, 0 or less snaps.

- `current` nil: returns `target`, so the first update starts in place.
- `target` nil: returns `current`.

```lua
-- Position field: slide down 40px while downed
local target_y = my.state.downed and 40 or 0

-- speed 10: higher is faster
state.y = anim.approach(state.y, target_y, 10)
shift = { 0, state.y }
```

`approach_array` does the same for every component of an array, writing into `current` and returning it. `approach_xy` (`{ x, y }`) and `approach_rgba` (`{ a, r, g, b }`) are the same function. Missing components in `current` take the target value.

```lua
-- Colour field: ease from green to red below 30% health
setup({
  safe_color = { 255, 80, 255, 80 },
  danger_color = { 255, 255, 60, 60 },
  current_color = { 255, 80, 255, 80 },
})

local is_low = my.status.health_percent < 30
local target_color = is_low and state.danger_color or state.safe_color

-- writes into state.current_color, so no new table is made each update
color = anim.approach_array(state.current_color, target_color, 6)
```

## Reacting to changes

| Function                       | Returns                                                                             |
| ------------------------------ | ----------------------------------------------------------------------------------- |
| `since(state, key, value)`     | seconds since `value` last changed; 0 on the first update and the update it changes |
| `changed(state, key, value)`   | true on the update `value` changes                                                  |
| `increased(state, key, value)` | true on the update a number goes up                                                 |
| `decreased(state, key, value)` | true on the update a number goes down                                               |

The first update a key sees only records the value. It does not count as a change.

Values compare with `~=`. Tables compare by identity, so pass the field, not the table holding it.

All four share one record per key, and each moves it forward. Two of them on one key in one update can hide the change from the second (`since` then `changed` on one key: `changed` never fires). Give each its own key.

```lua
-- Colour field: flash pink for 0.4s whenever health changes
local health_changed = anim.changed(state, "hp", my.status.health)
-- -1 until the first change
local seconds = anim.play(state, "flash", health_changed)

-- 1 on the update health changes, down to 0 after 0.4s
local flash = seconds >= 0 and 1 - anim.window(seconds, 0, 0.4) or 0
local green = 255 - 255 * flash
color = { 255, 255, green, 255 }
```

`since` reads 0 on its first update as well, so a flash timed off it fires once as the node appears. `changed` does not.

## Repeating ticks

`every(state, key, period)` is true on one update per `period` seconds.

- Never true on the first update.
- After a hitch or a hidden spell it fires once, not once per missed tick.

```lua
-- Opacity field: blink every half second
setup({ blink_on = true })

if anim.every(state, "blink", 0.5) then
  state.blink_on = not state.blink_on
end

opacity = state.blink_on and 1 or 0.25
```

## Curves and ranges

`ease(k, name)` shapes a 0..1 progress. `k` is clamped to 0..1; the result is not.

| Name       | Curve                                            |
| ---------- | ------------------------------------------------ |
| `linear`   | default, also used for unknown names             |
| `in_quad`  | slow start                                       |
| `out_quad` | slow end                                         |
| `in_out`   | slow start and end, same as block and node fades |
| `out_back` | overshoots past 1, then settles                  |

`remap(v, in_lo, in_hi, out_lo, out_hi, clamp)` maps `v` from one range onto another. With `clamp` the result stays inside `out_lo..out_hi`. A zero-width input range returns `out_lo`.

`mix(a, b, k, out)` blends two arrays component by component. `k` is clamped to 0..1. Pass `out` to write into an existing table instead of creating one each update.

```lua
-- Colour field: blend from green to red as health drops
setup({
  full_color = { 255, 80, 255, 80 },
  empty_color = { 255, 255, 60, 60 },
  current_color = {},
})

-- 0 at full health, 1 at none
local hurt = anim.remap(my.status.health_percent, 100, 0, 0, 1, true)

-- writes into state.current_color, so no new table is made each update
color = anim.mix(state.full_color, state.empty_color, hurt, state.current_color)
```

## Idle motion

`osc(period, lo, hi, phase)` is a sine wave with one cycle per `period` seconds, between `lo` and `hi` (default 0..1). `phase` (0..1) shifts it.

```lua
-- Position field: bob 3px up and down, once every 2 seconds
local bob_y = anim.osc(2, -3, 3)
shift = { 0, bob_y }
```

`shake(amp, out)` returns a smooth pixel offset `dx, dy` up to `amp`. With `out` it writes `{ dx, dy }` into it and returns it.

## Sequences

A sequence is a function of elapsed time. `play` gives the clock; `steps` and `window` read it.

`play(state, key, trigger, sequence_length)` returns seconds since `trigger` last turned truthy, or -1 if it never has.

- Turning on again restarts the clock.
- Turning off does not stop it.
- A trigger already on at the first update starts the clock, so `anim.play(state, "intro", true)` plays once when the block appears.
- With `sequence_length` (seconds, or a step list), re-triggers before that much time has run are ignored.

`stop(state, key)` resets a `play` clock to -1 until its trigger next turns on from off.

`steps(seconds_elapsed, step_list, loop)` returns the current step name and its 0..1 progress. A step list is flat name/seconds pairs. Keep it in a constant so nothing is created per update.

- Before the start: `nil, 0`.
- After the end: the last step, 1. With `loop` it wraps.
- Zero-second steps are skipped.

`window(seconds_elapsed, start, duration, ease_name)` returns eased 0..1 progress through one slice of time: 0 before it, 1 after it. Use it for staggered or overlapping parts.

```lua
setup({
  -- the steps for this animation sequence
  -- shape: { step_name, step_duration, step_2_name, step_2_duration, ... }
  steps = { "fade_in", 0.3, "hold", 2, "fade_out", 0.5 }
})

-- returns the time_elapsed in the current sequence
-- signature: anim.play(state, name_key, trigger_condition, steps)
local time_elapsed = anim.play(state, "warning", sources.player_1.state.downed, state.steps)

-- if you do not pass steps to anim.play,
-- it will re-fire the sequence if `trigger_condition` becomes true again
-- before the sequence has finished

-- compute which step we're in using anim.steps
-- signature: anim.steps(time_elapsed, steps)
-- returns which step we are currently in, and 0..1 progress through the step
local step, progress = anim.steps(time_elapsed, state.steps)

if step == "fade_in" then
  opacity = anim.ease(progress)
elseif step == "hold" then
  opacity = 1
elseif step == "fade_out" then
  opacity = 1 - progress
else
  opacity = 0 -- hasn't played yet (once finished, steps stays on "fade_out" at 1)
end
```
