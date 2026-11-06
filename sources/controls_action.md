Sources: `actions`

Each game action reads the same fields, through whatever key the player has bound to it: `actions.<action>.<field>`, e.g. `actions.sprint.held`.

## Actions

| Action                 | ID                 | Can be held |
| ---------------------- | ------------------ | ----------- |
| Primary Attack         | `primary`          | yes         |
| Secondary Attack / Aim | `secondary`        | yes         |
| Weapon Special         | `special`          | yes         |
| Reload                 | `reload`           | yes         |
| Inspect Weapon         | `inspect`          | yes         |
| Ability                | `ability`          | yes         |
| Blitz                  | `blitz`            | yes         |
| Interact               | `interact`         | yes         |
| Jump                   | `jump`             | yes         |
| Crouch                 | `crouch`           | yes         |
| Sprint                 | `sprint`           | yes         |
| Tactical Overlay       | `scoreboard`       | yes         |
| Comms Wheel            | `com_wheel`        | yes         |
| Push To Talk           | `push_to_talk`     | yes         |
| Dodge                  | `dodge`            | no          |
| Ping                   | `ping`             | no          |
| Quick Wield            | `quick_wield`      | no          |
| Wield Melee            | `wield_melee`      | no          |
| Wield Ranged           | `wield_ranged`     | no          |
| Wield Pocketable       | `wield_pocketable` | no          |
| Wield Stimm            | `wield_stimm`      | no          |
| Wield Device           | `wield_device`     | no          |

## Fields

| Field               | Leaf            | Type    | Meaning                                         |
| ------------------- | --------------- | ------- | ----------------------------------------------- |
| `Held?`             | `held`          | boolean | down right now. Holdable actions only           |
| `Held For (s)`      | `held_seconds`  | number  | seconds held; 0 while up. Holdable actions only |
| `Since Pressed (s)` | `since_pressed` | number  | seconds since the last press; `math.huge` if never |
| `Presses`           | `presses`       | integer | presses since load                              |
| `Keybind`           | `keybind`       | string  | the bound key as display text                   |

```lua
-- Text field: the player's ability key
text = actions.ability.keybind
```

## Good to know

- `Keybind` is the same text the vanilla weapon and ability slots draw: `1`, `SPACE`, or a mouse or gamepad glyph. It follows rebinds and switches to gamepad glyphs while a pad is in use, refreshed about once a second.
- `since_pressed < 0.3` flashes on a tap at any update rate. For an exact edge, compare `presses` against a count kept in `block.state`.
