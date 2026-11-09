How Lua scripts run in HUD Studio, what they can read, and the rules they follow.

## Kinds of script

| Script        | Where                         | Writes to                                                |
| ------------- | ----------------------------- | -------------------------------------------------------- |
| Block script  | the block's Script button     | nothing; it fills `state`                                |
| Block field   | a block field in `Code` mode  | the field's name: `visible`, `scale`, `shift`, `opacity` |
| Node field    | a node field in `Code` mode   | the field's name: `text`, `color`, `size`, ...           |
| Style script  | a node's Style section button | keys on `style`                                          |
| Code variable | a variable in `Code` mode     | `value`                                                  |

See [Block Scripts](../scripting/block_script.md) and [Node Scripts](../scripting/node_scripts.md) for each one in detail.

## No `return`

You never type `return`. Each field script is wrapped for you: the field's name is declared as a local, your code runs, and that local is handed back.

```lua
-- this is the Color field of a rect
-- `color` already exists as a local; assign it
local hurt = my.status.health_percent < 30
color = hurt and { 255, 220, 40, 40 } or { 255, 255, 255, 255 }
```

Leave the field's name unassigned (nil) and the field falls back to its static value.

The block script has no output. It only writes to `state`.

## When scripts run

Scripts run on the game's render thread, one at a time, never in parallel.

Each block tick runs in this order:

1. block `opacity`
2. block script
3. variables, top to bottom
4. block `visible`, then events
5. every node, back to front (bottom to top in the Blocks tree): its `visible`, then its other fields in name order, then its style script
6. block `scale`, then block `shift`

Block `opacity` runs before the block script, so it reads `block.state` from the last tick.

