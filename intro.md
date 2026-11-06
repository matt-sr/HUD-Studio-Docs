Welcome!

The Help panel is an in-game directory of articles explaining everything you might need.

**Good to know**:

- **Links are clickable in-game** - clicking blue underlined text will navigate to the article.
- **Mouse side buttons** - take you back and forward through clicked articles
- **Search function (top-left)** - searches across every article, ranked by relevance.

**If you're new:**

- The **FAQ** articles which clarify _what this mod does_ or _doesn't_ do
- **If you have installed a mod that uses HUD Studio**, read [FAQ - For Mod Users](faq-mods.md) first!
- If you can intuit how to navigate the mod, the tutorials are also a good starting point

## Important QoL features which may not be obvious

- _Scrolling_: Almost all panels scroll, in case they're taller than the screen
- _Moving Panels_: Click + drag the title bar of each panel to move it around
- _Context Menu_: Right click on the canvas, panels or fields to open a menu with useful actions
- _Undo & Redo_: Done with `CTRL+Z` and `CTRL+SHIFT+Z` respectively
- _Copy and Paste_: Hover over single or grouped fields and press `CTRL+C` to copy them
  - Hover over relevant areas and `CTRL+V` to paste
- _Hotkeys_: There's **LOTS** of hotkeys for various things, depending on what you're doing
  - There's too many to list, see [Canvas](concepts/canvas.md) and the [UI](ui/blocks_tree.md) articles to see what's available where

## Articles

Concepts are ordered from easy (and important) to more advanced. These are vital:

- [Concepts](concepts/blocks.md): how this mod does anything, and how to do anything with it
  - [Blocks](concepts/blocks.md): What is a block? Are we playing minecraft?
  - [Nodes](concepts/nodes.md): The things that do stuff
  - [Fields](concepts/fields.md): Different properties for the above
- [Nodes](nodes/progress_bars.md): purpose and a how-to for each node type

## Tutorials

A few tutorials on how to make common use-case HUD elements:

- [Stamina Bar](tutorials/stamina_bar.md): a progress bar that follows a value
- [Player Name](tutorials/player_name.md): a text node
- [Melee Weapon Icon](tutorials/melee_weapon_icon.md): an icon on a rectangle
- [Custom Images](tutorials/rect_image.md): your own image files on a rectangle
- [Weapon Sound Replacer](tutorials/event_sound.md): an event that plays audio

## How fields get values

[Sources](sources.md) introduces the three ways of how fields can get their values without code. Each type then has a brief explanation (_Intro_) and a complete list of its fields (_Reference_):

- [Data Sources](sources/data_sources_intro.md): The typical use-case data
  - Player Vitals, Ammo, Stamina, Melee Weapon Icon, Player Slot Color
- [Signals](sources/signals_intro.md): Event-based fields that flip for one frame
  - Attack, Hit, Kill, Damage Taken, Died, Rescued
- [Controls](sources/controls_intro.md): Fields related to keypresses
  - F -> Pressed, Jump -> Pressed

## Field & UI Reference

These fill in any remaining gaps in information and act as a general reference for using the mod:

- [Fields](reference/field_types.md): each kind of field in depth: field types, visibility, opacity, position, size and scale
- [UI](ui/blocks_tree.md): how to use and navigate the mod's panels

## For Modders & Coders

The rest is for **modders** and anyone familiar with (or interested in) tinkering with the script editor.

[Script & Animate](scripting/index.md) has guides on animating elements with the script editor, and documentation for the mod's `anim` animation library:

- [Block Scripts](scripting/block_script.md): how block-level scripts work, and their purpose
- [Node Scripts](scripting/node_scripts.md): how per-field scripts work and their relationship to block scripts
- [Linger & Delay](scripting/linger_delay.md), [Fade in-out](scripting/fades.md): holding and fading an element as it shows or hides
- [anim](scripting/anim.md): a complete reference for HUD Studio's `anim` animation library
- [Animate Position](scripting/animate_position.md), [Animate Scale](scripting/animate_scale.md): moving and scaling elements over time

[Workspaces & Modding](mod_making/workspaces.md) documents managing workspaces for new or existing mods: details and tags, dependencies, exporting, and API registration.
