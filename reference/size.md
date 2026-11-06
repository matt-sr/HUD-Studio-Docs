Size is a node's width and height, in design px. Rectangles, progress bars and texts have it. Blocks do not: use the block's Scale instead.

## By node type

| Node         | Size is                                                    |
| ------------ | ---------------------------------------------------------- |
| Rectangle    | the box, or the material drawn in it. Default 100 x 100    |
| Progress bar | the whole bar, track included                              |
| Text         | the wrap box. Text wraps at its width and aligns inside it |

A text with no Size uses a wide default box. Its height on the canvas is the font size.

## Setting it

- Drag a corner of a selected node on the canvas.
- Drag a side handle gizmo to resize along one axis only.
- Type the numbers into `Width` and `Height`, from 0 to 4000.

Hold a key while dragging a corner to change how it resizes:

| Key   | Default               |
| ----- | --------------------- |
| Ctrl  | Resize As Square      |
| Shift | Maintain Aspect Ratio |
| Alt   | Grow From Centre      |

Change them in the mod settings. Holding several keys combines them. On a side handle, the key set by _Gizmo Resize: Grow Opposite Key_ grows the node from the opposite edge instead.

Resizing a group resizes every node in it.

## Modes

| Mode     | Rectangle | Progress bar | Text |
| -------- | --------- | ------------ | ---- |
| `Static` | yes       | yes          | yes  |
| `Code`   | yes       | yes          | yes  |
| `Screen` | yes       | no           | no   |

`Code` assigns `size`, a pair of numbers:

```lua
-- Size field: grow to the right as stamina fills
local stamina = my.status.stamina_percent / 100
size = { 200 * stamina, 12 }
```

On a rectangle and a progress bar, `Code` adds an anchor dropdown. The anchor is the point of the box that stays put while the size changes. Left grows to the right, Center grows both ways.

The canvas outline and handles stay on the static size. Only the drawn box changes.

## Screen

`Screen` sizes a rectangle to the whole screen, centred on it. It ignores the node's Position, the block's Scale and the HUD scale. Use it for full-screen tints and vignettes.

- The node cannot be picked, dragged or resized on the canvas.

## Good to know

- Size grows with the block's Scale and the HUD scale slider.
- Edges snap to whole pixels when drawn. Two nodes that share an edge meet on the same pixel.
- To animate Size smoothly, keep the value in `state` and ease it with `anim.approach`. See [anim](../scripting/anim.md).
