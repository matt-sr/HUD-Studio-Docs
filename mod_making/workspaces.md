A **mod workspace** holds the blocks of one mod you export to. **My workspace** holds the blocks you save for yourself.

## Making one

In the Block Library, under **Workspaces**, press **+ New** and fill in:

- **Mod ID**: the mod's folder name. Letters, digits, `_` and `-` only.
- **Mod Name** and **Author**: shown to users in the Block Library.

What happens next depends on the Mod ID:

- **No such mod**: HUD Studio creates the mod, registration included, and adds it to `mod_load_order.txt`. Restart the game to load it.
- **The mod exists**: the workspace is added and the mod's existing files are not touched. If any blocks are registered in the mod, they will be copied into your workspace. The mod still needs the registration code: see [API Registration](api_registration.md).

Blocks always export to the `my_mod/hud_studio_blocks` folder inside the mod.

## Using one

There are two places to set a block or group's workspace (when the block or its nodes are selected):

- On the upper-right of the Properties Panel, as a dropdown
- In the Details tab of the Properties Panel, in the **Save To** dropdown

Clicking `Save` or `CTRL+S` will save the block or group to that workspace each time going forward.

**Good to know:** You can set the default workspace for any new blocks you create by navigating to the workspace in the Block Library, and clicking the `star` next to the workspace's name.

In the library, each entry of a mod workspace has a chip:

- `NOT EXPORTED`: saved to the workspace, not yet in the mod.
- `CHANGED`: edited on the canvas since its last export.
- `IN SYNC`: the mod has the current version.

The workspace shows buttons to help manage it:

- **Export All**: exports every entry the mod does not have yet, raising each one's Version if it was changed.
- **Switch to Mod** (the person icon): opens the mod's own category, its blocks as a user sees them. The mod's category has a **Workspace** button to navigate back. Only you see it.
- **Organise**: lets you drag entries into a new order. The order saves when you let go. Grid view is recommended.
- **Manage**:
  - **Copy Registration Snippet**: the code an existing mod needs. If you created a mod with HUD Studio, you don't need this.
  - **Copy Install Instructions**: usage/installation instructions for HUD Studio mods, for your mod's Nexus description. Optional, but saves you explaining how to use the Block Library to those who never interacted with HUD Studio.
  - **Remove Workspace**: deletes nothing. Add the workspace again to keep using it.
