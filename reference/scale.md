Scale grows or shrinks a whole block. Node positions, sizes, text and bars all change by one factor.

Scale is a block field. Nodes do not have it: to resize one node, change its Size.

## The fields

| Field  | What it does                                             |
| ------ | -------------------------------------------------------- |
| Factor | 1 is normal size, 2 is double. From 0.05 to 20           |
| Anchor | the point that holds still while the block grows/shrinks |

Scale multiplies the player's HUD scale slider.

## Setting it

- Type a number into `Factor`.
- Drag the scale handle of a selected block on the canvas. Right grows, left shrinks. Hold Ctrl to snap.

## The Anchor

| Anchor                  | Grows from                           |
| ----------------------- | ------------------------------------ |
| Origin                  | the block's own origin (the default) |
| Center                  | the middle of the block's content    |
| Top-left … Bottom-right | that edge or corner of the content   |

The content is the box around every node at its saved position and size.

**Leave it on Origin unless you animate Scale**. With any other Anchor, dragging a block whose Factor is not 1 will feel off.

## Modes

Scale has two modes: `Static` and `Code`.

`Static` is the Factor.

`Code` assigns `scale`, a number. It is never saved. Leave it nil, or let the script error, and the block uses its Factor. See [Animate Scale](../scripting/animate_scale.md).

```lua
-- Scale field: beat once a second below 30% health
local is_low = my.status.health_percent < 30
scale = is_low and anim.osc(1, 1, 1.08) or 1
```

## Mod blocks

A mod block's Factor is yours to change. Its Anchor is the author's and is not shown. If the author animates its Scale, the Factor is locked too.

## Good to know

- When working on mod blocks, always work from Scale Factor 1.
