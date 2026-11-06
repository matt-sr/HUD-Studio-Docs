The HUD draws every frame. A rate decides how often a node works out its fields again. Between updates it keeps drawing its last result.

A slower rate costs less. Most of a HUD only needs to change a few times a second.

## The three rates

| Rate          | Default | Use it for                                    |
| ------------- | ------- | --------------------------------------------- |
| _Data_        | 30 Hz   | game values: health, ammo, names, timers      |
| _Animation_   | 60 Hz   | motion, smooth fades, anything driven by code |
| _Every frame_ | -       | mod APIs that need a call every frame         |

The Hz behind _Data_ and _Animation_ come from the mod's settings, under _Performance_:

| Setting              | Options                     |
| -------------------- | --------------------------- |
| `HUD Animation Rate` | Every Frame, 30, 45, 60, 75 |
| `HUD Data Rate`      | Every Frame, 15, 20, 30, 60 |

- The data rate is never faster than the animation rate. Set it higher and it runs at the animation rate.
- At 60 fps, 30 Hz looks steadier than 45 Hz. 45 is for 90 fps and above.
- _Every frame_ ignores both settings.

A block from a mod or the Block Library runs at the rates in your settings.

## Node rate

The cycler in the corner of a node's tab strip sets its `Update Rate`.

| Option      | The node updates                   |
| ----------- | ---------------------------------- |
| `Automatic` | at the rate it picks for itself    |
| Data Hz     | at the data rate, e.g. `30hz`      |
| Anim Hz     | at the animation rate, e.g. `60hz` |
| `Frame`     | every frame, whatever the settings |

The data and animation options are named by their Hz from your settings. The cycler shows the rate in force, e.g. `Auto Rate: 30hz` or `Rate: 60hz`.

### What Automatic picks

| Rate        | Picked when the node                                                    |
| ----------- | ----------------------------------------------------------------------- |
| _Animation_ | has a `Code` field, reads a `Code` variable, or has smooth `Thresholds` |
| _Data_      | anything else                                                           |

Automatic never picks _Every frame_ on its own.

A node's code can tell Automatic what to pick:

```lua
-- any Code field on the node
setup(nil, { update_rate = "data" })
```

`update_rate` takes `"data"`, `"animation"` or `"frame"`. Write it as plain text in the call. It is read from the code before it runs, so a value from a variable does not work.

### When to set it yourself

Leave it on `Automatic` unless it gets it wrong.

- **Lower it** when code only formats a game value. A `Text` field in `Code` mode that shows ammo is fine on the data rate.
- **Raise it** when something moves or fades and looks choppy.
- **Use `Frame`** only for mod APIs that need a call each frame. It is the most expensive option.

A node with nothing that changes is skipped, whatever its rate says. A static label costs nothing to leave on `Automatic`.

## Block rate

The cycler on a block's tab strip sets its `Max Update Rate`. It caps every node on the block.

| Option        | Every node on the block                         |
| ------------- | ----------------------------------------------- |
| `As Authored` | runs at its own rate                            |
| Data Hz       | runs at the data rate at most                   |
| Anim Hz       | runs at the animation rate at most, `Frame` too |

The cap can only slow nodes down.

You can set it on a mod block without duplicating it.

Left on `As Authored`, the cycler shows the block's fastest node rate. Block-level work also runs at the animation rate while the block has:

- a block script
- a block field or event trigger in `Code` mode
- an event action with a `Delay` or a repeat
- a fade running

Capping the block to the data rate slows that work down too.

## Seeing what runs where

| Where                              | Shows                                                                                   |
| ---------------------------------- | --------------------------------------------------------------------------------------- |
| Block `Tools` > `Performance Info` | nodes per rate, e.g. `24 nodes: 18 data, 5 animation, 1 every frame`                    |
| Block `Tools` > `Performance Info` | a warning when any node runs every frame (a mod block shows it on its `Properties` tab) |
| Block Library entry                | `Rates: 18 data, 5 animation, 1 every frame`                                            |

## Reading other nodes

A node that reads another node's value sees it as of that node's last update.

- Keep the reader **above** the node it reads in the Blocks tree, and on the same rate or faster. Otherwise it trails by one update.
- `block.state` written by a block script updates at the block's rate. A node on a slower rate sees fewer of those updates.

## Code and time

`dt` in a node script is the time since **that node** last ran, not since the last frame. A node on _Data_ sees a bigger `dt` than one on _Animation_.

`anim` reads the right `dt` on its own, so it plays at the same speed at any rate.

```lua
-- a node's Position, Code mode: drifts 40px per second at any rate
setup({ x = 0 })
state.x = (state.x + 40 * dt) % 200
shift = { state.x, 0 }
```

## Good to know

- A hidden node does not update. When it shows again, `dt` covers the whole gap. Use `became_visible` or `setup(defaults, { reset_on_show = true })` to start over.
- Workspace functions have their own `Rate`, for how long a result is kept. See [Workspace Functions](../scripting/workspace_functions.md).
