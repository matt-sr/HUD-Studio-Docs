A workspace function is a named Lua function a workspace owns. Every block in that workspace can call it as `workspace.<name>(...)`, from any script: a block script, a node's Code field, a Code variable, another workspace function.

Use one when several blocks need the same code: a colour lookup, a time formatter, a shared random value.

```lua
-- any script in the workspace
text = workspace.format_time(my.ability.cooldown_remaining)
```

A workspace function works like `#include`: there is one definition, and every block that calls it gets its own copy, with its own setup run, locals and results. Nothing is shared between blocks unless the function is set to **Shared** (see below).

## Making one

In the Code Editor's Explorer, press **+** on a workspace's heading (**Add Function**). Give it a name: lowercase letters, digits and single `_` between them, no leading digit. The name is what callers write after `workspace.`, so it must be unique in the workspace.

Setup region:

```lua
-- Locals here are per-block, never shared
local SECONDS_PER_MINUTE = 60
```

Body region:

```lua
--- Runs on every call; each calling block has its own copy, locals and results
---@param seconds number  time left
---@return string
local function format_time(seconds)
  local minutes = math.floor(seconds / SECONDS_PER_MINUTE)
  local rest = math.floor(seconds % SECONDS_PER_MINUTE)
  return string.format("%d:%02d", minutes, rest)
end
```

| Part               | What it is                                                                                      |
| ------------------ | ----------------------------------------------------------------------------------------------- |
| Setup region (top) | Runs once per calling block, when that block compiles. Constants, lookup tables, local helpers. |
| Header (locked)    | Generated from the signature. Press it to open the signature dialog.                            |
| Body region        | The function body. Runs on every call.                                                          |

The function always returns what the body returns.

## The signature dialog

Press the header to open it.

| Row         | Format                    | Example                         |
| ----------- | ------------------------- | ------------------------------- |
| Parameter N | `name  type  description` | `unit Unit?  the player's unit` |
| Return N    | `type  description`       | `string  the colour`            |

- Up to 8 parameters and 4 returns.
- Types are LuaLS text (`number`, `Unit?`, `string|nil`, `fun(a: number): string`). They feed the editor's hints and autocomplete. They are never checked at runtime.
- Parameter names follow the Lua identifier rule. `_unused` is allowed. `...` is allowed as the last parameter only.
- Renaming a parameter does not rewrite the body. The old name then reads nil.
- **Name** is editable until something calls the function or it is exported to a mod. After that the row says who holds it.
- **Call sites** lists every block, node and field that calls it, on the canvas, in the trash or in the library.
- **Delete** is refused while anything calls it, or once it has been exported. The button says why.

Creating, editing, renaming and deleting a function are all undone with Ctrl+Z.

## What a function can read

A per-block function runs inside the calling block. In the **body**, everything is the caller's:

| Name                 | In the body                          | In the setup box        |
| -------------------- | ------------------------------------ | ----------------------- |
| `my`, `sources`      | do not read (never rebinded)         | do not read             |
| `vars`, `group_vars` | the calling block's                  | do not read             |
| `state`              | the **calling script's** own `state` | error                   |
| `block`, `t`, `dt`   | the caller's                         | nil                     |
| `anim`               | steps with the calling node          | do not use              |
| other functions      | `workspace.<name>(...)`              | `workspace.<name>(...)` |

`state` belongs to whichever script made the call. Prefix the keys with the function's name so they cannot clash with the script's own or another function's.

```lua
-- body of workspace.flash(on): blink while `on` is true
state.flash_started = on and (state.flash_started or t) or nil
if not state.flash_started then
  return 1
end
return (t - state.flash_started) % 0.5 < 0.25 and 1 or 0.3
```

`setup()` is not allowed in a function. Saving one that calls it is refused.

## Setup box and body

The body runs on every call, every tick, for every block that calls it. Anything built once belongs in the setup box.

```lua
-- setup box
local WEAPON_COLORS = {
  melee  = { 255, 220, 120, 60 },
  ranged = { 255, 90, 160, 230 },
  none   = { 255, 200, 200, 200 },
}
```

```lua
---@param weapon_type string
---@return table
-- body
return WEAPON_COLORS[weapon_type] or WEAPON_COLORS.none
```

- No `{ }` tables or `function` closures in the body: each call would make a new one. Build them in setup.
- Keep the setup box's locals few. Each one the body reads counts towards the game's limit of 60 per function. Group constants into one table, as above.
- No `do return ... end` in the setup box. It ends the function early.

## Calling functions from functions

A function can call any other function in its workspace, in its setup box or its body. Bodies may call each other in a loop. Setup boxes may not: two setups that each call the other fail with `workspace functions load each other in a loop: a -> b -> a`.

## Errors

- A body error shows on the **caller**, as `workspace.<name> line N`.
- A setup error, or a syntax error, shows in the function's own tab, and on every caller as the function failing to load.
- Calling a name the workspace does not have: `there is no workspace.<name> in this workspace`.

## Shared

Turn on **Shared** in the signature dialog and the function stops being per-block. There is one copy for the whole workspace:

- the setup box runs once, and its locals are memory every caller shares;
- the body's return is kept, per argument set, for one update. Every other call in that update with the same arguments gets the kept return and the body does not run.

Callers do not change. They still write `workspace.<name>(...)`.

Use Shared when every block should see the **same** value (a shared random pick, a cycling index), or when the work is expensive and the same arguments come from many blocks. Leave it off for small pure helpers like `format_time`: the cache lookup costs more than the body.

```lua
-- setup box (shared)
local POOL = { "ARMED", "LOADED", "READY" }
local current = 1

---@return string
-- body: one pick per update, the same for every block
current = current % #POOL + 1
return POOL[current]
```

