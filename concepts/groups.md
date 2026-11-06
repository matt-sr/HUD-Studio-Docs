A group collects blocks in the Blocks tree. Its blocks hide and show together, save to the Block Library as one entry, and can share variables.

A group draws nothing itself. It has no position, size or scale; each block in it keeps its own.

Groups of nodes inside a block are a different thing; see [Blocks Tree](blocks_tree.md).

## Making a group

- **Add Group** on the Blocks panel's bottom toolbar adds an empty one.
- Drag a block row onto the group's rows to file it in. Drag it out above or below the group to take it back out.
- With a group selected, **Add Block** (or **Insert > Block** on its right-click menu) adds the new block inside it.

A block belongs to one group at most. Groups do not nest.

Double-click the group's row to rename it.

## Order

The group's blocks sit together in the tree, under its row. The tree's order is the draw order: a row higher in the list draws over the rows below it.

- Drag the group's row to move the whole group, blocks and all.
- Drag a block within the group to restack it among the others.

Note that groups always draw on top of ungrouped blocks, and a group row cannot be dragged below ungrouped blocks in the [Blocks Tree](blocks_tree.md).

## Showing and hiding

The eye on the group's row switches every block in it off at once, in the editor and in game. Turning it back on returns each block to its own eye and visibility rules.

A hidden group's blocks run nothing.

## Variables

The group's **Properties** tab holds variables every block in it can read. One value is shared: change it on the group and every block picks it up.

| Where                   | How                                    |
| ----------------------- | -------------------------------------- |
| A field's Variable mode | pick the entry tagged `[G]`            |
| Code                    | `group_vars.<id>`                      |
| A block's own variables | tagged `[B]`, and only that block sees |

Group variables are Static values only.

```lua
-- Color field: every bar in the group uses the group's accent color,
-- and turns red below 30% health
local is_low = my.status.health_percent < 30
color = is_low and { 255, 255, 60, 60 } or group_vars.accent
```

A block moved out of the group stops seeing its variables. Fields that read them fall back to their own.

## The Block Library

**Save Group to Library** (right-click menu, or the **Details** tab) saves every block in the group as one entry. Adding that entry brings the whole group back, in the same order.

The Details tab holds the entry's workspace, description, tags and version.

## Groups from mods

A mod can ship a group:

- Its blocks stay in it. You cannot move one out, restack it, delete it alone or add another block.
- Each block's position, scale, eye and lock are still yours. Hide the ones you don't want.
- **Duplicate Group To Edit** swaps the group for your own copy, which you can change freely. The mod's group goes to Deleted Items, in one undo step.
- **Reset Group** puts it back to what the mod ships now.

## Deleting

**Delete Group** sends every block in it to Deleted Items, then removes the group. Undo brings both back.

**Duplicate Group** makes `<name> copy` directly above it, holding copies of every block.
