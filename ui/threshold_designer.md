The Threshold Designer splits a value's range into bands. Each band gives its own color, or its own opacity. Use it for things like "red under 30%, yellow under 60%, green above".

Set a field to `Thresholds` mode, then click its control to open the Designer.

| Field type | Each band holds  |
| ---------- | ---------------- |
| color      | a color          |
| `Opacity`  | a number, 0 .. 1 |

## Sections

| Section          | Holds                                       |
| ---------------- | ------------------------------------------- |
| `Threshold Mode` | the scale: what the band numbers mean       |
| `Values`         | `Current` and `Max`, the value being tested |
| `Designer`       | `Behaviour`, the band bar and the band rows |

## Threshold Mode

| Scale          | Bands are picked by                       |
| -------------- | ----------------------------------------- |
| `Percentage`   | `Current` as a percent of `Max`           |
| `Number`       | `Current` itself. `Max` is hidden         |
| `True / False` | whether `Current` is true, false or unset |

`Percentage` is the default.

## Values

`Current` and `Max` take the usual modes: `Static`, `Data Source`, `Variable` and `Code`. On the `True / False` scale, `Current` reads a true or false value, and can also take `Conditions`.

A progress bar has a dropdown on the `Values` heading:

| Option   | Current and Max come from                               |
| -------- | ------------------------------------------------------- |
| `Node`   | the bar's own `Current` / `Max`, from its Value section |
| `Custom` | inputs set here                                         |

In `Node`, the boxes are read-only. Edit them in the node's Value section.

## Bands

Each row is one band. Its number is where the band starts.

- The band with the highest number at or under the value wins.
- A value under every band uses the lowest band.
- Numbers are not clamped. A band at 120% catches an overcharged value.
- Type a number in the blank row at the bottom to add a band.
- Clear a band's number to remove it. The trash button does the same for the selected band.
- Up to 16 bands.

On the `True / False` scale there are always three rows: **True**, **False** and **Unset**. Unset is a value the source has nothing for, such as an empty weapon slot. It is not the same as False.

## Colors

Click a band's swatch, or its segment on the bar, to select it. The RGBA row and the color picker beside the rows edit the selected band.

## Opacity bands

An opacity band has its own number box on the row instead of a swatch. 1 is fully shown, 0 is invisible. A band left blank counts as 1.

Opacity has no `Behaviour` and no `Preview`. It steps, and the change is timed by `Fade In` and `Fade Out`. See [Opacity](../reference/opacity.md).

## Behaviour

Colors only. Sets how one band gives way to the next.

| Behaviour  | Does                                              |
| ---------- | ------------------------------------------------- |
| `Step`     | snaps to the new color                            |
| `Smooth`   | snaps, with a short fade (a quarter of a second)  |
| `Gradient` | blends by value from one band's color to the next |

`Gradient` is not offered on the `True / False` scale. There is nothing between its states.

`Smooth` updates the node at the animation rate. See [Rates](../concepts/rates.md).

## Preview

`Preview` sweeps a fill back and forth across the bar, about one second per band. It shows the color the field resolves to at each point, with the current `Behaviour`. Click `Stop` to end it.

The preview ignores the real `Current` and `Max`.

## Good to know

- Switching scale keeps the bands. Their numbers just mean something else.
- For `Opacity` on the `True / False` scale, `Linger`/`Delay` hold the **True** row. See [Linger & Delay](../scripting/linger_delay.md).
