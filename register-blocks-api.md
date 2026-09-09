# `hud_studio.register_blocks` - API reference

The API another mod calls to put its own HUD blocks in HUD Studio's Block Library, listed under
its own button in the left-hand column.

For the step-by-step "how do I ship my HUD as a mod" walkthrough, see
[sharing-hud-as-mod-api.md](sharing-hud-as-mod-api.md). This page is the reference for fields,
limits, and what HUD Studio does with what you give it.

A registered block is a **template the user copies onto their canvas**. HUD Studio does
not render your block on your behalf, and it does not read your file until the user selects that
entry in the panel. Nothing is drawn, loaded or run at registration time.

---

## Quick start

```lua
local mod = get_mod("my_dps_mod")

function mod.on_all_mods_loaded()
    local hud_studio = get_mod("hud_studio")
    if not hud_studio then
        return -- HUD Studio is not installed; nothing to register with
    end

    hud_studio.register_blocks(mod, {
        author = "malevhf",
        blocks = {
            "scripts/mods/my_dps_mod/blocks/dps_display",
        },
    })
end
```

An entry is just the path to a block file. Everything else about it: its label, summary, version,
requirements. You author in HUD Studio's **Export to Mod** section, and it is read back out of the
file.

---

## `hud_studio.register_blocks(owner_mod, manifest)`

| Parameter   | Type       | Notes                                                                                                    |
| ----------- | ---------- | -------------------------------------------------------------------------------------------------------- |
| `owner_mod` | `DMFMod`   | **Your mod instance** - `get_mod("my_dps_mod")` Passing anything else logs an error and returns `false`. |
| `manifest`  | `string[]` | See below. Must contain an array of paths to pointing at your block files (.lua excluded)                |

**Returns** `boolean` - `true` when the manifest was accepted. A `false` return always has a
matching line in the mod log naming your mod ID and what went wrong.

### Manifest

| Key      | Type       | Default     | Notes                                                                                   |
| -------- | ---------- | ----------- | --------------------------------------------------------------------------------------- |
| `blocks` | `string[]` | -           | **Required.** The entries: block file paths.                                            |
| `label`  | `string`   | your mod ID | The face of your button in the left-hand column, and the heading above the grid.        |
| `author` | `string`   | `"?"`       | Shown under that heading, and on every one of your blocks in the user's Property panel. |

### Entry

An entry is a **path string**, without the `.lua` extension, relative to your own mod folder:

```lua
blocks = {
    "scripts/mods/my_dps_mod/blocks/dps_display",
    "scripts/mods/my_dps_mod/blocks/dps_bar",
}
```

The block's own metadata is read out of the file at that path. You set all of it in HUD Studio's
**Export to Mod** section and re-export.

