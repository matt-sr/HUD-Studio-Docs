A node is one thing drawn on screen: a rectangle, a line of text or a progress bar. Nodes live inside a block, which places, shows and hides them together.

## The node types

| Type           | Draws                                                  | Use it for                       |
| -------------- | ------------------------------------------------------ | -------------------------------- |
| `Rectangle`    | a solid color, a game material, or your own image file | backgrounds, icons, dividers     |
| `Text`         | a string, from one value or a chain of several         | names, numbers, labels           |
| `Progress Bar` | a value against its max, straight or curved            | health, stamina, ammo, cooldowns |

Each type has its own page under _Nodes_.

## Fields

Everything a node draws comes from its fields: its `Position`, `Size`, `Color`, `Text`, and so on.

Each field has a mode. The mode decides where its value comes from.

| Mode         | Its value is                                                       |
| ------------ | ------------------------------------------------------------------ |
| `Static`     | what you type or pick                                              |
| `Source`     | a value read from the game: a `Data Source`, `Signal` or `Control` |
| `Thresholds` | a color or number chosen by how full a value is                    |
| `Conditions` | true or false, built from a list of rules                          |
| `Variable`   | one of the block's or block group's variables                      |
| `Code`       | what a short Lua script assigns                                    |

Not every field offers every mode. A field only lists the modes that make sense for it.

See [Fields](fields.md) and [Field Types](../reference/field_types.md) for the full rules.

## Sections

| Section      | Holds                                                                           |
| ------------ | ------------------------------------------------------------------------------- |
| filters      | `Gamemodes` and `Classes`, the same strip a block has                           |
| `Visibility` | `Quick Conditions`, `Visible`, `Opacity`, and its fades once it can hide        |
| `Style`      | `Position`, `Size`, `Color` and the type's other looks                          |
| `Value`      | what it shows: a rectangle's material, a text's string, a bar's current and max |

The cycler in the corner of the tab strip is the node's `Update Rate`. See [Concepts > Rates](rates.md).

## Position and size

A node's `Position` is _relative to its block_. Drag the node on the canvas to set it, or type X / Y. The X / Y of a node _does not correlate to its screen position_.

- Moving the block moves every node in it.
- The block's `Scale` resizes every node together, so a node's own `Size` stays as authored.
- `Position` in `Code` mode adds a `shift` on top of the saved position, an offset relative to its X / Y.

```lua
-- a node's Position, Code mode: slide 20px right while reloading
setup({ reload_shift = {20, 0} }) -- setup runs once, assigns to `state`
if my.equipment.is_reloading then
    shift = state.reload_shift
end
```

## Visibility

A node is drawn only while its block is drawn and every one of its own checks passes.

| Check              | Hides the node while               |
| ------------------ | ---------------------------------- |
| Eye                | it is off, in the Blocks tree      |
| `Gamemodes`        | the current gamemode is not ticked |
| `Classes`          | your class is not ticked           |
| `Quick Conditions` | a ticked player state is not true  |
| `Visible`          | its rule says false                |

To hide a whole element, set the rule on the block. Set it on a node only when that part should come and go on its own, such as a "LOW" label under a health bar.

```lua
-- a text node's Visible field, Code mode: only while health is low
visible = my.status.health_percent < 30
```

## Draw order

Nodes draw bottom to top as the Blocks tree lists them. The node at the top of the list draws in front.

A backing rectangle goes below the text that sits on it in the tree.

## Update rate

A node only works out its fields again when it updates. Left on `Automatic`, it picks a rate from what it does:

| Rate          | Picked when the node                                                    |
| ------------- | ----------------------------------------------------------------------- |
| _Data_        | only reads game values                                                  |
| _Animation_   | has a `Code` field, reads a `Code` variable, or has smooth `Thresholds` |
| _Every frame_ | is set to `Frame`                                                       |

A `setup` in the node's code can ask for a rate of its own. The Hz behind _Data_ and _Animation_ come from the mod's settings.

A slower rate costs less. Set one yourself only when `Automatic` gets it wrong. The block's `Max Update Rate` caps every node in it.

If using `Code` mode on a field that would otherwise be fine on the `Data` rate, e.g. the `Text` value of a text node, it's always a good idea to change the rate to `Data` to save performance.

The engine knows when nodes are static and will skip evaluating them (no dynamic value, position, visibility or style changes), even if the rate cycler states `Automatic [30Hz]`

## Node scripts

A field in `Code` mode is a node script. The `Style` section also has a style script that runs after every other field and can override any of them.

See [Node Scripts](../scripting/node_scripts.md).

## Good to know

- A node hidden by its `Visible` rule still runs its `visible` script, so it can tell when to come back. Its other fields stop until it shows.
- A node hidden by its eye, a filter or a quick condition runs none of its scripts.
- A node reading a block variable cannot be moved to another block until that variable is copied over.
- Nodes inside a mod block are frozen. `Duplicate To Edit` on the block makes them yours.
