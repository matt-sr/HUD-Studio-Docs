`Visible` decides whether a block or node draws. It sits in the Visibility section of the block's and the node's properties.

Something hidden costs little. A hidden block runs no node fields. Its block script still runs, because its rules may read `state`. It stops only when the block is force hidden or fails its `Gamemodes` / `Classes` filters. A hidden node runs only its `visible` script.

## Modes

| Mode          | Shown while                         |
| ------------- | ----------------------------------- |
| `Conditions`  | its rule list is true               |
| `Data Source` | a true / false game value is true   |
| `Signals`     | a signal fires, for one update      |
| `Controls`    | a key or game action is held        |
| `Variable`    | a true / false variable is true     |
| `Code`        | the script assigns `visible = true` |

`Conditions` is the default. _An empty rule list is always shown_.

`Data Source` only lists true / false values. A number would always read as shown.

## The eye

Each row in the Blocks Tree has an eye. With no rules set, it is a plain show / hide toggle.

Once something decides visibility for it, the eye turns blue. It now has three positions:

| Eye         | Does                                 |
| ----------- | ------------------------------------ |
| Auto (blue) | the rules decide                     |
| Off         | hidden, rules ignored                |
| On          | shown, every rule and filter ignored |

Click to cycle: auto, off, on, back to auto.

Forced on is for checking a layout. It ignores the mode, quick conditions and filters alike.

## Quick Conditions

The **Quick Conditions** button on the section heading adds a row of checkboxes for a party slot.

| Check        | Shown while the player is   |
| ------------ | --------------------------- |
| `IN PLAY`    | alive and not hogtied       |
| `HOGTIED`    | hogtied, waiting for rescue |
| `DEAD`       | dead                        |
| `IN PARTY`   | in your party               |
| `SPECTATING` | spectating. `Player 1` only |

- Ticks in one row are OR: `IN PLAY` or `HOGTIED`.
- Rows are AND: each row must pass.
- A row with nothing ticked is no filter.

Mixing Quick Conditions for multiple players is almost always a bad idea as it means rebinding from one player to another will produce unexpected results.

Quick conditions and the Visible mode combine: both must be true to show.

## Filters

`Gamemodes` and `Classes` limit where a block or node shows.

| Filter      | Options                                         |
| ----------- | ----------------------------------------------- |
| `Gamemodes` | `MISSION`, `HUB`, `TRAINING`                    |
| `Classes`   | `VET`, `PSY`, `ZLT`, `OGR`, `ARB`, `HIV`, `SKT` |

Nothing ticked is no filter. Tick one or more to show only there.

The class is your own class, _even while spectating_.

## What hides what

A block or node draws only when all of these pass:

1. its group's eye
2. its eye
3. its `Gamemodes` and `Classes` filters
4. its quick conditions
5. its Visible mode

A node also needs its block to be shown.

A block whose required mod is missing never draws.

The Condition Builder's info line says which one is hiding it.

## Timing

The _Timing_ card holds Fade In, Fade Out, Linger and Delay.

- Delay and Linger time the quick conditions and the mode. Not the eye or the filters.
- Fades run on every change except a group's eye.

See [Linger & Delay](../scripting/linger_delay.md) and [Fade in-out](../scripting/fades.md).

## In code

A `Code` mode script assigns `visible`:

```lua
-- a block's Visible field: show while reloading or low on ammo
local mag_percent = my.equipment.ammo_mag_remaining_percent
visible = my.equipment.is_reloading or mag_percent < 25
```

`became_visible` is true on the first run after something starts drawing. Use it to restart an animation on each appearance.

## Good to know

- Hide a block, not all of its nodes. One hidden block saves every node's work.
- `Signals` last one update. Add a Linger to keep the block up after the signal.
- Selected and hovered items in the editor draw at full, whatever their fade.
