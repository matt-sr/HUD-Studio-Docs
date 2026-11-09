The Blocks tree is the list in the Blocks panel. It holds every group, block and node in your HUD, and their order (bottom-to-top) is the order they draw in.

## Rows

| Row               | What it is                                                 |
| ----------------- | ---------------------------------------------------------- |
| Group             | a [Group](../concepts/groups.md), with its blocks under it |
| Block             | a block; its caret folds its nodes away                    |
| Node              | a text, rect or progress bar inside the block above it     |
| Deleted Nodes (n) | a block's deleted nodes, folded under the block            |
| Deleted Items     | deleted blocks, at the bottom of the tree                  |

A mod's block is always folded, since its nodes cannot be edited.

| Chip        | Means                                                                          |
| ----------- | ------------------------------------------------------------------------------ |
| `[MOD]`     | shipped by a mod, read only. Hover it for the mod's name. Duplicate it to edit |
| `[HIDDEN]`  | hidden right now, while **Toggle Hidden** keeps hidden blocks off the canvas   |
| `[DELETED]` | in Deleted Items. Right-click to restore or delete for good                    |

## Order

A row higher in the list draws over the rows below it. Inside a block, the top node draws on top.

Drag a row to move it:

- A block moves between other blocks, and into or out of a group.
- A node moves within its block, or into another block.
- A group moves with all of its blocks.

The right-click menu's Z order strip does the same in steps: **Bring Forward**, **Bring to Front** (row moves up), **Send Backward**, **Send to Back** (row moves down).

## Selecting

- **Ctrl + click** adds or removes a row from the selection. A selection is all blocks, or all nodes of one block, never both.
- **Select one row, then Shift + click another** selects the clicked rows and any in-between. The same rule applies - either blocks or nodes.
- **Ctrl + A** selects everything in the same scope as the selection. Locked rows are skipped, unless `Ctrl + A` is clicked again.
- **Tab** goes from a node to its block, and from a block back to the node you last had selected in it.

The keyboard steps through the tree:

| Key        | Does                                   |
| ---------- | -------------------------------------- |
| `W` / `S`  | select the row above / below           |
| `Ctrl + W` | jump up a whole block or group at once |
| `A` / `D`  | fold / unfold the selected row         |

## Renaming

Double-click a row to rename it.

**Show IDs** on the side toolbar swaps the names for the ids saved on disk.

**! Note !** _Renaming a row will change its ID_. If any code references a node or block by ID, _that reference will break_.

## Showing and hiding

The eye on a block or node row is its visibility in the editor and in game.

| Eye     | Means                                                                                       |
| ------- | ------------------------------------------------------------------------------------------- |
| open    | shown. Click to hide                                                                        |
| closed  | hidden. Click to show                                                                       |
| dynamic | a condition, code, a data source or a filter decides each frame                             |
| forced  | a dynamic eye you overrode. Clicking goes force hidden, force shown, then back to automatic |
| red     | a script on it has an error. Hover for the message                                          |

A hidden group hides all its blocks, whatever their own eyes say.

The editor still draws hidden blocks, so you can work on them. **Toggle Hidden** on the top toolbar leaves them off the canvas instead.

Unlike dynamic conditions, which keep block scripts running even when hidden, toggling via the eye will stop _everything_, script included.

## Locking

The padlock keeps a block or node from being picked on the canvas: no hover, no click, no box select.

Select it from the tree and it works as normal again. Click the padlock, or press **Ctrl + L**, to unlock.

## Grouped nodes

Adjacent nodes in one block can be grouped. They move and resize together on the canvas, and drag together in the tree.

- **Ctrl + G** groups the selected nodes, or ungroups a group when all of it is selected.
- The chain badge marks a grouped node. Click it to ungroup.
- **Hold Shift, then click or drag** picks one member on its own: drag it out of the group, or nudge it on the canvas with Shift + arrows.
- Drop a node between two members of a group and it joins.

_These are not the same as block Groups_.

## Copy, duplicate, delete

| Key        | Does                                                                      |
| ---------- | ------------------------------------------------------------------------- |
| `Ctrl + C` | copy the selected block or node                                           |
| `Ctrl + V` | paste it                                                                  |
| `Ctrl + D` | duplicate the selection                                                   |
| `Delete`   | delete the selection                                                      |
| `Ctrl + S` | save the selection (block, group, or a node's block) to the Block Library |
| `Ctrl + Z` | undo; `Ctrl + Shift + Z` redoes                                           |

Over the tree, a paste lands next to the row under the cursor: above it on the row's upper half, below it on the lower half. A node pasted with no block under it becomes a block of its own.

Over a field, Ctrl + C and Ctrl + V copy the field's value instead. See [Properties Panel](properties_panel.md).

## Deleted items

Deleting a block moves it to Deleted Items, where it is kept but not drawn.

- Drag it back up the tree, or right-click **Restore Block**, to bring it back.
- **Delete Block Permanently**, or **Delete** again, removes it.
- Right-click Deleted Items for **Empty Trash**. This deletes the block files.

A deleted node goes to its block's **Deleted Nodes** bin, with the same Restore and Delete Permanently.

## Toolbars

| Where  | Buttons                                                                            |
| ------ | ---------------------------------------------------------------------------------- |
| Top    | Collapse / Expand All Blocks, Block Library, Toggle Hidden, Help, Profiler         |
| Bottom | Add Group, Add Block, one Add button per node type, Duplicate, Delete              |
| Side   | Code Editor, Toggle Vanilla Elements, Canvas Grid, Show IDs, Import / Export Files |

The node buttons need a block selected; the new node goes into it.
