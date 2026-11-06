### I installed a mod and it pointed me here. What do?

To add a mod's HUD elements to your screen, you want to open the [Block Library](concepts/block_library.md). The button to open it is on the top-left of the [Blocks panel](ui/blocks_tree.md) - where you opened the Help panel.

Once you're there, click the ** Workspaces & Mods** button on the top-left and click on the mod you installed from the list.

Browse what's available and click **Add to Canvas** to add elements to your screen. The `Read From` controls select which player information is read from for that element. For a personal player panel you might select Player 1 (P1). For teammates, you want Player 2 - 4.

Once the elements are added, close the panels, and drag the elements to where you want them to sit on your screen, or leave them as-is.

Clicking on elements in the `Blocks panel` or on the screen will open the **Properties** panel. Here you can:

- tweak variables, if any are available (sort of like mod settings, but for a single element)
- change `Scale`, which makes an element larger or smaller
- change `Motion` settings (elements lagging behind camera movement, or moving with the crosshair/camera motion)

### I followed the above steps but...

**...the vanilla HUD is in the way. What do?**

- In the [Blocks panel](ui/blocks_tree.md), look for the toolbar attached on its side.
- There's a button with a `` icon. Click it to open the `Toggle Vanilla HUD` panel.
- From here you can disable almost all elements by clicking on them in the panel.
- Any that cannot be replicated easily with HUD Studio (like the buffs bar, killfeed, etc) can be moved around by applying an offset.

**...the element only appears when I hover over it. What do?**

- Most likely, the element has `Visibility` filters which are not currently applicable
- The element may be limited to a specific class, gamemode, weapon, or may be designed to `appear in certain conditions`, like when dodging or taking damage
- You may be looking at a teammate player panel, which are almost always designed to only appear when that player slot is filled (try a full party, or a full 4 player mission)
- Less likely, the element might have an error in its script. Look for a red eye icon on the element's row in the `Blocks` panel. Let the author know if this is the case

**...the element says it's disabled. What do?**

- Check if you have the required dependency mods installed
- Commonly this is `SimpleAssets` or `SimpleAudio` (HUD Studio doesn't depend on them, but they open up a lot of features)
- Check if the mod the element comes from is installed and enabled

### Is this compatible with other HUD mods?

HUD Studio is self contained and does not interact with any other mod. You can mix it with any other mod, regardless of what it does.

### How do I edit another mod's HUD elements?

If the mod you're referring to was not made with HUD Studio, you cannot. That's not how this mod works.

If they were made with HUD Studio, follow the above steps, and click `Duplicate` in the element's **Properties** panel.

### I want to make my own thing now, but the forms are very confusing :(

Follow the tutorials. They are very short, and can be kept open while you follow the instructions. Start with the `Stamina Bar`, it's about 6 steps, and highlights the core flow of the mod.
