A block script is Lua that runs once per block tick, before anything else on the block. It works things out once and leaves them in `state` for the block's fields and nodes to read.

It has no output and does not change the block directly.

## When it runs

Every block tick, before the variables, the block's visibility and every node.

- Runs while the block is hidden by its own rules, lingering, or fading out because of its rules.
- Stops while the block's eye is off, its group's eye is off, a gamemode / class filter fails, or a required mod is missing. A fade-out caused by the eye or a filter does not run it.
- A block with a script ticks at the _Animation_ rate.

Because it keeps running while the block is hidden by its rules, a block script can count, time or remember things the block's visibility depends on.

## State

`state` is the block script's own table. It keeps its contents between ticks.

Everything else on the block reads the same table as `block.state`, which is how a block script passes on its results.

```lua
-- block script
setup({ hits = 0, last_hp = 0 })

local hp_now = my.status.health
-- count every tick health went down
if hp_now < state.last_hp then
  state.hits = state.hits + 1
end
state.last_hp = hp_now
state.low = my.status.health_percent < 30
```

```lua
-- a text node's Text field
local hit_count = block.state.hits
text = "Hits taken: " .. hit_count
```

`state` is emptied when the block recompiles: any code edit, a node added, removed or moved, the document loading.

## became_visible

`became_visible` is true on the first tick after the block started drawing again. In a block script it is **one tick late**: the script runs before the block's visibility is decided for the tick. The same goes for the block's Opacity, Visibility, variables and events. Scale and Position see it on time.

```lua
-- block script: reset the counter each time the block appears
if became_visible then
  state.hits = 0
end
```

## Block fields in Code mode

Visibility, Scale, Position and Opacity each take a `Code` mode. Each assigns its own name.

| Field      | Assign    | Type         | Notes                                            |
| ---------- | --------- | ------------ | ------------------------------------------------ |
| Visibility | `visible` | boolean      | nil or an error counts as visible                |
| Scale      | `scale`   | number       | clamped to 0.05 .. 20; nil uses the static value |
| Position   | `shift`   | `{ dx, dy }` | pixels added to the block's position this tick   |
| Opacity    | `opacity` | number       | 0 .. 1; nil uses the static value                |

Each of these has its **own private** `state`. Read the block script's table as `block.state`.

```lua
-- block Visibility, Code mode
local is_low = block.state.low
visible = is_low
```

```lua
-- block Position, Code mode: bob up and down while low
local bob_y = block.state.low and anim.osc(1, -4, 4) or 0
shift = { 0, bob_y }
```

`shift` never moves the block's saved position. It is added on top each tick, and drops back to 0 when the block stops drawing.

## Order on the block

1. Opacity
2. **Block script**
3. Variables
4. Visibility, then Events
5. Nodes, bottom to top as the Blocks tree lists them (back to front)
6. Scale, then Position

Opacity runs before the script, so it sees `block.state` from the last tick. Everything else sees this tick's.

## Block scripts and variables

| Use a block script for                      | Use a variable for                   |
| ------------------------------------------- | ------------------------------------ |
| several values worked out together          | one value, read by name              |
| counting, timing, remembering between ticks | a colour, text or number to restyle  |
| values only code reads                      | values a field binds to with no code |

A `Code` variable can read `block.state` too, so the two work together.

## Good to know

- Always use `local`. A global without one is seen by every script on the block. Recompiling does not clear it; it stays until the document reloads.
- Rebind Source only rewrites the block script with _Rewrite Block Script_ on.
- A block script that errors stops at the error for that tick. What it wrote to `state` before the error stays.
- `block` is read-only apart from `block.state`. A script cannot edit the block's layout.

See [For Modders & Coders](../scripting/index.md) for every global and the full rules.
