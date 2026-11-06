A field is one setting on a block or a node: its `Position`, `Size`, `Color`, `Text`, `Visible`, and so on. Every field has a value, and a mode that decides where that value comes from.

## Modes

| Mode          | Its value is                                              |
| ------------- | --------------------------------------------------------- |
| `Static`      | what you type or pick                                     |
| `Data Source` | a value read from the game, such as health or ammo        |
| `Signals`     | a one-update pulse when something happens, such as a kill |
| `Controls`    | a key or game action being pressed                        |
| `Thresholds`  | a color or number chosen by how full a value is           |
| `Conditions`  | true or false, built from a list of rules                 |
| `Variable`    | one of the block's or its group's variables               |
| `Code`        | what a short Lua script assigns                           |

Some fields have extra modes of their own:

| Mode         | On                     | Its value is                        |
| ------------ | ---------------------- | ----------------------------------- |
| `Image`      | a rectangle's material | an image file, through SimpleAssets |
| `Custom`     | a text's `Font`        | a `.slug` font file                 |
| `Fill color` | a progress bar color   | the bar's own fill color            |
| `Screen`     | a rectangle's `Size`   | the size of the whole screen        |

Not every field offers every mode. A field only lists the modes that make sense for it.

## Types

Every field has a type: a number, text, true / false, a color or a material. A mode can only feed a field a value of its type.

- `Data Source` lists only the game values the field can take.
- `Variable` lists only variables of the matching type.

See [Field Types](../reference/field_types.md) for the full list.

## Switching modes

Switching mode keeps the work in every other mode. Switch from `Data Source` to `Code` and back, and the source is still picked.

The parked values are not read. They are kept so nothing is lost while you try things out.

- **Inactive Bindings** on the block's `Tools` tab, under `Mass Update`, wipes them all for that block. It can be undone.
- Exporting a block to a mod leaves them out. Your own copy keeps them.

## Copy and paste

Right-click a field for `Copy` and `Paste`. A paste onto a field of the same type brings over everything, every mode included, unless the mode is one that field does not have.

A paste onto a field of a different type only brings the `Data Source`, and only when the field can take its type. The field keeps its own static value and other modes.

## Block fields and node fields

A block has its own fields, such as `Visible`, `Opacity` and `Scale`. They act on every node inside it.

- A block's `Scale` resizes every node together.
- A node hidden by its block runs none of its fields.

## Code fields

A field in `Code` mode is a script. It runs each time the node updates, and assigns the field's value.

```lua
-- a rectangle's Color, Code mode: red while health is low
if my.status.health_percent < 30 then
    color = {255, 255, 60, 60}
else
    color = {255, 255, 255, 255}
end
```

A `Code` field makes its node update at the _Animation_ rate. If it only reads game values, set the node's rate to the data rate to save performance.

See [Node Scripts](../scripting/node_scripts.md) and [Block Scripts](../scripting/block_script.md).

## Good to know

- A field in `Static` mode costs nothing per update. Use it unless the value has to change.
- `Signals` last one update. A field reading one is true for a single update, then false again. See [Signals > Intro](../sources/signals_intro.md).
- A field reading a `Color` variable has an `Opacity` box beside it. It fades the color for that field only.
- Fields on a mod block are frozen. `Duplicate To Edit` makes them yours.
