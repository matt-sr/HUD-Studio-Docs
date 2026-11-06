Controls read your own input: which keys and buttons you are pressing. Use them for key overlays, showing an element while a key is held, or a keybind hint beside an icon.

In the picker: mode `Controls`, then `Keypress` or `Action`, then the key.

## Keypress and Action

| Source     | Reads                                     | Use it for                             |
| ---------- | ----------------------------------------- | -------------------------------------- |
| `Keypress` | one physical key or mouse button          | a specific key, whatever it's bound to |
| `Action`   | a game action: jump, dodge, ability, ping | following the player's keybinds        |

Prefer `Action` for anything shared, since other players have different binds.

## Fields

| Field               | Answers                             |
| ------------------- | ----------------------------------- |
| `Held?`             | is it down right now                |
| `Held For (s)`      | how long it has been held           |
| `Since Pressed (s)` | how long ago it was last pressed    |
| `Presses`           | how many presses since load         |
| `Keybind`           | the bound key's text. `Action` only |

Not every action can be held, so some have no `Held?` or `Held For (s)`.

## Using them

There is no one-off "pressed" field. To flash on a tap, compare `Since Pressed (s)`, which works at any update rate:

```lua
-- Block Visibility, Code mode: show for 0.3 seconds after pressing F
visible = keys.f.since_pressed < 0.3
```

```lua
-- Text field: the player's ability key
text = actions.ability.keybind
```

Presses are ignored while a menu or the chat has your input.
