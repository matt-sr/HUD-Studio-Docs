The **Details** tab holds what the Block Library shows about a block: its title, its description and its tags. A mod ships these with the block, so set them before you [export](exporting.md).

## The Details tab

Select the block and open its **Details** tab:

| Field        | Sets                                                    | Cap                          |
| ------------ | ------------------------------------------------------- | ---------------------------- |
| Block Name   | what the block is called in the Blocks panel            | 48 characters                |
| Library Name | the entry's title and button label in the Block Library | 48 characters                |
| Summary      | the text in the library's details pane                  | 300 characters, 3 paragraphs |
| Tags         | what the library's tag filter finds the entry by        | 14 tags                      |
| Save To      | the workspace the entry is saved in                     |                              |

Then press **Save**.

- Left empty, **Library Name** is the Block Name.
- **Save To** is also on the Property panel's title bar, upper-right, as a dropdown. Both set the same thing.

A group's Details tab is the same, without Library Name. A group's name is its title.

## Summary

Say what the block shows, and anything a user should know before adding it. Keep it short: the details pane is a narrow column.

## Tags

Tags are picked from a list. Click the Tags box to open it:

- It lists every tag the workspace already uses. Click one to add it, click it again to take it off.
- Type to search. A name no tag has shows as `Create "name"`.

- A tag keeps letters, `_`, `-` and spaces. Anything else is dropped.
- A tag is up to 25 characters.
- The library shows tags prettified: `player_vitals` shows as `Player Vitals`.

### Tag caps

- An entry holds up to 14 tags.
- A mod workspace holds up to 14 tags across all of its entries. My workspace has no cap.

Pick a few broad tags and reuse them, like `vitals`, `ability` or `team`. A user filters a mod's page by them.

## Changing a saved entry

Open the entry in the Block Library and press **Edit**. Library Name, Summary and Tags are there too. Saving the edit updates the block on your canvas too, and saving the block updates the entry.

## Version

Each entry has a Version. You do not set it. Exporting a _changed_ entry raises it by one, and users' copies update from it; see [Mod Blocks](../concepts/mod_blocks.md).
