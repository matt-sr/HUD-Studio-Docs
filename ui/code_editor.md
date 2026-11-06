The Code Editor is where you write Lua for anything in `Code` mode: a node's field, a block's Visibility, Scale, Position or Opacity, the block script, a variable, an event trigger, or a workspace function.

It is a floating panel.

## Opening it

| From                                          | Opens                                                   |
| --------------------------------------------- | ------------------------------------------------------- |
| Blocks panel side toolbar, Code Editor button | the tab you had open last, else the first script listed |
| A field's `Open IDE…` button                  | that field's script                                     |
| Block Script on the Properties panel          | the block script                                        |
| Right-click a block, `Scripts`                | the script you pick                                     |
| A row in the Explorer                         | that row's script                                       |

- Opening a field's script switches the field to `Code` mode.
- The button shows an error when any script is broken. Hover it for the message.
- A field's button reads `Open IDE… (Error)` when its script is broken.

## Layout

| Part           | Holds                                             |
| -------------- | ------------------------------------------------- |
| Sidebar (left) | Explorer or Search                                |
| Tabs (top)     | the scripts you have open                         |
| Breadcrumb     | where the open script lives: block, node, field   |
| Code           | the script, inside its fixed first and last lines |
| Bottom tabs    | Problems, Scope, Globals, Types, Hotkeys          |

The lines around your code are fixed. They show what the script is called with and what it must assign. Only the box between them takes typing.

## Explorer

`Ctrl + Shift + E` shows it.

The Explorer lists every script in the document, grouped by workspace, block, node and field.

- Click a row to open it. Double-click to open it in a pinned tab.
- A broken script's row is red.
- Right-click a heading to copy its name.
- A workspace's functions list first under its heading. Press **+** on the heading to add one. See [Workspace Functions](../scripting/workspace_functions.md).

## Search

`Ctrl + Shift + F` shows it.

Type to search every script, by its path and by its code.

- Click a heading to open the script. Click a line to open it at that line.
- Every word you type must be on one line. `x, y` finds `local x, y`.
- Close spellings count. `curhp` finds `current_health_percent`.
- A path search finds a script by its block, node or field name: `team panel color`.

## Tabs

The tabs across the top are your open scripts. Up to 8 stay open. Past that the one used longest ago drops off.

- One tab is a preview. The next script you open replaces it.
- Double-click a tab, or type in its script, to pin it.
- Press the `X` on a tab to close it. The last tab you used opens in its place.
- Tabs are saved. They come back the next time you open the editor.

## Saving

A script compiles when you click off the code box.

`Ctrl + S` compiles it without leaving the box.

- An error shows on a red line under the tabs. The line it points at is shaded.
- A script that errors uses its field's static value until it is fixed.
- Add or remove lines and the error hides until the next save. Its line number would be wrong.

## Autocomplete

Suggestions open as you type.

| Key            | Does                  |
| -------------- | --------------------- |
| `Ctrl + Space` | opens the suggestions |
| `Up` / `Down`  | moves through them    |
| `Tab`          | accepts one           |
| `Esc`          | closes them           |

- Click a suggestion to accept it.
- Inside a call's brackets, a hint shows the function's parameters.

## Bottom tabs

| Tab        | Shows                                             |
| ---------- | ------------------------------------------------- |
| `Problems` | every broken script. Its count is in the tab name |
| `Scope`    | the names the open script is called with          |
| `Globals`  | every global a script can read                    |
| `Types`    | the types those names use                         |
| `Hotkeys`  | the editor's keys                                 |

- Click a row in `Problems` to open that script.
- In `Scope`, `Globals` and `Types`, click a row with children to fold it. Click a leaf to copy its full path, such as `sources.player_1.<field>`.
- Every tab but `Problems` has a search box.

## Hotkeys

| Key                                   | Does                        |
| ------------------------------------- | --------------------------- |
| `Ctrl + S`                            | save                        |
| `Ctrl + Z` / `Ctrl + Shift + Z`       | undo / redo                 |
| `Ctrl + /`                            | comment / uncomment         |
| `Tab` / `Ctrl + Tab`                  | indent / un-indent          |
| `Ctrl + G`                            | duplicate line              |
| `Ctrl + X` / `Ctrl + C`, no selection | cut / copy the caret's line |
| `Ctrl + Alt + Left / Right`           | select part of a name       |
| `Ctrl + Alt + Backspace / Del`        | delete part of a name       |
| Double-click                          | select word                 |
| Triple-click                          | select line                 |
| Double- or triple-click, then drag    | select by word or by line   |
| `Ctrl + Shift + E`                    | Explorer                    |
| `Ctrl + Shift + F`                    | Search                      |

## Mod scripts

The Code Editor does not open a mod block's scripts. Duplicate the block to edit them. See [Mod Blocks](../concepts/mod_blocks.md).
