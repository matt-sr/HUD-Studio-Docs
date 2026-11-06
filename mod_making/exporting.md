Exporting writes a block into your mod, where its users can add it from the Block Library. You need a [workspace](workspaces.md) for the mod first.

A user's canvas gets the block exactly as you exported it.

## Export a block

Select the block and open its **Details** tab:

- **Library Name**: the block's title and button label in the Block Library. Required.
- **Summary**: what the block shows, and anything to know before adding it.
- **Tags**: what the library's tag filter finds the block by.
- **Save To**: the mod's workspace.

Save it, then open its entry in the Block Library (the library button on the Property panel's side toolbar) and press `Edit`:

- **[Dependencies](dependencies.md)**: the IDs of the mods the block's code reads from, comma separated. A user missing one gets the block switched off, with the missing mod named. List your own mod when the block is useless without it: nothing adds it for you.
- **Screen Anchor**: the part of the screen the block belongs to, so it lands there on other aspect ratios.
- **Read from**, **Offer**, **Code**: which player the block reads, who a user can point it at, and which code is rebound.

Then press `Export All` on the workspace's card.

The block is written to `your_mod/hud_studio_blocks/<name>.lua` in your mod and the registration list beside it is regenerated. Do not write or edit these files by hand.

For mods managed by HUD Studio, a re-export shows the next time the Block Library is opened, without a restart. Manual registration snippets need to be manually updated and the exported entries will appear after a game restart or hot reload.

## Export a group

A group exports as **one** library entry, the same way. Dependencies stay on each block.

- A group holds up to 32 blocks.
- A group containing another mod's block cannot be exported.

## What users can change

A user arranges your block but cannot edit it:

| Allowed                   | Refused                           |
| ------------------------- | --------------------------------- |
| canvas position           | adding, deleting, moving nodes    |
| block zoom                | node fields, bindings, conditions |
| Z order, group membership | block and node labels             |
| the eye                   |                                   |
| Max Update Rate           |                                   |
| deleting it               |                                   |

Blocks of a shipped group stay in it, in your order. They are deleted and duplicated only as the entire group.

A user who wants to edit duplicates the block. The duplicate is theirs and no longer gets your updates.
