Replace a weapon's sound with your own audio file. Requires the **SimpleAudio** mod.

1. Put your audio file in `mods/hud_studio/audio/`.
2. In the [Blocks panel](../ui/blocks_tree.md)'s bottom toolbar, click **Add Block**.
3. Open the block's `Events` tab.
4. Turn on **WWISE LOGGER**, then fire the weapon.
5. Click the weapon's sound in the list to copy its name.
6. Click **+ Add Event**.
7. Set `When...` to `Game Sound`, paste the name and tick `Mute`.
8. Set the action to `Play Audio File` and pick your file.
9. Set `Volume %`, and click the play button to test it.
10. Close the editor. Events don't run while it's open.
