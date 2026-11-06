Sources: `player_1`, `player_2`, `player_3`, `player_4`, `player_spectated`

Each player's `talents` group reads their talents: which ones they have, and how each is doing right now (stacks, timers, cooldowns).

For teammates only which talent they have (`id`, `name`, `icon`, `equipped`) reads, because their buffs are not sent to your game.

So `player_2..4` list the slot groups with those four leaves, and talents by name are `player_1` only. `player_spectated` reads defaults for the rest while you watch a teammate.

Keystone data by **LucLeto**, from **Perfect Keystones**, used with permission.

## Which talent

| Field                                 | Reads                                                   |
| ------------------------------------- | ------------------------------------------------------- |
| `player_N.talents.keystone.<leaf>`    | that player's main keystone, whichever class            |
| `player_N.talents.keystone_2.<leaf>`  | Until Death or Lone Wolf                                |
| `player_1.talents.<talent_id>.<leaf>` | one of your talents by name, e.g. `zealot_fanatic_rage` |

## Fields

Leaves that do not apply to a talent read 0 or false.

| Leaf                        | Type     | Meaning                                                      |
| --------------------------- | -------- | ------------------------------------------------------------ |
| `id`                        | string   | internal talent id; tells which keystone a slot holds        |
| `name`                      | string   | talent name, in your language                                |
| `icon`                      | material | talent icon                                                  |
| `equipped`                  | boolean  | in the player's build                                        |
| `is_active`                 | boolean  | the effect is running now (see below)                        |
| `active_seconds`            | number   | seconds left on `is_active`                                  |
| `active_progress_percent`   | percent  | same, 100 to 0                                               |
| `stacks`                    | integer  | current stacks                                               |
| `max_stacks`                | integer  | stack cap, upgrades included                                 |
| `stacks_percent`            | percent  | stacks as % of the cap                                       |
| `at_max_stacks`             | boolean  | at the cap                                                   |
| `stack_seconds`             | number   | until the next stack drops, or all of them on a shared timer |
| `zero_stacks_seconds`       | number   | until every stack has dropped                                |
| `is_on_cooldown`            | boolean  | a proc or refill is cooling down                             |
| `cooldown_seconds`          | number   | until ready, or until the next charge                        |
| `cooldown_progress_percent` | percent  | 0 to 100; stays at 100 while ready                           |

## What is_active means

| Keystones                                                                                                                                               | `is_active`                                                                                  |
| ------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| Marksman's Focus, Warp Siphon, Disrupt Destiny, Forceful, Chemical Dependency, Redline Capacitors, Heavy Hitter, Burst Limiter Override, Vulture's Mark | stacks above 0, with a timer                                                                 |
| Focus Target!, Martyrdom, Feel No Pain, Empowered Psionics, Flensing Protocols                                                                          | stacks above 0, no timer                                                                     |
| Weapons Specialist, Blazing Piety, Inexorable Judgement, Terminus Warrant, Adrenaline Frenzy, Power Overload                                            | the active effect is up; building stacks do not count, and `stacks` stays readable meanwhile |
| Execution Order                                                                                                                                         | the effect is up                                                                             |
| Until Death                                                                                                                                             | the protection is up; then `is_on_cooldown`                                                  |
| Lone Wolf                                                                                                                                               | Blitz charges are missing; `cooldown_seconds` runs to the next one                           |
| Go Get 'Em!, Unleashed Brutality                                                                                                                        | same as `equipped`                                                                           |

Weapons Specialist and Terminus Warrant read the stacks of the weapon you are holding.

## Good to know

- The game does not tell your client when Focus Target! or Feel No Pain will next regain a stack, so `cooldown_seconds` reads 0 for those two.
