A mod's blocks appear in the Block Library once the mod **registers** them with HUD Studio.

- A mod created from a [workspace](workspaces.md) already has the registration code.
- For a mod that already existed, open the Block Library, pick the mod's workspace, press **Manage**, then **Copy Registration Snippet**. Paste it at the **end** of the mod's script file.

## The snippet

```lua
-- This mod's blocks, exported from HUD Studio. The list is regenerated on every export.
-- Keep this at the end of the script: it wraps the on_all_mods_loaded set above it.
local on_all_mods_loaded = mod.on_all_mods_loaded
mod.on_all_mods_loaded = function(...)
	if on_all_mods_loaded then
		on_all_mods_loaded(...)
	end
	local hud_studio = get_mod("hud_studio")
	local blocks = hud_studio
		and hud_studio.register_blocks
		and mod:io_dofile("my_mod/hud_studio_blocks/hud_studio_blocks")
	if blocks then
		hud_studio.register_blocks(mod, blocks)
	end
end
```

What it does:

- It runs in `on_all_mods_loaded`, so the load order of your mod and HUD Studio does not matter.
- It calls the `on_all_mods_loaded` your script already set, then registers. **This is why it goes last**: a handler assigned after it would replace it.
- Without HUD Studio installed it does nothing.
- `mod:io_dofile(...)` loads the registration list, `hud_studio_blocks/hud_studio_blocks.lua` in your mod. HUD Studio rewrites this file on every export, so _do not edit it_.
- `register_blocks(mod, blocks)` takes your mod and that list. The list's `blocks` array holds one path per exported block or group.

Registering draws nothing. A registered block is a template the user copies onto their canvas from the library.

## Good to know

- A mod registers up to 64 entries. The rest are dropped.
- The registration list path is relative to your mod's folder, without `.lua`. It cannot reach outside your mod.
- An entry that cannot be used is dropped with a line in the mod log naming your mod and the entry. The other entries still register.
- After you export from the editor, paths added this way are missing from your library until the game restarts. Your users are not affected.
