A data source is the game's current state: what is true right now. Stamina, ammo, a player's name, whether someone is downed.

Bind a field to one and it stays live. This is what most HUD elements are built from.

## Sources

The first choice in the picker is who or what to read from.

| Source                   | Reads                                                                  |
| ------------------------ | ---------------------------------------------------------------------- |
| `Player 1 (You)`         | you                                                                    |
| `Player 2` .. `Player 4` | your teammates                                                         |
| `Spectated Player`       | whoever you are spectating                                             |
| `Active Effects`         | yes/no effects on you: burning, invisible, guaranteed crit, unkillable |
| `Talents`                | your talents: stacks, timers, cooldowns                                |
| `Subtitles`              | the voice lines playing right now                                      |

The player sources all hold the same fields. A block built for you works for a teammate by picking another slot: `Read From` in the [Block Library](../concepts/block_library.md) does this when adding a block.

## What's in them

| Group                                                    | Useful for                                          |
| -------------------------------------------------------- | --------------------------------------------------- |
| `Status`                                                 | bars and numbers: health, toughness, stamina, peril |
| `State`                                                  | show/hide rules: downed, sprinting                  |
| `Ability`, `Blitz`                                       | cooldowns, charges, icons                           |
| `Equipment`                                              | ammo, overheat, reload, weapon icons                |
| `Combo`                                                  | heavy charge and swing tracking                     |
| `Stimms`, `Pocketables`, `Objective Device`, `Materials` | what a player carries or has collected              |
| `Identity`, `Profile`                                    | names, class, levels, portraits, insignia           |

The full list is in each group's _Reference_ page.

## Field types

The type of a field decides where it fits.

| Type     | Use it on                                     |
| -------- | --------------------------------------------- |
| number   | a bar's `Current` and `Max`, text, conditions |
| boolean  | `Visible` rules, conditions, events           |
| string   | text                                          |
| material | a rectangle's `Material`                      |

- Many fields are nil while there is nothing to read: an empty slot, a bot's account name.
- A rectangle's `Fallback` covers a material that comes up empty.
- Use [Signals](signals_intro.md) for things that happen, and [Controls](controls_intro.md) for keys and buttons.