A block with any block-level code ticks at the _Animation_ rate. Nodes pick their own rate (see [Update rates](#update-rates) below), so a node can run between two block ticks. `block.state` it reads is then from the last block tick.

## State

`state` is a table that keeps its contents between updates. Everything else in a script is gone when it ends.

| Script        | Its `state`                                    |
| ------------- | ---------------------------------------------- |
| Block script  | the block's own: `block.state` everywhere else |
| Block field   | private to that field                          |
| Node field    | one table per node, shared by all its fields   |
| Code variable | private to that variable                       |

`state` is wiped whenever the block recompiles: any code edit, a node added, removed or moved, the document loading.

`setup` seeds `state` once per compile:

```lua
-- same as: state.count = state.count or 0
setup({ count = 0, last_hp = 1 })
```

## Globals

### Per script

| Name              | Type       | Notes                                                  |
| ----------------- | ---------- | ------------------------------------------------------ |
| `state`           | table      | see [State](#state)                                    |
| `block`           | BlockView  | read-only view of the block; `block.state` is writable |
| `t`               | number     | game time now, in seconds                              |
| `dt`              | number     | seconds since this block or node last updated          |
| `became_visible`  | boolean    | true on the first run after the script stopped running |
| `value`, `values` | any, table | style script only: this node's resolved field values   |

### Data

| Name         | Notes                                               |
| ------------ | --------------------------------------------------- |
| `sources`    | every data source: `sources.player_2.status.health` |
| `my`         | short for `sources.player_1`                        |
| `vars`       | this block's variables by id: `vars.accent`         |
| `group_vars` | the block's group's variables by id                 |

A source id also works on its own: `player_2.status.health`. Only the sources a script reads are worked out.

`sources`, `my`, `vars`, `group_vars` and `block` are read-only. Writing to them raises an error.

### Helpers

| Name                                              | Notes                                                                                    |
| ------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| `anim`                                            | easing, timing and sequences; see [anim](../scripting/anim.md)                           |
| `setup(defaults, options)`                        | seed `state`; options `reset_on_show`, `update_rate`                                     |
| `echo(fmt, ...)`                                  | print to chat, tagged `[block:node:field]`                                               |
| `count_players(path, op, a, b)`                   | how many players pass a test: `count_players("state.downed")`                            |
| `query_player(slot, path, op, a, b)`              | one slot (0 = spectated) passes a test                                                   |
| `unit_from_player_slot(slot)`                     | the unit in a slot, or nil                                                               |
| `char_id_from_player_slot(slot)`                  | the character id in a slot, or nil                                                       |
| `account_id_from_player_slot(slot)`               | the account id in a slot, or nil                                                         |
| `simple_asset(path)`                              | an image from `mods/hud_studio/assets/` as a material value (needs the SimpleAssets mod) |
| `simple_asset_gif(folder, ext, first, last, fps)` | a numbered image sequence as a looping material                                          |
| `get_mod(name)`                                   | another mod's handle, for cross-mod reads                                                |

### Lua and the game

`math`, `string`, `table`, `str` (darklib string helpers), `tostring`, `tonumber`, `pairs`, `ipairs`, `select`, `type`.

`Unit`, `ScriptUnit`, `Managers`, `Color` are the game's own, for reading.

Not available: `io`, `os`, `debug`, `load`, `loadstring`, `require`, `print`. `mod` and `get_mod("hud_studio")` raise an error; use `echo` to log.

`math`, `string`, `table` and `str` are copies. Changing them only affects your block.

## One environment per block

Every script on a block shares one environment: the block script, block fields, every node's fields and the variables.

A global assigned without `local` is visible to all of them. A recompile does not clear it: it stays until the document reloads.

```lua
-- block script
hp = my.status.health -- leaks: every script on this block now sees `hp`
local hp_now = my.status.health -- stays inside this script
```

Always use `local`, and share values through `block.state`.

A global named after a source id (`player_1 = ...`) is removed on recompile, so it can never hide the source for good.

## Reading the block and its nodes

`block` is a read-only view of the block.

| Call                         | Returns                                                        |
| ---------------------------- | -------------------------------------------------------------- |
| `block.get_value(field)`     | `visible`, `opacity`, `scale`, `offset`, `shift`, `screen_dir` |
| `block.get_node_by_id(id)`   | a NodeView, or nil                                             |
| `block.get_node_by_index(i)` | a NodeView, or nil                                             |
| `block.get_id()`             | the block's id                                                 |
| `block.get_group()`          | the block's group name, or nil outside a group                 |
| `node.get_value(field)`      | that node's value this update, however it is bound             |
| `node.get_type()`            | the node's type: `text`, `rect`, `progress_bar`                |

`offset` and `shift` answer two numbers: `local x, y = block.get_value("offset")`. `screen_dir` answers `x, y` from -1 to 1: where the block's centre sits relative to the screen centre (`0, 0` is the middle, `1, 1` the bottom-right corner). It ignores the block's shift, so a shift can read it to cast a ghost or shadow away from the centre: `local x, y = block.get_value("screen_dir") return x * 12, y * 12`.

A progress bar also answers `fill_edge`: two numbers, where its fill stops this update, in the same space as node offsets. To pin a node to the edge, give it a `shift` of the edge minus its own offset:

```lua
local bar = block.get_node_by_id("bar")
local edge_x, edge_y = bar.get_value("fill_edge")
local my_x, my_y = block.get_node_by_id("marker").get_value("offset")
return { edge_x - my_x, edge_y - my_y }
```

The point sits midway across the bar's thickness. A `center` bar answers its right (or bottom) edge. Straight bars only for now: curved and ring answer nil.

`ghost_edge` answers the same way for the end of the ghost trail, and matches `fill_edge` once the trail has caught up. It is nil when the bar has no ghost colour.

Both edges are this update's only if the bar has already run: keep the follower **above** the bar in the tree, and on the same update rate or faster (`setup(nil, { update_rate = "frame" })`). Otherwise the follower trails the bar by an update.

Nodes run back to front, which is bottom to top in the Blocks tree. A node reading one **below** it in the tree sees this update; one **above** it sees the last.

## Update rates

Each node has an [Update Rate](../concepts/rates.md): `Automatic`, `Data`, `Animation` or `Frame`. The Hz come from the mod's settings.

- `Automatic` picks `Animation` for a node with code, `Data` for one without.
- `setup(nil, { update_rate = "frame" })` sets what Automatic picks. It is read from the code text, so write it as a literal.
- `dt` is per node: the time since **that node** last ran.

`anim` reads the right `dt` on its own, so it is framerate independent at any rate.

## When scripts stop

| Situation                                             | Block script | Node scripts        |
| ----------------------------------------------------- | ------------ | ------------------- |
| Block eye off, group eye off                          | stops        | stop                |
| Gamemode / class filter fails                         | stops        | stop                |
| Block hidden by its rules                             | runs         | stop once faded out |
| Block lingering, or fading out by its rules           | runs         | run                 |
| Block fading out by its eye or a filter               | stops        | run                 |
| Node hidden by its Visibility rule                    | -            | only `visible` runs |
| Node hidden by its eye, a filter or a quick condition | -            | stop                |
| Required mod missing                                  | stops        | stop                |

A script that adds up time sees a gap when it comes back. Check `became_visible`, or use `setup(defaults, { reset_on_show = true })` on node scripts.

## Errors

- A field script that errors uses its static value. A block `visible` that errors counts as visible. A style script that errors is dropped. A block script that errors is skipped for that tick.
- The editor marks the field with the error.
- Scripts are watched for runaway loops for a few seconds after every edit and every mission change, and always while the editor is open. A script that runs too long is stopped and reported once.

A loop that only goes runaway in a state you never tested can still hang the game. Keep loops bounded.

## Performance

- Scripts can run every frame, for every block on screen. Keep them short.
- Don't build tables you throw away every update. Keep them in `state` and reuse them.
- A node with no code and no sources is worked out once and then skipped.
- Read a source once into a local rather than walking `my.status` three times.

## Rebinding

_Mass Update > Rebind Source_ moves a block from one player to another, for example `player_1` to `player_3`.

With _Rewrite Code Bodies_ and _Rewrite Block Script_ on, as they are by default, it also edits your code:

- Whole-word source ids are swapped: `player_1.status.health` becomes `player_3.status.health`.
- `my` is player 1, so rebinding away from `player_1` rewrites `my` to `sources.player_3`.
- `sources["player_1"]` is rewritten too.
- Strings and comments are left alone.
- Ids built at runtime are **not**: `sources["player_" .. slot]` keeps reading the same slot.

The _Read From_ option in the Block Library does the same rewrite when a block is added for another player.

To make a script rebind cleanly, name the source directly:

```lua
-- rebinds: player_1 is written out
local player = sources.player_1
local health = player.status.health_percent
text = string.format("%d%%", health)
```

```lua
-- does not rebind: the id is built from a number
local slot_id = "player_" .. 1
local health = sources[slot_id].status.health_percent
text = string.format("%d%%", health)
```
