A rectangle is a filled box. Give it a material and it becomes an image instead: the material is drawn at the rectangle's size, tinted by its color.

Both are the same node type, so a box can be given a material later.

## Fields

| Field          | What it does                                         |
| -------------- | ---------------------------------------------------- |
| Position       | where the top-left corner sits in the block          |
| Size           | width and height, in design px. Default 100 x 100    |
| Color          | the fill, or the material's tint. Default white      |
| Material       | the image to draw. Empty draws a plain color box     |
| Flip           | mirror the material horizontally, vertically or both |
| Clip           | keep only part of the material                       |
| Rotation       | degrees clockwise, -360 .. 360                       |
| Fallback       | a second material for when the first comes up empty  |
| Fallback color | the fallback material's tint                         |

A color with alpha 0 draws nothing at all, material included.

## Materials

The Material field opens the _Material Browser_. Pick a game material or texture, or switch the field to `Image` to use your own picture files (see [Custom Images](../tutorials/rect_image.md)).

A simple material costs almost nothing over a plain color. Animated and effect materials cost more the larger they are on screen.

An image or material that has not loaded yet draws nothing.

## Flip, Clip and Rotation

All three stack in a single draw.

- **Flip** mirrors the whole material, or the clipped part of it in place.
- **Clip** keeps a slice: _Keep left_, _Keep top-right_, _Keep center_, _Trim border_ and so on. The amount is the percent of the material kept. Corner and centre clips take a second, vertical percent.
- **Rotation** turns the material about the box's centre. The cyan square at the top-right of a selected node on the canvas drags it; hold Ctrl to snap to 15°. The handle only shows while Rotation is in `Static` mode.

## Fallback

A material bound to a data source can resolve to nothing: an empty weapon slot, a curio the player does not carry. With nothing set, the rectangle simply draws nothing that update.

Set _Fallback_ to draw a stand-in material instead, tinted by _Fallback color_ (unset uses the main color).

- Only offered while Material is in `Data Source` mode. A static or coded material never falls back (except to its static mode value)
- The fallback ignores Flip, Clip and Rotation. It draws square, at the node's own size and position.
- A fallback color without a fallback material draws nothing.

## Size modes

Besides the usual modes, Size has two extras on a rectangle.

**Screen** sizes the box as a percent of the screen, centred on it. It ignores the node's position, the block's scale and the HUD scale, so it suits full-screen tints and vignettes. The node cannot be dragged or resized on the canvas while in this mode.

**Code** gets an anchor dropdown beside it: the point of the box that stays put while your code changes the size.

```lua
-- Size field (anchor: Left): grow to the right as stamina fills
local stamina = my.status.stamina_percent / 100
size = { 200 * stamina, 12 }
```

## Scripting

Every field takes a `Code` mode. See [Node Scripts](../scripting/node_scripts.md) for the rules.

```lua
-- Color field: pulse red below 30% health
local is_low = my.status.health_percent < 30
local pulse = anim.osc(0.8, 0.4, 1)
color = is_low and { 255 * pulse, 255, 40, 40 } or { 255, 255, 255, 255 }
```

```lua
-- Rotation field: spin once every 2 seconds
rotation = (t % 2) / 2 * 360
```

A coded Clip returns a raw uv rect, `{ { u0, v0 }, { u1, v1 } }`, from 0 to 1:

```lua
-- Clip field: reveal the icon from the left as the ability recharges
local charged = my.ability.progress_percent_to_next_charge / 100
clip = { { 0, 0 }, { charged, 1 } }
```

Due to how uv works (stretching the remainder over the full width), you typically want to combine it with size.

A coded Material returns a material path, or a picture file through `simple_asset()`.