| Read from the block file | Type       | Default | Notes                                                                                                                              |
| ------------------------ | ---------- | ------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| `label`                  | `string`   | -       | **Required.** The grid button's face and the details pane's title. A file without one is dropped with an error line.               |
| `summary`                | `string`   | none    | One or two sentences: what the block shows, and anything the user should know before adding it.                                    |
| `mod_version`            | `integer`  | `1`     | Your content version for this block. Bump it when you update, to offer users an update. See [Versioning](#versioning-and-updates). |
| `requires`               | `string[]` | `{}`    | Other mod IDs this block's code reads from. See [Requirements](#requirements).                                                     |
| `tags`                   | `string[]` | `{}`    | Accepted and stored, **not displayed** in v1 of the API. See [Tags](#tags).                                                        |

---

## Paths

A path is resolved as `<your mod id>/<path>`, so it can only ever reach inside your own mod folder.

```lua
"scripts/mods/my_dps_mod/My_Dps_Widget"        -- intended syntax
"scripts/mods/my_dps_mod/My_Dps_Widget.lua"    -- trailing .lua is stripped
"scripts/mods/my_dps_mod\\My_Dps_Widget"      -- backslashes are converted
```

An entry whose path fails this is dropped with a log line naming your mod and the entry's position in the array; the rest of your entries still register.

---

## Limits

Applied when you register, so one mod cannot break the panel's layout for every other:

| Limit                              | Value     | If broken                                 |
| ---------------------------------- | --------- | ----------------------------------------- |
| Entries per mod                    | 64        | The rest are dropped, with a log line.    |
| `label` length                     | 48 chars  | Silently truncated.                       |
| Manifest `label` / `author` length | 48 chars  | Silently truncated.                       |
| `summary` length                   | 600 chars | Silently truncated. Colour markup counts. |

---

## When to call it

**From `on_all_mods_loaded`.** DMF fires that event only once every mod has loaded, so load order
stops mattering and `get_mod("hud_studio")` cannot be nil (unless it is not installed).

Your registration is stored on **your** mod instance, and HUD Studio discovers it by walking DMF's
mod list. A mod the user has **switched off** in the mod options is skipped.

---

## The block files

Do **not** hand-write these, and do not copy them out of `%appdata%\Fatshark\Darktide\hud_studio\blocks\`.
Build the block in the editor, open the Block panel's **Export to Mod** section, fill in the fields, type your mod's id into **Mod Name** and press **Export**.

The block is written to
`mods\<your_mod>\scripts\mods\<your_mod>\<name>.lua` (and saved to your own library at the same time),
and the editor echoes the exact `file` path to put in your manifest.

HUD Studio re-reads every registered block file each time the user opens the Block Library, so a re-export lands in the panel on the next open. You do not have to restart the game or reload your mod to see a changed label, summary or version; only _adding_ or _removing_ a path from the `blocks` list needs your `register_blocks` call to run again.

### Single block

The saved file returns one block record: `name`, `label`, `nodes`, and whatever else the block
carries. Nothing in it needs editing by hand.

### Folder bundles (not yet)

**Folder bundles cannot be registered in this release.**

To ship several related blocks, register them as **separate entries** with a shared prefix in their
labels. They appear in your button's grid in the order you list them.

```lua
blocks = {
    "scripts/mods/my_dps_mod/blocks/dps_bar",
    "scripts/mods/my_dps_mod/blocks/dps_text",
}
```

Shipping a folder as one file is intended for a later release, once updating, dragging and
duplicating a shipped folder behave properly in the editor.

---

## Versioning and updates

Each entry carries a `version` (a whole number, `1` if you leave it out). Every copy on a user's
canvas remembers the version it was taken at.

When your entry reads **higher** than a copy on the user's canvas, the details pane grows an
**Update N on Canvas** button beside Add. Pressing it replaces those blocks' content in place:

| Replaced                               | Kept                 |
| -------------------------------------- | -------------------- |
| every node, every field, every binding | canvas position      |
| the block's label                      | block zoom           |
|                                        | Z order              |
|                                        | folder membership    |
|                                        | the eye / visibility |

So bump `version` whenever you ship a changed block, and leave it alone when you have not.

One thing to know: **updates are the user's choice.**

---

## Requirements

If your block's code reaches into another mod - `get_mod("true_level")` and the like - declare it:

```lua
"scripts/mods/my_mod/blocks/true_level_name"   -- with requires = { "true_level" } set in the file
```

Listing your **own** mod id is worth doing when the block is useless without you: a
copy on the user's canvas then switches itself off with a stated reason if they remove your mod,
instead of quietly drawing its fallback values. **Nothing adds it for you.**

What HUD Studio does with it:

- **Before the insert.** The details pane shows `Needs: true_level`, and `Needs (not installed):
true_level` in amber when the user does not have it. The Add button still works (they may be
  about to install it.)
- **After the insert.** A copy on the canvas whose requirements are not met is **switched off**: it
  draws nothing, runs no script and evaluates no binding, its row in the Blocks tree is flagged, and
  its Property panel names the missing mod and says the block comes back on its own once it is
  installed.

---

## Tags

`tags` is accepted and stored, but **not shown** in this version. The field is kept so a future version can surface them without
changing your manifest.

---

## What the user can do with your block

Ownership splits between the mod author and the user: **you shipped a thing, they are arranging it.**

| Refused edits                           | Allowed edits                 |
| --------------------------------------- | ----------------------------- |
| nodes: add, delete, reorder             | canvas position               |
| every node field, binding and condition | block zoom                    |
| node labels                             | Z order in the Blocks tree    |
| the block's label / rename              | folder membership             |
| the block's identity (`origin`)         | the eye / visibility          |
|                                         | deleting it from their canvas |

Users can introduce their own tweaks (with the trade-offs being told up-front) by duplicating your block.
The duplicate is an ordinary block of theirs, fully editable, with your owndership dropped and no
longer tracking your updates.

---

## Not supported

- **Live rendering of your blocks.** Registered blocks are templates the user copies; HUD Studio
  never draws one on your behalf, from within your mod folder. This also means, in theory, if your mod is not a dependency on your HUD elements, users can uninstall your mod after adding your mod's HUD blocks (though they can't re-add them from the library without your mod beign installed.)
- **Folder bundles** (`kind = "folder"`) - rejected at registration for now, see
  [Folder bundles](#folder-bundles-not-yet).
- **Tag categories.** Tags are not supported yet. (see [Tags](#tags)).
- **Registering data sources, node types or materials.** The manifest is namespaced (`blocks = {...}`),
  so these can be added later without changing the call signature.
- **Installing a `requires` mod for the user.** Declaring it is the whole of the contract.
