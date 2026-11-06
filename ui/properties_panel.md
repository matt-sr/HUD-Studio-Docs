The Properties panel holds the settings of whatever is selected. Select a row in the Blocks tree, or click an element on the canvas, and its settings open here.

## What it shows

| Selected | The panel shows                                        |
| -------- | ------------------------------------------------------ |
| Block    | the block's fields, split across tabs                  |
| Node     | the node's fields: text, rect or progress bar          |
| Group    | the group's variables and its library details          |
| Guides   | the canvas guides, with `Generate` and the guide lists |

A block marked `[MOD]` shows a short form: its placement and any variables its author exposed under `Customise`. Duplicate it to edit the rest. See [Mod Blocks](mod_blocks.md).

## Tabs

A block or group splits its settings across tabs along the top.

| Tab          | Holds                                                    |
| ------------ | -------------------------------------------------------- |
| `Properties` | the main fields                                          |
| `Details`    | its name, summary and tags, and saving it to the library |
| `Variables`  | the block's variables                                    |
| `Events`     | the block's events                                       |
| `Tools`      | Mass Update (with Inactive Bindings), Performance Info   |

The cycler in the corner of the tab strip is the block's update rate. See [Rates](rates.md).

## Sections

Fields are grouped into sections, such as `Visibility` and `Style`. Click a section's header to fold or unfold it.

## Fields

Each row is one field. The dropdown beside it picks its mode: `Static`, `Data Source`, `Code`, and so on. See [Fields](fields.md).

- Hover a field's label for a tooltip.
- Number boxes take typing, or the `-` / `+` buttons. Hold a button to keep stepping.
- Every change is one undo step. `Ctrl + Z` undoes it.

## Copy and paste

Right-click a field for `Copy` and `Paste`. The menu names what it copies, such as `Copy Width + Height`.

Over a field, `Ctrl + C` and `Ctrl + V` do the same.

- A paste onto a field of the same type brings everything, every mode included.
- A paste onto a field of another type brings only its `Data Source`, and only if the type fits.
- Numbers are clamped to the receiving field's range.

## Side toolbar

The strip off the panel's title bar holds the actions of the selected block. A node selection shows its block's actions.

| Button       | Does                                                  |
| ------------ | ----------------------------------------------------- |
| Save         | saves the block to its workspace in the Block Library |
| Library      | opens the block's library entry. Save the block first |
| Block Script | opens the block script in the Code Editor             |

- An orange dot on the Save button means the block has unsaved changes.
- The Block Script button turns red when the script errors. Hover it for the message.
- On a mod block, Save makes a copy in your own workspace. The copy no longer updates with the mod.

A group shows its own Save and Library buttons.

## Workspace

The name on the right of the title bar is the workspace the block or group saves to. Click it to pick another. See [Workspaces](../mod_making/workspaces.md).

## Moving the panel

Drag the title bar to move the panel.

- When it would open under the cursor, it slides aside.
- It moves off the Blocks panel, and off the element you clicked, when there is room.
