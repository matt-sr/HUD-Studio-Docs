`Opacity` sets how see-through a block or node is. 1 is fully shown, 0 is invisible. It sits in the `Visibility` section, under `Visible`.

| On      | Does                                        |
| ------- | ------------------------------------------- |
| a block | multiplies the opacity of every node inside |
| a node  | multiplies that node's own color            |

A node at 0.5 in a block at 0.5 draws at 0.25.

## Modes

| Mode         | Its value is                                 |
| ------------ | -------------------------------------------- |
| `Static`     | a number from 0 to 1, in steps of 0.05       |
| `Thresholds` | a number picked by how full a value is       |
| `Variable`   | a number variable                            |
| `Code`       | what a short Lua script assigns to `opacity` |

There is no `Data Source` mode. A game value is rarely a 0 .. 1 alpha, so turn it into one with `Thresholds` or `Code`.

## Thresholds

Each band holds an opacity instead of a color. Pick the scale on the Threshold Designer:

| Scale          | Bands are picked by                       |
| -------------- | ----------------------------------------- |
| `Number`       | the raw value                             |
| `Percentage`   | the value as a percent of `Max`           |
| `True / False` | whether the value is true, false or unset |

Opacity bands always step from one to the next. There is no `Behaviour` dropdown: the change is timed by `Fade In` and `Fade Out` instead.

On the `True / False` scale, `Linger` and `Delay` hold the **True** row. See [Linger & Delay](../scripting/linger_delay.md).

## Code

```lua
-- a node's Opacity, Code mode: dim to 30% while sprinting
opacity = my.state.sprinting and 0.3 or 1
```

Leave `opacity` nil and the field uses its static value. A value below 0 counts as 0, above 1 as 1. Anything that is not a number counts as 1.

## How it changes

Opacity moves at the same speeds as the fades on the _Timing_ card. Rising uses `Fade In`, falling uses `Fade Out`. With both at 0 it snaps.

The first value after loading snaps, so nothing fades in when a document loads.

See [Fade in-out](../scripting/fades.md).

## Opacity and Visible

- `Visible` off hides the block or node. Its node scripts stop.
- `Opacity` at 0 also hides it, but it still updates.

Prefer `Visible` for hiding, since an element at 0 opacity still updates.

## Good to know

- `Static` opacity costs nothing per update.
- A block's opacity runs first, before its script and visibility.
- A field reading a `Color` variable has its own `Opacity` box. It fades that color for that field only, and has nothing to do with this field.
- A text shadow, and a progress bar's Background or Fill Shadow in `Fill color` mode, has its own `Opacity` %. It multiplies with this one: 0.5 here and 50% there gives 25%.
