A block's Scale grows or shrinks everything inside it: node positions, sizes, text and bars, all by one factor. In `Code` mode it assigns `scale`, which `anim` can animate.

Scale is a block field. To resize one node, animate its Size instead.

## How it works

| Field | Assign  | Type   | Notes                                   |
| ----- | ------- | ------ | --------------------------------------- |
| Scale | `scale` | number | 1 is normal size; clamped to 0.05 .. 20 |

- Leave it nil, or let the script error, and the block uses its _Factor_.
- Never saved. The Factor stays what you set in the form.
- It multiplies the player's HUD scale slider.

```
node on screen = block on screen + (node position + node shift) × HUD scale × Scale
```

Scale works on what is **inside** the block. The block itself does not move: the content grows from the _Anchor_.

## The Anchor

The Anchor is the one point that holds still while the block scales.

| Anchor                  | Grows from                           |
| ----------------------- | ------------------------------------ |
| Origin                  | the block's own origin (the default) |
| Center                  | the middle of the block's content    |
| Top-left … Bottom-right | that edge or corner of the content   |

The content is the box around every node at their saved positions and sizes. Node shifts do not move it, so the Anchor stays put while nodes animate.

Use **Center** for pulses and pops. Origin is wherever the block's origin was left: a block whose nodes sit far from it slides away as it grows.

## When it runs

Every block tick, at the _Animation_ rate (or the _Data_ rate if _Max Update Rate_ holds the block there), after the nodes and before Position. Between ticks the last scale holds. `anim` reads the time since the last tick, so motion keeps the same speed.

`became_visible` is on time in Scale: it runs after the block's visibility is decided.

## Scale and Position together

| Moves                         | Grows with Scale? |
| ----------------------------- | ----------------- |
| block `shift`                 | no                |
| node `shift`                  | yes               |
| Follow Camera / Follow Motion | no                |

A block that slides 20px and scales to 2 still slides 20px. A node inside it that shifts 10px moves 20px.

To keep a node's move the same size at any scale, divide by the block's scale:

```lua
-- node Position: always 10px on screen, whatever the Scale
local block_scale = block.get_value("scale")
shift = { 10 / block_scale, 0 }
```

Nodes run before Scale, so `block.get_value("scale")` is the last tick's scale.

## Smooth scale with anim

Ease toward a target, keeping the value in `state`.

```lua
-- Scale: grow to 1.2 while downed, back to 1 when not
local target = my.state.downed and 1.2 or 1

state.scale = anim.approach(state.scale, target, 8)
scale = state.scale
```

`approach` starts in place on the first tick, so the block does not jump when it appears.

## Examples

### Pop in

```lua
-- Scale: grow from 0.6 to full size over 0.35s, overshooting a little
local seconds = anim.play(state, "intro", became_visible)
local progress = anim.window(seconds, 0, 0.35, "out_back")

scale = 0.6 + 0.4 * progress
```

Set the Anchor to Center, and pair it with a fade-in.

### Punch on a change

```lua
-- Scale: bump to 1.15 when health changes, settle back over 0.25s
local health_changed = anim.changed(state, "hp", my.status.health)
-- -1 until the first change
local seconds = anim.play(state, "punch", health_changed)
local punch = seconds >= 0 and 1 - anim.window(seconds, 0, 0.25, "out_quad") or 0

scale = 1 + 0.15 * punch
```

Not `anim.since`: it reads 0 on its first update too, so the block would punch as it appears.

### Heartbeat while low

```lua
-- Scale: beat once a second below 30% health, still otherwise
local is_low = my.status.health_percent < 30
local beat = is_low and anim.osc(1, 1, 1.08) or 1

-- ease into and out of the beat instead of snapping
state.scale = anim.approach(state.scale, beat, 12)
scale = state.scale
```

### Shrink with a value

```lua
-- Scale: shrink from 1 to 0.7 as the team goes down
local downed_count = count_players("state.downed")
scale = anim.remap(downed_count, 0, 3, 1, 0.7, true)
```

### A step sequence

```lua
setup({
  -- shape: { step_name, step_duration, ... }
  steps = { "grow", 0.15, "hold", 1, "shrink", 0.3 },
})

-- play once each time the player goes down
local seconds = anim.play(state, "alert", my.state.downed, state.steps)
local step, progress = anim.steps(seconds, state.steps)

if step == "grow" then
  scale = 1 + 0.3 * anim.ease(progress, "out_quad")
elseif step == "hold" then
  scale = 1.3
elseif step == "shrink" then
  scale = 1.3 - 0.3 * anim.ease(progress, "in_out")
else
  scale = 1
end
```

## Good to know

- Text and sizes grow with it too, and every edge snaps to whole pixels.
- Very small changes (1 to 1.01) step a pixel at a time on small blocks. Prefer a bigger, shorter move.
- A Scale that ends up a long way from 1 is better as a new Factor: set it in the form, and animate around it.
- See [anim](anim.md) for every easing and timing helper, and [Animate Position](animate_position.md) for `shift` and Follow.
