The Block Library holds saved blocks and groups, both your own and those from other mods. Adding an entry puts a copy on your canvas.

Open it with the **Library** button at the top-left of the Blocks panel.

## Workspaces and mods

The **Workspaces & Mods** button on the filter row opens the sidebar. Its sections:

- **All**: every entry, from every source.
- **Workspaces**: where your own saves go. **My workspace** is the default. A mod's workspace holds the blocks you intend to export into a mod; see [Workspaces](../mod_making/workspaces.md).
- **Mods**: the entries each installed mod registers with HUD Studio. The HUD Studio category holds recreations of vanilla HUD elements, and a few examples.

The HUD Studio entries can be hidden with **Show HUD Studio Library** in the mod settings.

## Finding an entry

- The tag dropdown shows only entries with that tag.
- **Rows** / **Grid** switches the list. Grid shows each entry's preview image.

Previews need SimpleAssets v2.0. Without it the grid shows a `No Previews: Install SimpleAssets v2.0` chip.

## The details pane

Select an entry to see it on the right:

| Section      | Shows                                                        |
| ------------ | ------------------------------------------------------------ |
| Title        | the entry's name                                             |
| Description  | its summary and preview                                      |
| Tags         | what the tag filter finds it by                              |
| Meta         | node or block count, rates, what it reads, when it was saved |
| Requirements | the mods it needs; a missing one shows as `[MISSING]`        |

## Adding to the canvas

1. Pick a player under **Read from**: `You`, `Player 2` to `4`, or `SP` for the spectated player.
2. Press **Add to Canvas** (**Add Group to Canvas** for a group).

**Read from** points the block's data at another party slot. A health bar built for you becomes a teammate's health bar. The buttons are disabled when the block reads no player.

A block added from a mod stays the mod's. You can move, zoom, hide and restack it in the Blocks Tree, but not edit it. To edit, duplicate it; see [Mod Blocks](mod_blocks.md).

## Saving to the library

- **Save Block to Library** or **Save Group to Library** on the right-click menu.
- `Ctrl + S` with the selection in the Blocks tree.
- The save button on the Properties panel's side toolbar.

The entry's name, summary, tags and workspace live on the block's **Details** tab. Saving under a name that already exists asks to overwrite it.

After a save the library opens on the new entry. Turn this off with **Open Library On Save** in the mod settings.

A saved block changed on the canvas shows `UNSAVED CHANGES`. Save again to update the entry.

Saving a mod's block makes a copy in My workspace. The copy is yours, with your variable values baked in. _It no longer updates with the mod_.

## Editing an entry

Press **Edit** in the details pane. Saving the edit also updates your blocks on the canvas that were saved to this entry.

**Take Screenshot** sets the entry's preview. The editor hides; drag a box around the block. `Escape` cancels.

## Updates

When a mod ships a newer version of a block, your copies can follow it. Each mod's banner has a **Keep Updated** box, on by default:

- **On**: your copies update the next time the game starts.
- **Off**: the details pane shows **Update all on your Canvas** with the number of old copies.

An update keeps where you placed the block, its zoom, Z order, group, eye and Max Update Rate.

## Ordering

**Organise** on a workspace's banner lets you drag entries into a new order. The order saves when you let go.

## Deleting

The delete button opens a one-line menu: `Delete? NO UNDO!`. Deleting an entry cannot be undone as it deletes the file. Blocks already on your canvas are kept.
