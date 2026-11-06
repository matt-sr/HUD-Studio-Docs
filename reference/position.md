Position is where a block or node sits on your screen. Blocks and nodes both have it.

## Blocks and nodes

| Position of | Measured from            | Units                                                |
| ----------- | ------------------------ | ---------------------------------------------------- |
| Block       | the centre of the screen | design px, times the HUD scale                       |
| Node        | its block's origin       | design px, times the HUD scale and the block's Scale |

A node's Position is its top-left corner. Move the block, and every node moves with it.

Design pixels are the HUD's own units: 1920 x 1080 on a 16:9 screen, scaled to your resolution. `+x` is right, `+y` is down.

## Setting it

- Drag the block or node on the canvas.
- Drag a move arrow gizmo to move along one axis only.
- Tap an arrow key to move the selection 1px. Hold it to keep moving.
- Type the numbers into `X` and `Y`. A node takes -10000 .. 10000.

For nodes in a `node group`, hold Shift, begin dragging, and release Shift to drag only that one node instead of the whole group.

Keep holding Shift to snap a node (or block) to screen guides.

Hold Shift with the arrow keys to nudge a grouped node by itself.

## Modes

Position has two modes: `Static` and `Code`.

`Static` is the `X` and `Y` above.

`Code` keeps `X` and `Y`, and adds a script on top. The script assigns `shift`, an offset added to the saved position _each update_. Dragging still edits the saved position. See [Animate Position](../scripting/animate_position.md).

```lua
-- a node's Position, Code mode: bob up and down by 3px, on a 2s cycle
setup({ my_shift = { 0, 0 } }) -- setup runs once, assigns to `state`
-- oscillate the Y only, -3px to 3px, every 2 seconds
my_shift[2] = anim.osc(2, -3, 3)
-- assign state.my_shift to the shift value
shift = state.my_shift
```

## Follow Camera and Follow Motion

A block's _Follow_ settings move it with camera rotation, crosshair or camera motion. They add to the block's position and its `shift`. See [Animate Position](../scripting/animate_position.md) for each setting.

## Mod blocks

A mod block's Position is yours to change. Drag it, or type new numbers. Its `Code`, if any, belongs to the author and keeps running on top.

A block added from the [Block Library](../concepts/block_library.md) lands near the same screen edge it was built against. After that it is a normal position. Set where it lands with `Screen Anchor` in _Export to Mod_.

## Good to know

- A rectangle whose Size is in `Screen` mode ignores its Position.
- Positions snap to whole pixels when drawn. A slow drift steps a pixel at a time.
- A block's Scale grows its nodes from the block's _Anchor_. The block's own Position does not change.
