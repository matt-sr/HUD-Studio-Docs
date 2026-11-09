Sources: `keys`

Each physical key and mouse button reads the same fields, whatever the player has bound to it: `keys.<key>.<field>`, e.g. `keys.f.held`.

## Keys

| Keys          | IDs                                                                                               |
| ------------- | ------------------------------------------------------------------------------------------------- |
| Letters       | `a` .. `z`                                                                                        |
| Digits        | `digit_0` .. `digit_9`                                                                            |
| Punctuation   | `comma`, `period`, `minus`                                                                        |
| Function keys | `f1` .. `f12`                                                                                     |
| Editing       | `space`, `tab`, `enter`, `backspace`, `esc`, `caps_lock`                                          |
| Modifiers     | `left_shift`, `right_shift`, `left_ctrl`, `right_ctrl`, `left_alt`, `right_alt`                   |
| Arrows        | `up`, `down`, `left`, `right`                                                                     |
| Navigation    | `insert`, `delete`, `home`, `end`, `page_up`, `page_down`                                         |
| Numpad        | `numpad_0` .. `numpad_9`, `numpad_plus`, `numpad_minus`, `numpad_enter`                           |
| Mouse         | `mouse_left`, `mouse_right`, `mouse_middle`, `mouse_extra_1` (Mouse 4), `mouse_extra_2` (Mouse 5) |

`end` is a Lua keyword, so read it as `keys["end"]`.

## Fields

| Field               | Leaf            | Type    | Meaning                                            |
| ------------------- | --------------- | ------- | -------------------------------------------------- |
| `Held?`             | `held`          | boolean | down right now                                     |
| `Held For (s)`      | `held_seconds`  | number  | seconds held; 0 while up                           |
| `Since Pressed (s)` | `since_pressed` | number  | seconds since the last press; `math.huge` if never |
| `Presses`           | `presses`       | integer | presses since load                                 |

```lua
-- Block Visibility, Code mode: show for 0.3 seconds after pressing F
visible = keys.f.since_pressed < 0.3
```

## Good to know

- Keys have no `Keybind` field. Use [Action](controls_action.md) to follow the player's binds.
- For an exact edge, compare `presses` against a count kept in `block.state`.