### Rate

**Rate** sets how long a kept return lasts.

| Rate           | Lasts                                                   |
| -------------- | ------------------------------------------------------- |
| Data Rate      | one tick at the player's data update rate (the default) |
| Animation Rate | one tick at the player's animation update rate          |
| Every Frame    | one frame                                               |
| Custom         | a fixed rate in Hz, 0.1 .. 240                          |

Prefer Data Rate or Animation Rate. They follow each player's own rate settings, as node update rates do, so the function costs what that player chose. A Custom rate ignores those settings.

Every caller agrees on where a period starts and ends, whatever its own update rate. A caller that updates slower than the function's rate reads whatever return is current when it asks.

Rate only controls how long a return is reused. To change something every 2 seconds, time it in the body:

```lua
-- setup box (shared)
local STEP = 2
local next_change = 0
local index = 1

---@param count integer
---@return integer
-- body
if t >= next_change then
  next_change = t + STEP
  index = index % count + 1
end
return index
```

### Arguments are the cache key

Each distinct set of arguments is its own kept return. The body runs once per set per period, and every run changes the shared locals. Only the return is reused.

```lua
workspace.pick_for(1)  -- runs the body
workspace.pick_for(1)  -- kept return, body does not run
workspace.pick_for(2)  -- runs the body again: different arguments
```

- `f()` and `f(nil)` are the same key. Only the declared parameters count.
- Tables, units and other objects are compared by identity. `sources.player_1`, `my` and a unit are the same object every call, so they hit. A table written in the call, `workspace.f({ 1, 2 })`, is new every call, so it never hits and the body runs every time.
- A parameter typed with `table`, `[]` or `{ ... }` is refused for a shared function, and so is `...`. An untyped or `any` parameter is let through, so a fresh table passed there misses silently.
- Numbers that change every call (`t`, a health value) miss every call too. Round them first, or work them out inside the function.
- Past 256 argument sets the whole cache empties and starts again. If that happens within 10 seconds of it starting, the tab warns that arguments differ on nearly every call.

The setup box's head line counts how many times the body ran in its last frame: one per argument set. More runs than you expect means the arguments vary.

### What a shared function cannot read

There is no calling block, so the block's names are not there:

| Name                                   | In a shared function                                    |
| -------------------------------------- | ------------------------------------------------------- |
| `vars`, `group_vars`, `state`, `block` | error: `isn't available in a shared workspace function` |
| `my`, `sources`                        | live game data, the same for every caller               |
| `t`, `dt`                              | the frame's; `anim` steps by the frame                  |

Pass what you need in as an argument. The editor warns when a shared function's code mentions one of the four.

### Good to know

- Returned tables are shared with every caller. Read them, never change them.
- A body error is kept for the period: every caller in it shows the same error. It also shows in the function's tab until the next edit. A runaway (too many instructions) is not kept; the next caller tries again.
- Setup runs again, and the shared locals reset, whenever any function in the workspace is edited, a mod registers, or a workspace is hidden, shown or added.
- A shared function calling a per-block one gets a single copy of it inside the shared function. A per-block function calling a shared one shares it like any caller.
- The body's cost lands on whichever block called first in the period, so per-block costs in the profiler move between blocks.

### Same output without Shared

Blocks can show the same value with no shared memory at all, by working it out from the time:

```lua
-- per-block: every block gets the same pick for the same 2-second step
local step = math.floor(t / 2)
return POOL[step % #POOL + 1]
```

## Read From

Functions do not follow Read From. A function reading `my` or `sources.player_1` keeps reading player 1 when its caller is rebound. Take the player as a parameter:

```lua
---@param player table  a source slot, such as my or sources.player_2
---@return number
-- body
return player.status.health_percent
```

```lua
-- caller: Read From rewrites this `my` along with the rest of the script
local health = workspace.health_of(my)
```

## Moving blocks between workspaces

A block calls the functions of the workspace it saves to. Moving code to another workspace brings the functions it calls, and the functions those call.

| Action                                        | Functions                                                                  |
| --------------------------------------------- | -------------------------------------------------------------------------- |
| Duplicate, copy / paste a block or node       | brought along                                                              |
| Change a block's Save to                      | brought along                                                              |
| Change a group's Save to                      | its user blocks move with it, functions brought along                      |
| Save a block or group to the library          | brought along                                                              |
| Import a `.hsx` file                          | brought along, into My workspace                                           |
| Drag a node into a block of another workspace | refused unless that workspace has identical copies: copy and paste instead |

- If the target already has a **different** function of the same name, nothing moves: `workspace.<x> is different in <target>: nothing was moved`. An identical one is simply reused.
- Ctrl+Z of a move takes the brought functions out again, unless something calls them by then. It says which it kept.
- Calls written as `workspace[name]`, or through an alias (`local w = workspace`), are never brought along. The editor warns on the bracket form.

## Mods

**Export to Mod** ships every function in the workspace with the mod. Each export ships them all as they are now, including half-finished edits. Export All counts a function-only edit as pending.

Blocks inserted from a mod call **that mod's** functions, as the installed mod has them. Keep Updated does not affect this. Two mods can each ship a `format_time` without clashing.

If the mod is missing or disabled, its blocks' calls fail with `workspace function owner '<mod>' is not installed`, and those blocks cannot be duplicated, saved or exported while their code calls functions.

## Good to know

- Always use `local`. A global set without one lands on the calling block, where all its scripts see it.
- `workspace` is read-only. Do not assign to it.
- A block in a hidden workspace calls My workspace's functions.
- Editing a function recompiles every block that calls it.

See [For Modders & Coders](../scripting/index.md) for every global and the full rules.
