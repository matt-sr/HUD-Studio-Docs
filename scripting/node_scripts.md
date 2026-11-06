A node script is a field set to `Code` mode. It runs every time the node updates and assigns that field's value.

## Writing to the field

The field's name is already a local. Assign it. There is no `return`.

| Field (row)       | Assign           | Type                                       |
| ----------------- | ---------------- | ------------------------------------------ |
| Visibility        | `visible`        | boolean; nil counts as visible             |
| Position          | `shift`          | `{ dx, dy }`, added to the node's position |
| Opacity           | `opacity`        | 0 .. 1                                     |
| Colour            | `color`          | `{ a, r, g, b }`, 0 .. 255                 |
| Size              | `size`           | `{ width, height }`                        |
| Text              | `text`           | string                                     |
| Bar current / max | `current`, `max` | number                                     |

Other fields follow the same rule, in lower case with underscores: `bg_color`, `font_size`, `rotation`.

Leave it nil and the field uses its static value.

```lua
-- a rect's Colour field: red below 30% health
local health = my.status.health_percent
local is_low = health < 30
color = is_low and { 255, 220, 40, 40 } or { 255, 255, 255, 255 }
```

```lua
-- a text node's Text field
local ammo_left = my.equipment.ammo_mag_remaining
local ammo_max = my.equipment.ammo_mag_max
text = ammo_left .. " / " .. ammo_max
```

## Style script

The Style section's script button opens a script that fills a `style` table. Each key it sets overrides that style field for this update.

It runs after every other field on the node, so it can read them: `values` holds this update's value for each field, such as `values.text`. (`value` is `values.value`. None of the built-in node types has a field with that name, so read `values` instead.)

```lua
-- style script: flash red for 0.4s after the text changes
local text_changed = anim.changed(state, "text", values.text)
-- -1 until the first change
local seconds = anim.play(state, "flash", text_changed)
local flash = seconds >= 0 and 1 - anim.window(seconds, 0, 0.4) or 0
style.color = { 255, 255, 255 - 200 * flash, 255 - 200 * flash }
```

A key the style script sets wins over that field's own binding.

## Order on the node

1. `visible`
2. every other field, in name order
3. the style script

Nodes run back to front, which is bottom to top in the Blocks tree. They run after the block script and the variables.

A node hidden by its Visibility rule runs **only** its `visible` script, so it can tell when to come back. The others start again once it shows, and keep running while it fades out. A node hidden by its eye, a filter or a quick condition runs none of its scripts.

## State

Each node has one `state` table, shared by all its scripts. It keeps its contents between updates and is emptied when the block recompiles.

```lua
-- Opacity field: fade out once health has not changed for 3 seconds
local seconds_still = anim.since(state, "hp", my.status.health)
opacity = 1 - anim.remap(seconds_still, 3, 4, 0, 1, true)
```

Two fields on one node share `state`, so give your keys distinct names. `anim` keys are stored apart from your own fields.

## Reading the block

`block.state` is the block script's table. Use it for anything several nodes need.

```lua
-- block script
local downed_count = count_players("state.downed")
state.team_in_trouble = downed_count >= 2
```

```lua
-- any node's Visibility field
local team_in_trouble = block.state.team_in_trouble
visible = team_in_trouble
```

The block script runs first, so a node always sees this tick's `block.state`, unless the node runs between block ticks (see [Update rate](#update-rate)).

## Reading other nodes

```lua
-- this node's Text field reads another node's text
local title_node = block.get_node_by_id("title")
local title_text = title_node and title_node.get_value("text") or ""
text = title_text .. " (copy)"
```

- A node **above** this one in the Blocks tree has not run yet: you get its value from the last update.
- A node **below** this one has: you get this update's.
- Your own node's fields are filled in name order, so a field later in the alphabet reads from the last update.

## became_visible

| Script            | `became_visible` is true when             |
| ----------------- | ----------------------------------------- |
| `visible`         | it did not run on the node's last update  |
| every other field | the node was not drawn on its last update |

It is also true on the first run after the block recompiles.

```lua
-- Text field: count up from 0 each time the node appears
setup({ shown_for = 0 })
if became_visible then
  state.shown_for = 0
end
state.shown_for = state.shown_for + dt
text = string.format("%.1f", state.shown_for)
```

`setup(defaults, { reset_on_show = true })` does the same for the whole `state`. Pass a list of keys to reset only those: `{ reset_on_show = { "shown_for" } }`.

## Update rate

A node's [Update Rate](../concepts/rates.md) sets how often its scripts run.

| Rate        | Runs                                  |
| ----------- | ------------------------------------- |
| `Automatic` | `Animation` with code, `Data` without |
| `Data`      | at the data rate (slow)               |
| `Animation` | at the animation rate                 |
| `Frame`     | every frame                           |

`dt` is the time since **this node** last ran. `anim` uses it on its own, so its functions look the same at any rate.

A script can pick what Automatic means for its node:

```lua
setup(nil, { update_rate = "frame" })
```

A `Frame` node runs between block ticks. `block.state` it reads may be one block tick old.

## Good to know

- Always use `local`. A global without one is seen by every script on the block until the document reloads.
- Don't build a new table every update when you can reuse one in `state`.
- A field that errors uses its static value; the Code Editor shows the error.
- See [For Modders & Coders](../scripting/index.md) for every global and rule.
