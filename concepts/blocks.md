A block is one HUD element: a group of nodes that are placed, shown and hidden together. Every node on the canvas belongs to a block.

A block lets you:

- control the combined `Visibility` of its nodes
- control `Scale`, which increases its _combined size_, proportionally
- define `Events`, which allow you to _fire audio files_ based on any condition
- define `Variables`, which are _reusable values_ for all its nodes
- write lua `Block Scripts`; intended for _shared work_ that write to its _state_

Only a block's nodes are drawn; the block has no visuals of its own.

## Tabs

| Tab          | Holds                                                    |
| ------------ | -------------------------------------------------------- |
| `Properties` | the filters, Block Visibility and Block Style            |
| `Details`    | its name, summary and tags, and saving it to the library |
| `Variables`  | its variables                                            |
| `Events`     | its events                                               |
| `Tools`      | Mass Update, Cleanup, Performance Info                   |

The cycler in the corner of the tab strip is the block's update rate. For more information see [Concepts > Rates](rates.md)

## Visibility

A block is drawn only while every check passes. A hidden block hides all of its nodes, whatever their own rules say.

| Check              | Hides the block while              |
| ------------------ | ---------------------------------- |
| Eye                | it is off, in the Blocks tree      |
| `Gamemodes`        | the current gamemode is not ticked |
| `Classes`          | your current class is not ticked   |
| `Quick Conditions` | a ticked player state is not true  |
| `Visible`          | its rule says false                |

- Nothing ticked in `Gamemodes` or `Classes` means no restriction.
- `Quick Conditions` adds a row per player slot: in play, hogtied, dead, in party. Player 1 (You) also has spectating.
- `Visible` takes `Conditions`, `Source`, `Variable` or `Code`. An empty rule counts as visible.

For `Fade In`, `Fade Out`, `Linger` and `Delay`, see [Linger & Delay](../scripting/linger_delay.md) and [Fade in-out](../scripting/fades.md).

```lua
-- block Visibility, Code mode: show while you are below half health
visible = my.status.health_percent < 50
```

## Style

| Field           | Does                                                                                                   |
| --------------- | ------------------------------------------------------------------------------------------------------ |
| `Position`      | where the block sits on screen, in pixels                                                              |
| `Scale`         | resizes every node together about the `Anchor`; 0.05 .. 20                                             |
| `Opacity`       | 0 .. 1, multiplies every node's own opacity                                                            |
| `Follow Camera` | the block lags behind as you look around, then settles back                                            |
| `Follow Motion` | `Camera Sway` rides your walk bob, jumps and landings; `Crosshair` moves exactly as the crosshair does |

- `Position` in `Code` mode adds a `shift` on top of the saved X / Y. It is a relative `move`, not an absolute position.
- `Scale` grows from its `Anchor`: `Center` grows outward, `Top-left` grows down and right.
- `Opacity` takes `Static`, `Thresholds`, `Variable` or `Code`.
- `Follow Camera` and `Follow Motion` are placement settings. Players can change them on a block sourced from a mod.

```lua
-- block Opacity, Code mode: dim the whole block while sprinting
opacity = my.state.sprinting and 0.4 or 1
```

## Variables, Events and Scripts

- **Variables** are named values its nodes read. See [Variables](variables_concepts.md).
- **Events** play a sound when something happens. In future updates, this may extend to other event-based triggers. See [Events](../ui/events.md).
- **The block script** runs before anything else on the block and leaves its results in `block.state`. Open it from the script button on the Properties panel's side toolbar; it turns red when the script errors. See [Block Scripts](../scripting/block_script.md).

## Tools

`Rebind Source` points every binding on the block at another player in one go. Use it to turn a Player 1 element into a Player 2 one.

- It rewrites inactive bindings too, the ones kept behind a field's current mode.
- `Rewrite Code Bodies` and `Rewrite Block Script` also rewrite source names inside code.
- Bindings that cannot point at the new player are skipped and counted on the button.

`Inactive Bindings` wipes every binding kept behind a field's current mode, such as a `Data Source` left under `Code`.

## Performance

`Max Update Rate` caps how often every node on the block updates.

Left on `Automatic`, the block runs at its fastest node's rate. A block script or a block field in `Code` mode raises it to the _Animation_ rate.

`Performance Info` lists how many nodes run at each rate, e.g. `24 nodes: 18 data, 5 animation, 1 every frame`.

## Order on the block

Each update runs in this order:

1. Opacity
2. Block script
3. Variables
4. Visibility
5. Events
6. Nodes, _bottom to top_ as the Blocks tree lists them
7. Scale
8. Position

## Mod blocks

A block marked `[MOD]` came from another mod. Its content belongs to that mod's author and updates with it.

- You can still move it, scale it, change `Follow Camera` / `Follow Motion`, and set any variables its author exposed under `Customise`.
- Everything else is frozen. `Duplicate To Edit` makes your own copy and removes the mod's.
- Tweak it to your hearts desire, but note that the duplicated copy no longer updates, and its errors are yours.
- A mod block whose required mod is disabled or uninstalled is switched off.

## Multiple small blocks, or one bigger block?

There are pros and cons to both. For example, a **Vitals** readout for Stamina, Health and Toughness, each metric with a bar and a % text readout.

You could either make each text + bar pair their own blocks, or you could keep them in one block named **Vitals**.

Pros for Stamina, Health and Toughness **in one block**:

- They can be moved and scaled together
- One block script for all nodes
- Less visibility rules need definining
- It ships as a single **Vitals** block to mods: less clutter in library, less entries to manage, easier for mod users.
- Arguably better for performance, as there's less to evaluate

Pros for Stamina, Health and Toughness as **separate blocks**:

- They create a more modular HUD in your library, and shipped with mods
- They are easier to develop: less rows to manage in the blocks tree, can be created one-by-one
- They can be placed at opposite sides of the screen - a block should only ever hug one screen edge

Blocks that belong together can be put in a group. See [Groups](groups.md). Multiple blocks can share variables from one Group, which have no screen placement, meaning there is no argument for `variables` in either case.
