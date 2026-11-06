A block's **Dependencies** are the mods it needs to work. If a user is missing one, the block switches off instead of drawing broken.

Dependencies are only relevant to mod workspaces. Blocks saved to My Workspace will not see this field, as dependencies are managed at your own discretion.

## Setting them

Save the block to a mod [workspace](workspaces.md). Open its entry in the Block Library and press **Edit**.

Type the mod IDs into **Dependencies**, comma separated:

```
cool_kill_tracker, epic_dps_counter
```

- A mod ID is almost always the mod's folder name, not its display name. Case matters.
- Up to 24 IDs, 48 characters each.
- A group lists Dependencies once per block. The group needs every mod its blocks name.

Press **Save**, then export: see [Exporting](exporting.md).

## What to list

List every mod your block's code reads from. A block reading another mod's data gets nothing back when that mod is gone.

List your own mod when the block is useless without it. A user's copy stays on their canvas after your mod is uninstalled.

### Added for you

Export adds some on its own:

- `SimpleAssets`, for a block that draws images or custom fonts.
- `SimpleAudio`, for a block whose events play sounds.
- Any mod whose assets or audio folder the block points at.

Each export adds these to your own list.

## What users see

The check runs when the user adds the block, and again every time the game loads.

- The Block Library's details pane lists the mods under **REQUIREMENTS**. A missing one shows as `[MISSING]`.
- A block with a missing mod draws nothing. Its row in the Blocks tree turns red.
- Its form shows **Needs**, with the missing mods named.

A mod that is installed but disabled counts as missing. Once the user installs or enables it, the block switches back on at the next game start.

## What you see

If a block is saved to a mod workspace, and a dependency is missing on the canvas, interaction will not be blocked; instead, a missing dependency will flag as a **script error**, with the `Blocks Tree` eye turning red.

The error will inform you of which mod is missing.

## Good to know

- The list is copied onto each user's copy. It keeps working after the mod that shipped the block is gone.
- A block saved from a mod's block keeps its Dependencies.
- A wrong ID always counts as missing. Check the spelling against the mod's folder.
