A Position field in `Code` mode moves a block or node for one update without touching its saved position. It assigns `shift`, a pixel offset added on top.

Blocks and nodes both have it. Pair it with `anim` for smooth motion.

## How it works

Every block and node has a saved position, the one a drag or the Position numbers set. `shift` is added to it each time the field runs.

- Never saved. Dragging still edits the saved position, and the shift rides on top.
- Leave it nil, or let the script error, and it reads as `{ 0, 0 }`.
- When the block stops drawing, every shift on it drops back to 0. It comes back from rest.

| Field          | Assign  | Type             | Moves by                                                 |
| -------------- | ------- | ---------------- | -------------------------------------------------------- |
| Block Position | `shift` | `{ dx, dy }`     | design pixels, times the HUD scale slider                |
| Node Position  | `shift` | `{ dx, dy, dz }` | design pixels, times the HUD scale and the block's Scale |

Design pixels are the HUD's own units: 1920 x 1080 on a 16:9 screen, scaled up or down to your resolution. `y = 10` is ten pixels down at 1080p, about 13 at 1440p. `+x` is right, `+y` is down.

## Where a block ends up

```
block on screen = screen centre + (position + shift + follow + scale anchor) × HUD scale
node on screen  = block on screen + (node position + node shift) × HUD scale × Scale
```

- A **block** shift does not grow with the block's Scale. A 20px slide stays 20px at Scale 0.5.
- A **node** shift does: it lives inside the block, so at Scale 2 a 10px node shift moves 20px.

## When it runs

| Field          | Runs                                                                                                       |
| -------------- | ---------------------------------------------------------------------------------------------------------- |
| Block Position | every block tick, at the _Animation_ rate (or _Data_ if _Max Update Rate_ holds it there), after the nodes |
| Node Position  | at the node's [Update Rate](../concepts/rates.md)                                                                                |

Between runs the last shift holds. `anim` reads the time since the last run on its own, so motion keeps the same speed at any rate. For the smoothest node motion, run it every frame:

```lua
setup(nil, { update_rate = "frame" })
```

`became_visible` is on time in a block's Position field: it runs after the block's visibility is decided.

## Follow Camera and Follow Motion

A block's _Follow_ settings add a second offset on top of `shift`. Both run **every frame**, whatever the block's rate.

| Setting                    | Moves the block                                            | Tuned by                         |
| -------------------------- | ---------------------------------------------------------- | -------------------------------- |
| Follow Camera              | lags behind look turns, then settles back                  | Camera Strength, Camera Delay    |
| Follow Motion: Camera Sway | rides the first-person bob: walk, sprint, jump, landing    | the player's Camera Sway setting |
| Follow Motion: Crosshair   | exactly as the vanilla crosshair, recoil and sway included | Intensity                        |

- Follow Camera and Follow Motion stack. Camera Sway and Crosshair are one choice.
- They add to your `shift`, so a slide-in still plays while the block sways.
- Your script does not see them. `shift` is your part only.
- They are placement settings the user can change on any block, mod blocks included, so a design should still work with them on.
- They only step while the block draws, and reset when it hides.

## Smooth motion with anim

Keep the moving value in `state`, and ease it toward a target each run.

```lua
-- block Position: slide 40px down while downed, back up when not
local target_y = my.state.downed and 40 or 0

-- speed 10: higher is faster
state.y = anim.approach(state.y, target_y, 10)
shift = { 0, state.y }
```

`approach` starts in place on the first run (`state.y` is nil), so nothing jumps when the block appears.

For both axes, `approach_xy` writes into your own table, so no new table is made each run:

```lua
-- node Position: drift toward a corner while health is low
setup({
  rest = { 0, 0 },
  away = { 30, -20 },
  pos = { 0, 0 },
})

local is_low = my.status.health_percent < 30
local target = is_low and state.away or state.rest

-- shift is state.pos itself: eased in place
shift = anim.approach_xy(state.pos, target, 6)
```

## Examples

### Slide in each time it appears

```lua
-- block Position: come in from 60px left over 0.4s, slow at the end
local seconds = anim.play(state, "intro", became_visible)
local progress = anim.window(seconds, 0, 0.4, "out_quad")

shift = { -60 * (1 - progress), 0 }
```

`window` is 0 before the clock starts and 1 after the slice, so the block rests in place once it has arrived.

### Overshoot and settle

```lua
-- node Position: drop 12px into place with a little bounce
local seconds = anim.play(state, "drop", became_visible)
local progress = anim.window(seconds, 0, 0.5, "out_back")

shift = { 0, -12 * (1 - progress) }
```

`out_back` passes 1 before settling, so the node dips just below its spot, then comes back.

### Shake on damage

```lua
-- block Position: shake for 0.3s whenever health drops
setup({ offset = { 0, 0 } })

local took_damage = anim.decreased(state, "hp", my.status.health)
-- -1 until the first hit
local seconds = anim.play(state, "hit", took_damage)
-- 6px on the hit, down to 0 at 0.3s
local strength = seconds >= 0 and 6 * (1 - anim.window(seconds, 0, 0.3)) or 0

if strength > 0 then
  shift = anim.shake(strength, state.offset)
end
```

- `decreased` only fires on a drop, and never on the first update, so nothing shakes as the block appears.
- At strength 0, `shake` leaves `out` as it was. Leaving `shift` nil instead puts the block back in place.

### Idle bob

```lua
-- node Position: bob 3px, one cycle every 2 seconds
shift = { 0, anim.osc(2, -3, 3) }
```

Give each node a different `phase` (0..1) for a wave across a row: `anim.osc(2, -3, 3, 0.25)`.

### Pop to the front

A node's third component, `dz`, moves it up or down the draw order for the update. `+2` is one node up; a big number is "on top". It never leaves this canvas.

```lua
-- node Position: lift 4px and draw over its neighbours while downed
local is_down = my.state.downed
shift = { 0, is_down and -4 or 0, is_down and 100 or 0 }
```

## Good to know

- Animate with `shift`: a script cannot change the saved position.
- Read the block's shift this update with `block.get_value("shift")`, which returns `dx, dy`. Nodes run before the block's Position, so a node sees the last tick's.
- Small moves between whole pixels snap to the nearest pixel. A very slow drift steps a pixel at a time.
- See [anim](anim.md) for every easing and timing helper, and [Animate Scale](animate_scale.md) for Scale.
