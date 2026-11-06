Every field has a type. The type decides what the field holds, which control edits it, and which values can feed it.

## The types

| Type      | Holds                        | Fields                                               |
| --------- | ---------------------------- | ---------------------------------------------------- |
| number    | a number                     | `Current`, `Max`, `Font size`, `Rotation`, `Opacity` |
| text      | words or a number            | a text's `Text`                                      |
| boolean   | true or false                | `Visible`, `Shadow`, `Shrink to Fit`                 |
| color     | an ARGB color                | `Color`, `Backing Color`, a bar's `Background`       |
| material  | an icon or texture           | a rectangle's `Material` and `Fallback`              |
| vector    | a pair of numbers            | `Position`, `Size`                                   |
| pick list | one option from a fixed list | `Font`, `Alignment`, `Flip`, `Clip`, a bar's `Shape` |

## What each type accepts

A `Data Source` or `Variable` only lists values the field can take.

| Type      | Data Source               | Variable                   |
| --------- | ------------------------- | -------------------------- |
| number    | numbers and whole numbers | `Number`                   |
| text      | text and numbers          | `Text`, `Number`, `Choice` |
| boolean   | true / false only         | `Boolean`                  |
| color     | colors only               | `Color`                    |
| material  | materials only            | `Material`                 |
| vector    | none                      | none                       |
| pick list | none                      | none                       |

- A number never feeds a boolean. `0` would still count as true.
- A plain text value never feeds a `Material` field. Only values marked as a material do.
- `Rotation` and `Opacity` are numbers, but take no `Data Source`. Use `Thresholds` or `Code` to turn a game value into them.

## Modes by type

| Type      | Modes                                                                            |
| --------- | -------------------------------------------------------------------------------- |
| number    | `Static`, `Data Source`, `Signals`, `Controls`, `Variable`, `Code`               |
| text      | `Static`, `Data Source`, `Signals`, `Controls`, `Variable`, `Code`               |
| boolean   | `Static`, `Data Source`, `Signals`, `Controls`, `Conditions`, `Variable`, `Code` |
| color     | `Static`, `Thresholds`, `Data Source`, `Variable`, `Code`                        |
| material  | `Static`, `Data Source`, `Image`, `Variable`, `Code`                             |
| vector    | `Static`, `Code`                                                                 |
| pick list | `Static`, `Code`                                                                 |

Some fields add or drop a mode:

- `Visible` has no `Static`. An empty rule list already means always shown.
- `Opacity` has numeric `Thresholds`.
- A rectangle's `Size` has `Screen`.
- A text's `Font` has `Custom`.
- `Image` and `Custom` need SimpleAssets.

## Code values

A `Code` field must assign a value of its type.

| Type      | Assign                                         |
| --------- | ---------------------------------------------- |
| number    | `42`                                           |
| text      | `"Ammo"` or a number                           |
| boolean   | `true` or `false`                              |
| color     | `{255, 255, 60, 60}` (alpha, red, green, blue) |
| material  | a material path                                |
| vector    | `{120, 20}`                                    |
| pick list | one of the list's option ids                   |

The `Preview` box beside the script shows the value it assigned. It reads `Unset` or stays empty when the script assigns nothing.

A color in any other shape is ignored. The field falls back to its static color.

## Copy and paste across types

- Same field, same type: everything pastes, every mode included.
- Different field, same type: everything pastes, unless the mode is one the field does not have.
- Different type: only the `Data Source` pastes, and only when this field can take it. A number source pastes onto `Text`.
- Pick lists only paste onto the same field. Each one has its own list.

## Good to know

- Many game values are empty while there is nothing to read. A number or text field then shows nothing, and a material shows its `Fallback`.
- A color variable read by a field has an `Opacity` box. It fades the color for that field only.
- Block fields follow the same rules. A block's `Visible` is a boolean, its `Opacity` and `Scale` are numbers.
