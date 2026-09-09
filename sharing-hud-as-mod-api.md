# How to share your HUD using HUD Studio (as your own mod)

HUD Studio supports registration of blocks made with HUD Studio as mods.

Below is a quick overview to give a general workflow idea, step-by-step is a bit further down.

## Quick overview:

1. Create a new mod using `Darktide Mod Builder`, or use an existing mod
2. In-game, create your elements in the HUD Studio editor
3. Once finalised, click on the block row and complete the **Export to Mod** section (See step-by-step)
4. Register the blocks by calling `hud_studio.register_blocks(mod, manifest)`

That's it! Once done, and both mods are installed, your mod will become a button on the left-side column inside the blocks library, with all the blocks you created inside it. Users will be free to add it to their canvas, and, if you decide to update your mod's HUD elements, will be able to update them too (as a manual step).

## Step-by-step instructions:

### 1. Create a new mod using `Darktide Mod Builder` (Or add to existing mod)

Follow this guide on how to create your own mods and how the file structure works: https://dmf-docs.darkti.de/#/creating-mods

### 2. In-game, create your elements in the HUD Studio editor

The layout and visual organisation part of this step is fairly self-explanatory, but there's some things to note if you are writing custom scripts - for this, see the `Creating HUD elements which consume information provided by your mod` section at the end before proceeding. If you are not writing any code and/or just sharing HUDs that use data sources, or your scripts use HUD Studio state only, then skip to step 3.

Bear in mind that whatever you save is **exactly** how a user of your mod will see it on their canvas.

### 3. Use the 'Export to mod' section at the bottom of the blocks panel

When you click into a block (in a later version, folders too), the bottom of the Properties panel will have a section on exporting your block to a mod. Here's what each field means:

#### Label

This is the title, and button label of the block in the block library.

#### Summary

A short description of what your block looks like or what it does.

#### Version

By default, each block starts at version 1. When you ship an update, bump this number up in order for users to see a 'Update on Canvas' button in the library.

Note: This is an opt-in on the user end. Just because users installed an updated version your mod does not mean each of your mod blocks on their canvas will also auto-update on next launch. Additionally, if users have duplicated your block, they exclude themselves from updates for those duplicated blocks (you are warned of this before duplicating).

See the API doc for more details.

#### Dependency Mods

If your mod reads from or otherwise requires other mods, then this is the place to declare those mods.

Users who are missing dependency mods will be able to add blocks to their canvas, but they will appear disabled with a message notifying them which mods they are missing, as declared here.

**This also applies to your own mod!** If your mods drives your HUD elements, you absolutely should list it in the dependencies- nothing will add it for you.

#### Tags

Currently unused in this version, but you should add them anyway so that an update to HUD Studio will not require you to update your block manifest with tags. See the API docs for details.

#### Mod Name + Save

The saved blocks must land somewhere- whether this is a new mod made with Darktide Mod Builder, or an existing mod.

**NOTE: This is the mod ID**, not the localized name. You will be prompted on the button whether you are overwriting existing files, if the mod does not exist, or if your mod name is missing.

Blocks land in the root directory of your mod. Feel free to move them afterwards. A later version will support defining the destination folder within your mod.

### 4. Register the file inside your mod script file

Your mod file structure should look something like this now, having exported two HUD elements "DPS Bar" and "DPS Display Widget"

```
my_dps_mod
└── scripts
    └── mods
        └── my_dps_mod
            ├──my_dps_mod.lua
            ├──my_dps_mod_localization.lua
            ├──my_dps_mod_data.lua
            ├──DPS_Bar.lua
            └──DPS_Display_Widget.lua
```

Inside `my_dps_mod.lua`, write:

```lua
local mod = get_mod("my_dps_mod")

-- registering after all mods have loaded ensures that load order does not matter.
mod.on_all_mods_loaded = function()

  -- grab the HUD Studio handle with get_mod
  local hud_studio = get_mod("hud_studio")

  -- throw an error if it is not found (it must be installed by the end user) and exit
  if not hud_studio then
    mod:error("Error at block registration: HUD Studio is not installed.")
    return
  end

  -- register our blocks here
  hud_studio.register_blocks(
    -- we are passing our mod (my_dps_mod) as the first parameter.
    -- HUD Studio will use this to get your mod's name and stash your blocks
    mod,

    -- the second parameter is a table that expects your name (as the author) and the blocks array
    {
      author = "malevhf",
      blocks = {
        -- one path per block
        "scripts/mods/my_dps_mod/DPS_Bar",
        "scripts/mods/my_dps_mod/DPS_Display_Widget",
    },
  })
end
```

The path is all you write. Everything else about a block- its label, summary, version, requires
and tags you fill in inside the game, in the Block panel's **Export to Mod** section, and it is
stored in the block file itself. Re-export and your registration is already up to date; you do not
even have to restart, because the library re-reads your files every time the it's opened.

