A variable is a _named value_ that belongs to a block. You set it once, and any number of fields on that block and its nodes read it.

## What they are for

- A shared accent colour, used by a bar, a material tint and its text
- A condition such as "is player 1 low on health?", worked out once and read by name
- Keeping the values worth tweaking together on one tab

## Advantages

- Changing one colour rethemes the whole block
- A condition several nodes need is written once instead of on each node
- `Fixed` and `Cases` variables need no code
- A variable is worked out once per update, however many fields read it. A field reading a `Fixed` variable costs the same as a field with the value typed in

## The three modes

| Mode    | Its value is                                                            | Use it for                              |
| ------- | ----------------------------------------------------------------------- | --------------------------------------- |
| `Fixed` | what you type                                                           | a shared colour, size, text or material |
| `Cases` | the value of the first case whose conditions are true, else the default | a colour or text that follows a state   |
| `Code`  | what a short script assigns to `value`                                  | anything the other two cannot express   |

A variable is always assigned a data type - `Number`, `Text`, `Boolean`, `Colour` or `Material`. The types define which fields can read them

## When to use one

- The same value is typed into **two or more fields**
- Several fields should **change together** when something happens
- You want a block that is **easy to restyle** later, by you or by someone you share it with

## When not to

- The value is used **once**
- The value comes straight from the game with no changes - bind the field to a `Data Source`
- The value drives a bar's colour by how full it is - use `Thresholds` instead

## Good t o know

- Variables belong to **one block** (Ver 1.9.3). A node that reads one cannot be moved to another block until the variables are copied over
- Variables run **top to bottom**. One can read those above it, never those below
- A field or variable reading a `Colour` variable has an **Opacity** box beside the picker. It fades the colour for that one reader (50% of a fully opaque colour draws at half) and leaves the variable alone, so one theme colour can feed its softer shades
- A block holds up to **20** variables, and a `Cases` variable up to **12** cases
- Once many fields read a variable it is hard to untangle. Name them well from the start

See [Variables UI](../ui/variables_ui.md) for how to navigate the UI
