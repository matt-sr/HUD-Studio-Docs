Linger and Delay time a block's or node's visibility. They sit on the _Timing_ card in the Visibility section, beside Fade In and Fade Out.

| Setting | Does                                                          |
| ------- | ------------------------------------------------------------- |
| Delay   | stays hidden until the visibility has been true for this long |
| Linger  | stays shown for this long after the visibility turns false    |

Both are in seconds, up to 600. 0 is off.

## What they time

The quick conditions **and** the Visibility rule, combined. It works for every Visibility mode: Conditions, Code, Data Source and Variable.

They do **not** hold back:

- the eye. Off hides, forced on shows, straight away.
- gamemode and class filters.
- a group's eye.

## Delay

- Visibility turns true: a timer starts.
- It must stay true for the whole delay before the block or node shows.
- If it turns false during the delay, the timer resets, and no linger runs since nothing was shown.

Use it to skip short blips: a low-health warning that only shows if health stays low for half a second.

## Linger

- Visibility turns false: a timer starts.
- The block or node stays shown until it runs out.
- If it turns true again during the linger, it simply stays shown.

Use it to keep something up a while after its moment: a damage readout that stays 3 seconds after the last hit.

## With fades

Delay and Linger decide **when** something shows or hides. The fade runs after that.

- Delay, then Fade In.
- Linger, then Fade Out.

A 2 second linger with a 0.5 second fade out keeps the block fully shown for 2 seconds, then fades over 0.5.

## Scripts while held

| During       | Block script | Node scripts   |
| ------------ | ------------ | -------------- |
| Block delay  | runs         | stopped        |
| Block linger | runs         | run            |
| Node delay   | -            | only `visible` |
| Node linger  | -            | run            |

A node's `visible` script keeps running while the node is held, so the timers always see the latest answer.

## Opacity

An Opacity field in Thresholds mode with a Boolean reading uses the same Linger and Delay. They hold the **True** row: it shows after the delay and stays for the linger.

Number and Percent readings are never held.

## Other rule lists

A rule list nested anywhere else, such as a colour threshold's input, has its own _Linger for_ and _Delay for_ at the bottom of the Condition Builder. They work the same way, for that list only.

Events have their own Linger and Delay too. See [Events](../ui/events.md).

## In code

Linger and Delay work on whatever a Code mode Visibility assigns, so a script does not need its own timers.

To hold any other value, time it with `anim`:

```lua
-- a text node's Text field: show "Reloaded" for 2 seconds after a reload ends
local is_reloading = my.equipment.is_reloading
if anim.changed(state, "reload", is_reloading) and not is_reloading then
  state.finished_at = t
end

local finished_at = state.finished_at
local recently_finished = finished_at ~= nil and t - finished_at < 2
text = recently_finished and "Reloaded" or ""
```

```lua
-- a rect's Colour field: only turn red once health has been low for 1 second
local is_low = my.status.health_percent < 30
local seconds_low = anim.since(state, "low", is_low)
local held_low = is_low and seconds_low >= 1
color = held_low and { 255, 220, 40, 40 } or { 255, 255, 255, 255 }
```

## Good to know

- A block with no Visibility rule and no quick conditions has nothing to time. Delay and Linger do nothing.
- The timers restart when the block recompiles.
- Timing copies with the card's right-click menu, and pastes between blocks and nodes.
