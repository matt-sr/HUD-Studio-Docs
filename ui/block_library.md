This page covers the Block Library window. For what the library is and how saving works, see [Block Library](../concepts/block_library.md).

Open it with the **Library** button at the top-left of the Blocks panel.

## Layout

| Part         | Where    | Does                                            |
| ------------ | -------- | ----------------------------------------------- |
| Filter row   | top      | sidebar button, search, tag filter, Rows / Grid |
| Banner       | below it | the open category's name, author and buttons    |
| Entry list   | left     | the entries, as rows or tiles                   |
| Details pane | right    | the selected entry, and the Add buttons         |

## The filter row

- **Workspaces & Mods** opens the sidebar. Pick **All**, a workspace or a mod. Click outside the sidebar to close it.
- The tag dropdown shows only entries with one tag. **All tags** clears it.
- **Rows** / **Grid** switches the list. Grid shows each entry's preview.

Grid needs SimpleAssets v2.0. Without it you see `No Previews: Install SimpleAssets v2.0`.

## The banner

**My workspace** shows `by me!` and an **Organise** button.

**A mod** shows its name, its author, and a **Keep Updated** box. While Keep Updated is on, your copies of the mod's blocks update at the next start. If the mod is yours, **Workspace** jumps to the workspace it exports from.

**A mod workspace** (one you export from) has four buttons:

| Button     | Does                                                     |
| ---------- | -------------------------------------------------------- |
| person     | switch to the mod's own category; off until it registers |
| Manage     | edit the workspace, copy the registration snippet        |
| Organise   | drag entries into a new order                            |
| Export All | write every entry into the mod                           |

Its chips say where the workspace stands:

| Chip                       | Means                                           |
| -------------------------- | ----------------------------------------------- |
| `ALL IN-SYNC`              | everything is exported                          |
| `N TO EXPORT`              | N entries are new or changed since the export   |
| `N EDITED, NOT SAVED`      | N blocks on the canvas changed since their save |
| `NO AUTHOR`, `NO MOD NAME` | fill these in under **Manage**                  |

The line under the name can also read `Not loaded`, `Not registered`, or `Registered by hand`. See [Workspaces](../mod_making/workspaces.md) and [Exporting](../mod_making/exporting.md).

## The entry list

Entries in a mod workspace carry a chip:

| Chip              | Means                                          |
| ----------------- | ---------------------------------------------- |
| `IN SYNC`         | the mod has this version                       |
| `CHANGED`         | saved since the last export                    |
| `NOT EXPORTED`    | never exported                                 |
| `UNSAVED CHANGES` | the block on your canvas differs from the save |

### Organise

Press **Organise** on the banner, then drag entries up or down. The order saves when you let go.

## The details pane

| Section      | Shows                                                        |
| ------------ | ------------------------------------------------------------ |
| TITLE        | the entry's name                                             |
| DESCRIPTION  | its summary and preview                                      |
| TAGS         | its tags, or `None`                                          |
| META         | node or block count, rates, what it reads, when it was saved |
| REQUIREMENTS | the mods it needs; a missing one shows as `[MISSING]`        |

### Adding

1. Pick a player under **Read from**: `You`, `Player 2` to `4`, or `SP`.
2. Press **Add to Canvas**, or **Add Group to Canvas** for a group.

`SP` is the player you spectate, or you while alive. The Read from buttons are off when the block reads no player.

If some bindings could not follow Read from, the status says `added (N binding(s) not re-pointed)`. Those keep reading the original player.

### Your own entries

Entries you saved also get **Edit** and a delete button.

- Hover the details and click (`Click to Edit`), or press **Edit**.
- The delete button asks `Delete? NO UNDO!`. Blocks on your canvas are kept.

Mod entries have neither. Duplicate the block on the canvas to make your own; see [Mod Blocks](../concepts/mod_blocks.md).

## The edit form

Saving the edit also writes the changed fields onto your canvas blocks saved to this entry. A group's name stays as it is on the canvas. Press **Save** to keep the changes, or **Cancel Edit** to drop them.

| Field         | Sets                                                                |
| ------------- | ------------------------------------------------------------------- |
| Library Name  | the entry's title                                                   |
| Summary       | the description text                                                |
| Tags          | what the tag filter finds it by                                     |
| Dependencies  | mod IDs the block needs, comma separated                            |
| Screen Anchor | the screen edge the block lands near on other aspect ratios         |
| Read from     | the player Read from replaces; `Automatic` is the one it reads most |
| Offer         | which players a user can pick; untick all for `Not offered`         |
| User-editable | which variables a user can set                                      |
| Code Rebind   | which code follows Read from                                        |

A group lists Dependencies once per block and has no Screen Anchor.

**Code Rebind** options:

| Option              | Follows Read from        |
| ------------------- | ------------------------ |
| Bindings and script | everything               |
| Bindings only       | field bindings, not code |
| Script only         | code, not field bindings |
| Neither             | nothing                  |

Code that does not follow keeps reading the original player.

### Preview

- Click **Take Screenshot**. The editor hides; drag a box around the block. `Escape` cancels.

The preview shows under the description and in Grid. A workspace's export ships it with the block. The box's tooltip names the file, so you can also drop in an image by hand.
