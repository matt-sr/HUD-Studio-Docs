The canvas is your screen while the editor is open. Blocks draw on it as they do in game, with outlines and handles drawn over them.

## Selecting

- Click a block to select it, then click one of its nodes to select that node.
- **Ctrl + click** adds or removes a block from the selection.
- Drag on empty canvas to draw a selection box.
- Where blocks overlap, scroll the wheel to step through the ones underneath.
- Click empty canvas to step back: from a node to its block, then to nothing. With **Single-Click Deselect** off in the mod options, each step takes two clicks.

Locked blocks and nodes cannot be picked on the canvas. Unlock them in the [Blocks Tree](../ui/blocks_tree.md).

## Dragging

Drag a block or node to move it. A block's nodes move with it. See [Position](../reference/position.md).

| Hold         | While dragging                        |
| ------------ | ------------------------------------- |
| `Alt`        | keep to a straight line               |
| `Ctrl`       | move at a third of the speed          |
| `Shift`      | snap edges or centre to a guide       |
| `Ctrl+Shift` | drag a copy off, leaving the original |

- The arrow keys nudge the selection 1 px. Hold one to repeat.
- **Escape** mid-drag puts it back.
- A mod block moves, but its nodes do not. See [Mod Blocks](mod_blocks.md).

## Resizing

Hover a selected node and drag its bottom-right corner. See [Size](../reference/size.md).

| Hold    | Default               |
| ------- | --------------------- |
| `Ctrl`  | resize as a square    |
| `Shift` | keep the aspect ratio |
| `Alt`   | grow from the centre  |

Each key's behaviour is set in the mod options. Hold several to combine them.

A node in a node group resizes the whole group. **Shift + click** the node first to resize it alone.

A selected block has a scale handle. Drag it right to grow, left to shrink. **Ctrl** snaps. See [Scale](../reference/scale.md).

## Rotation

A selected rectangle has a cyan square at its top-right. Drag it up or down to turn it. **Ctrl** snaps to 15°.

The handle only shows while Rotation is in `Static` mode. See [Rectangles](../nodes/rectangles.md).

## Gizmo

The selection shows arrows outside its corners. Each one drags one axis only.

- Top-left arrows move it along X or Y.
- Bottom-right arrows (nodes only) change width or height.
- Hold a modifier to slow the arrow down for fine nudges.
- Hold **Gizmo Resize: Grow Opposite Key** (mod options) to grow a node from its far edge.

## Guides

Guides are useful to line stuff up.

- The # **Guides** button on the Blocks panel's toolbar edits them in the [Properties Panel](../ui/properties_panel.md).
- Hold **Shift** while moving a block or node to snap it to the guides.
- **Generate** splits the screen into equal cells. **+ Add** adds one line.
  - Note this _replaces_ all existing guides on your screen (CTRL+Z to undo generating them)
- Each guide is a % of the screen. Its plates on the screen edges show the value.
- Drag a plate to move a guide (the line itself can't be grabbed). Click a plate to open the form.
  - Hold **Ctrl** while dragging to move it at a third of the speed.
  - Hold **Shift** while dragging to step it in 5 px intervals from where it started.
- Hover or drag a plate to see the px distance across every gap between that axis's guides, including the gaps to the screen edges.

## Context menu

Right-click the canvas to open a menu for what is under the cursor.

- **Empty canvas:** add a block.
- **Block:** add a node, edit scripts, visibility, lock, draw order, duplicate, delete and save to the [Block Library](block_library.md).
- **Node:** the same for the node, plus grouping with other nodes.
- **Mod block:** fewer rows, plus **Reset** to what the mod ships.

The keyboard shortcuts are listed in the [Blocks Tree](../ui/blocks_tree.md) article.
