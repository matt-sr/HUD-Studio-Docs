This page covers the Variables tab. For what variables are and when to use them, see [Variables](../concepts/variables_concepts.md).

Select a block and open the **Variables** tab in its Properties panel. Each variable is a card.

## Layout

| Part    | Where  | Does                                      |
| ------- | ------ | ----------------------------------------- |
| Top row | top    | copy, paste, and the User-editable picker |
| Cards   | middle | one per variable, in the order they run   |
| Add New | bottom | pick a type to add a variable             |

## Adding a variable

1. Open the **- Type -** dropdown on the **Add New** slot.
2. Pick a type.

| Type       | Holds                             |
| ---------- | --------------------------------- |
| `Number`   | a number                          |
| `Text`     | a line of text                    |
| `Boolean`  | `true` or `false`                 |
| `Color`    | a colour                          |
| `Material` | a material or image               |
| `Choice`   | one of a list of options you type |

A block holds up to **20** variables.

## The card head

| Part      | Does                                            |
| --------- | ----------------------------------------------- |
| Type      | what it holds. Locked while something reads it  |
| Name      | the name you see in pickers                     |
| ID        | what code calls it, e.g. `vars.accent`          |
| up / down | move the variable. Off if it would break a read |
| delete    | remove the variable                             |

The ID follows the name until something uses the variable. Then it stays put, so renaming never breaks a read.

If the variable is in use, the delete tooltip warns how many fields read it.

## Mode and default

The line under the head picks the **Mode** and the **Default** value.

| Mode     | The default is                                  |
| -------- | ----------------------------------------------- |
| `Static` | the value                                       |
| `Cases`  | the value while no case is true                 |
| `Code`   | the value while the code gives nothing or fails |

A `Choice` variable has an **Options** box. Type the choices, separated by commas.

### Where a value comes from

A value box ends in a toggle. Click it to switch between:

- a typed value
- a variable above this one, of the same type
- a data source
- an image file (`Material` only)

The toggle is off when there is no variable above or data source of that type.

## Cases mode

Each case is one line: its conditions on the left, its value on the right.

- **+ Add Case** adds a line. A variable holds up to **12** cases.
- Click the conditions to edit them in the [Condition Builder](condition_builder.md).
- The first case whose conditions are true gives the value. A case with no conditions never does.
- Drag the handle to reorder cases.

## Code mode

Code mode shows a button that opens the [Code Editor](code_editor.md) on this variable's script. The script assigns `value`.

## Preview

**Preview** shows what the variable came out as on the block's last update. It is read only. `Color` variables have no preview box.

The line that gave the value is drawn bright. In Cases mode, that tells you which case won.

## Copy and paste

1. Tick the variables in the **COPY** picker, then press **COPY**.
2. On another block, tick them in the **PASTE** picker, then press **PASTE**.

To copy one variable, right click its card or press `Ctrl+C` over it.

## User-editable

The **User-editable** picker sets which variables players can change once the block ships in a mod. Only `Static` variables can be picked.

A player who adds the block sees those variables in its **Properties** tab. Their values are kept when the block updates. See [Exporting](../mod_making/exporting.md).

## Reading a variable from a field

Set a field's mode to **Variable**, then pick the variable. Only variables of a type the field accepts are listed.

A field reading a `Color` variable has an **Opacity** box beside it. It fades the colour for that field only.

## Good to know

- Variables run **top to bottom**. A card can only read the cards above it.
- Groups have their own variables, read as `group_vars.<id>`. See [Groups](../concepts/groups.md).
