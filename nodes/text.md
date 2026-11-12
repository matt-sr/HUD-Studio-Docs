A text node draws a string. It can be a fixed label, a value read from a data source, or several pieces joined into one line: `120 / 150`, `x3`, a player's name and class icon.

## Fields

| Field         | What it does                                                                |
| ------------- | --------------------------------------------------------------------------- |
| Text          | the string, in `Single` or `Chain` mode                                     |
| Size          | the box the text wraps within, in design px. Default 160 x 22               |
| Color         | the letters. Default white                                                  |
| Backing color | a plate behind each line, like the game's subtitles. Unset draws none       |
| Font          | the typeface: a game font, or `Custom` for your own                         |
| Font size     | 4 .. 240. Default 22                                                        |
| Shadow        | a drop shadow behind the letters                                            |
| Shadow color  | `Engine`, `Text color` or `Static`. See [Shadow color](#shadow-color) below |
| Shrink to Fit | shrink the font until the text fits the box's width                         |
| Alignment     | the point of the box the text anchors to                                    |
| Flip          | mirror the text horizontally, vertically or both                            |
| Rotation      | degrees clockwise, about the box's centre                                   |

An empty string draws nothing.

## Size and wrapping

Text wraps onto a new line when it runs past the box's width. The height only bounds where Alignment places it. Drag the corner to resize the box like a rectangle.

_Shrink to Fit_ steps the font down instead of wrapping, so a long name stays on one line. Static text is fitted once; changing text is fitted again on every distinct value.

## Alignment

Nine anchors in a 3 x 3 grid. The anchor is the point that stays put as the text grows.

- Left-anchored text grows to the right.
- Right-anchored text grows to the left, so the right edge stays put.
- Centred text grows both ways.

A counter like `9 / 150` set to _Top-right_ keeps the `/ 150` still while the number widens.

Rotated or flipped text ignores Alignment.

## Single and Chain

`Single` is one value. Set it to `Static` for a label, `Data Source` for a live value, or `Code`.

`Chain` joins up to 10 segments into one string. Each segment is its own text value with the same modes, so a static `/` between two data sources is just three segments:

| Segment | Mode        | Value               |
| ------- | ----------- | ------------------- |
| 1       | Data Source | `status.health`     |
| 2       | Static      | `/`                 |
| 3       | Data Source | `status.health_max` |

The chain's button opens the _Text Chain Editor_, where each segment has:

| Option         | What it does                                                    |
| -------------- | --------------------------------------------------------------- |
| Visible if     | hide the segment by a condition                                 |
| Prefix, Suffix | text around the segment, dropped with it when it is empty       |
| Separator      | text after the segment, drawn only when another segment follows |
| Hide when zero | a 0 hides the segment the way an empty value does               |
| Decimals       | decimal places for a number                                     |
| Color          | `Node Color`, `Custom`, `Data Source`, `Code` or `Thresholds`   |
| Size %         | percent of the node's font size                                 |

Segments can be added, removed and moved there. _COPY_ and _PASTE_ move a whole chain between nodes.

## Backing

_Backing color_ draws one plate per wrapped line, each as wide as the text on it. A word carried onto a second line gets a short plate under just that word.

An alpha of 2 or less counts as unset, so a backing faded out by a binding stops costing anything.

## Shadow color

- `Engine` is the game's own dark shadow.
- `Text color` follows the text's color, so thresholds and bindings on Color carry over. _Lightness_ is a percent of that color: 100 is the same color, 0 is black, 200 is twice as bright (up to 400). _Opacity_ is a percent of the text's.
- `Static` is one color you pick. It still fades with the text.

Lightness multiplies each color channel, so black text stays black at any value, and a bright color shifts toward white as its channels reach full. Per-segment colors don't carry into the shadow: the whole string uses the node's Color.

Rotated or flipped text has no shadow.

## Fonts

_Font_ lists the game's fonts. Its `Custom` mode loads a `.slug` font file from your assets folder (or a mod's) instead; the default font draws until it has loaded.

## Performance

- _Shadow_ effectively draws the text twice. The cost grows with the number of letters on screen. `Text color` and `Static` cost about the same as `Engine` until the text or its color changes.
- _Backing color_ and _Shrink to Fit_ measure the text. Static text is measured once; a timer is measured and cached again on every change.
- Per-segment color and size cost a little more than plain text.

## Scripting

Text, Color, Backing color, Font size, Size, Shadow, Shrink to Fit, Alignment, Flip and Rotation take a `Code` mode. Font is `Static` or `Custom` only, and the shadow's color settings are `Static` only. See [Node Scripts](../scripting/node_scripts.md) for the rules.

```lua
-- Text field: ammo as "12 / 30"
local ammo_left = my.equipment.ammo_mag_remaining
local ammo_max = my.equipment.ammo_mag_max
text = ammo_left .. " / " .. ammo_max -- likely better done via text chain mode
```

```lua
-- Text field: reload countdown with one decimal, hidden while not reloading
local seconds = my.equipment.reload_time_remaining_seconds
text = seconds > 0 and string.format("%.1f", seconds) or ""
```

```lua
-- Font size field: pop up to 30 when the health number changes, then settle at 22
local health_changed = anim.changed(state, "hp", my.status.health)
local seconds = anim.play(state, "pop", health_changed)
local pop = seconds >= 0 and 1 - anim.window(seconds, 0, 0.3, "out_quad") or 0
font_size = 22 + (8 * pop)
```

```lua
-- Alignment field: right-align on the right half of the screen
local screen_x = block.get_value("screen_dir")
align = screen_x > 0 and "top_right" or "top_left"
```

Alignment takes `top_left`, `top_center`, `top_right`, `center_left`, `center_center`, `center_right`, `bottom_left`, `bottom_center` or `bottom_right`. Anything else draws as `top_left`.
