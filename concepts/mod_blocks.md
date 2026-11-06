A mod block is a block that another mod ships. You add it from the mod's page in the [Block Library](block_library.md). Its row in the Blocks tree carries a `[MOD]` chip; hover it to see which mod it came from, and who made it.

You can place and scale it, but only the mod's author can change its content.

## What you can change

- **[Position](../reference/position.md).** Drag it on the canvas, or set its offset in the **Properties** tab.
- **[Scale](../reference/scale.md).** Make it larger or smaller.
- **Motion.** Follow Camera and Follow Motion.
- **Customise.** Variables the author lets you set, like colors or labels. Only shown when the block has any.
- **Max Update Rate**, in the Performance corner of the tab strip.
- **Eye and lock.** Hide it, or lock it in place.
- **Order.** Restack it in the Blocks tree, or file it into one of your groups.

## What you cannot change

- Its nodes, their fields and their visibility rules.
- Its scripts. The Code Editor does not open them.
- Its size.

## Updates

When a mod ships a new version of a block, your copies can follow it.

- **Keep Updated**, on the mod's banner in the Block Library, updates your copies at the next start. It is on by default.
- With it off, the entry's **Update all on your Canvas** button updates them by hand.

An update keeps where you placed the block. It is one undo step.

**Reset Block** on the right-click menu puts the block back to exactly what the mod ships now, keeping your placement.

## Editing a mod block

**Duplicate To Edit**, at the bottom of its Properties tab, swaps the block for your own copy. The copy is an ordinary, fully editable block. The mod's block goes to Deleted Items, in one undo step.

Note that your copy:

- no longer updates with the mod
- makes any errors in it yours to fix

**Save** on the side toolbar does the same for the library: it saves a copy to your workspace, with your variable values written in.

A block from a mod's group duplicates its whole group; see [Groups](groups.md).

## When the mod is missing

If the mod that shipped the block is uninstalled, the block stays on your canvas. Its form shows **Status: Not installed**. Reset and Update stop working, since there is nothing shipped to reset to.

Some blocks need other mods, like `SimpleAssets` or `SimpleAudio`. If one of those is disabled or uninstalled, the block switches off and draws nothing. Its form lists what it **Needs**.