#### Remember to add a localization for mod_name in the mod

HUD Studio will attempt to get your mod name via `mod:localize("mod_name")` in order to get a readable version of your mod name. It falls back to the mod ID, which can look ugly in the sidebar. Present yourself.

For a complete API reference, check the other pages.

### 5. You're done! Install the mod! Now!

Users will now be able to see your HUD elements when they navigate to their library. Your mod name will appear in the left-hand column, and each block defined inside `blocks = ` will appear as a button.

## What can users do with my installed HUD?

When a user adds your mod block to their canvas, their edit actions on that block are restricted unless they duplicate the block, by design.

Users can:

- Move the block around their canvas
- Scale the whole block to be larger or smaller
- Re-order where the block sits in their Blocks panel (So that it can draw over or under other elements)
- Put it in one of their own folders
- Force-hide the block
- Delete it from their canvas (they can always add it again from the library)
- Duplicate the block, which they can then edit freely as if it was their own

#### Why limit edits?

I don't want HUD Studio to treat your HUD like its proprietary code that is not meant to be edited. It's built for people who like to tinker. However, I also want to allow mod authors to update their mods and HUD elements, and give users the option to update their HUD without unexpectedly losing their changes.

For this purpose, edits are restricted on anything but basic layout, so that clicking 'Update Block' will not destroy their changes if their tinkered-with version deviates from your updated version. So, the 'duplicate' action is explicit, and it means the user states _"I am okay with losing out on updates and take responsibility for any errors with this HUD element"_.

## Addendum: Creating HUD elements which consume information provided by your mod

While the built-in code editor is handy, it's not the best place to actually write bulky code, and definitely not the place to try to write hooks with mod:hook_safe.

Let's take a DPS display mod and HUD element as an example here.

What you should do:

#### Write all of your logic and hooks inside your mod files:

```lua
-- my_dps_mod.lua

local mod = get_mod("my_dps_mod")

local dps_color_high = {255, 255, 0, 0 } -- red
local dps_color_medium = {255, 255, 165, 0 } -- orange
local dps_color_low = { 255, 255, 255, 255 } -- white

local dps = 0

local function calculate_dps(self, damage_profile, attacked_unit, attacking_unit, hit_world_position, hit_weakspot, damage)
  -- calculate your dps here
  -- assign to 'dps'
end

mod:hook_safe(CLASS.AttackReportManager, "add_attack_result", calculate_dps)

-- Expose your DPS functions here
mod.dps_display = function()
  return dps
end

mod.dps_color = function()
  if dps >= 2500 then
    return dps_color_high
  elseif dps >= 1000 then
    return dps_color_medium
  else
    return dps_color_low
  end
end
```

#### Inside the **block script**, store a reference to your mod or mod functions on `state`:

```lua
-- #### In the in-game code editor, inside your block script ####

-- If the state does not hold a reference to your mod yet, do that first

if not state.mod then
  state.mod = get_mod("my_dps_mod")
end

-- If for some reason get_mod did not get your mod handle, exit early to avoid errors.
-- This will run again on the next frame, so it will get the mod eventually (unless you typo'd)

if not state.mod then
  return
end

-- Here we can store references to your mod's functions, which the nodes in this block can access.
-- You don't need to do this (can just access these via state.mod), but it will be more convenient and less verbose.)

state.dps_display = state.mod.dps_display
state.dps_color = state.mod.dps_color
```

#### Then you can create a text node to display it, with the text value mode set to `Code`:

```lua
-- ### in the in-game code editor, inside your text node 'value' code ###

if block.state.dps_display ~= nil then

  -- Note from earlier where we wrote the block's script to store a `dps_display` reference to 'state.dps_display'

  text = block.state.dps_display()

else
  -- Define a fallback value, in case block.state.dps_display does not exist.
  -- Note that setting text to nil does NOT hide it - a nil result falls back to the
  -- static value you authored on the node. To hide it, use the node's Visible field.
  text = 0
end
```

#### Why should I not write the block script code inside my node fields?

It's more error tolerant, a small optimisation, and (primarily) it saves you writing the same 'get_mod' code and its guardrails everywhere you want to access it in the same block.

Let's say you wanted to change colors of the text node now:

```lua
-- ### in the in-game code editor, inside your text node 'color' code ###

if block.state.dps_color ~= nil then

  -- Note from earlier where we wrote the block's script to store a `dps_color` reference to 'state.dps_color'

  color = block.state.dps_color()

else
  -- Define a fallback value, in case block.state.dps_color does not exist
  -- if you want the text color to use the 'static' mode value - set color to nil.
  color = {255, 255, 255, 255} -- white
end
```

### Recap

- Write your core logic inside your mod
- Expose the results of your logic to your `mod`
- Store `mod` references on the `block` script
- Access those references from node/block fields
