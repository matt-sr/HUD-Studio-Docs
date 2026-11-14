Sources: `player_1`, `player_2`, `player_3`, `player_4`, `player_spectated`

Each player's `talents` group reads their talents: which ones they have, and how each is doing right now (stacks, timers, cooldowns).

For teammates, only which talent they have (`id`, `name`, `icon`, `equipped`) reads, because their buffs are not sent to your game.

So `player_2..4` list the slot groups with those four leaves, and talents by name are `player_1` only. `player_spectated` reads defaults for the rest while you watch a teammate.

Keystone data by **LucLeto**, from **Perfect Keystones**, used with permission.

## Which talent

| Field                                 | Reads                                                                           |
| ------------------------------------- | ------------------------------------------------------------------------------- |
| `player_N.talents.keystone.<leaf>`    | **Keystone**: that player's main keystone, whichever class                      |
| `player_N.talents.keystone_2.<leaf>`  | **2nd Keystone**: Until Death, or Lone Wolf, Go Get 'Em! or Unleashed Brutality |
| `player_1.talents.<talent_id>.<leaf>` | one of your talents by name, e.g. `zealot_fanatic_rage`                         |

## Fields

Leaves that do not apply to a talent read 0 or false.

| Leaf                        | Type     | Meaning                                                      |
| --------------------------- | -------- | ------------------------------------------------------------ |
| `id`                        | string   | internal talent id                                           |
| `name`                      | string   | talent name, in your language                                |
| `icon`                      | material | talent icon                                                  |
| `equipped`                  | boolean  | in the player's build                                        |
| `is_active`                 | boolean  | the effect is running now (see below)                        |
| `active_seconds`            | number   | seconds left on `is_active`                                  |
| `active_progress_percent`   | percent  | same, 100 to 0                                               |
| `buff_bar_progress_percent` | percent  | the vanilla buff bar's fill for this talent's buff           |
| `adaptive_progress_percent` | percent  | the icon's Adaptive fill                                     |
| `stacks`                    | integer  | current stacks                                               |
| `max_stacks`                | integer  | stack cap, upgrades included                                 |
| `stacks_percent`            | percent  | stacks as % of the cap                                       |
| `at_max_stacks`             | boolean  | at the cap                                                   |
| `stack_seconds`             | number   | until the next stack drops, or all of them on a shared timer |
| `stack_progress_percent`    | percent  | same, 100 to 0                                               |
| `zero_stacks_seconds`       | number   | until every stack has dropped                                |
| `zero_stacks_percent`       | percent  | same, 100 (a full cap's drain) to 0                          |
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

`player_N.talents.icon_frame` (Talent Icon Frame) is the vanilla buff bar's frame around a talent icon.

## Adaptive fill

**Adaptive** is the default Fill Behaviour on every talent and aura `adaptive_progress_percent` holds the same number, 0 to 100, so a progress bar or condition can use the same logic.

Each update, it shows the first of these that applies:

| Talent state                                               | Adaptive reads                          |
| ---------------------------------------------------------- | --------------------------------------- |
| a cooldown is running                                      | the cooldown recovering, 0 up to 100    |
| the effect is up with time left                            | that time draining, 100 down to 0       |
| stacks are up on a timer                                   | the stack timer draining, 100 down to 0 |
| a timed stack has run out but not yet been removed         | 0                                       |
| build-up stacks are up (see below)                         | stacks as % of the cap, 0 up to 100     |
| a proc or refill is ready                                  | 100                                     |
| known idle: not active and no stacks                       | 0                                       |
| anything else (a passive, an untimed effect, plain stacks) | 100                                     |

**Build-up stacks** are untimed stacks that give nothing until a keystone spends them on a separate effect: Inexorable Judgement (Momentum), Blazing Piety (Fury), Weapons Specialist, Terminus Warrant, Power Overload. While they build, Adaptive shows how close you are to the cap (5 of 20 Momentum reads 25%); once spent, the effect's time left takes over. A `buffs` entry whose Buff ID is one of these keystones' build-up buffs follows the same logic.

**Why use it?** Every keystone works differently: some run on stacks, some on a timed effect, some on a cooldown, and several switch between them (e.g. Until Death). Adaptive always picks whatever is happening now, in order of (opinionated) priority.

The single-purpose leaves, such as `cooldown_progress_percent` or `stack_progress_percent`, read 0 for any talent they do not apply to. So a node bound to one of them only works for some keystones, and `talents.keystone` changes whenever you change class or build.

**Buff Bar Fill** (`buff_bar_progress_percent`, keystones only) is vanilla's own fill for the talent's main buff. It reads 0 whenever that buff is not up, and it ignores the talent's other state (a cooldown kept apart from the buff, a ready proc), which Adaptive takes into account.

## Icon options

Every keystone and aura `icon` is the buff bar's art for that talent. The talent tree's art is used only when a talent has no buff icon. Weapons Specialist and Terminus Warrant show the wielded weapon's buff icon, as the buff bar does; with no weapon in hand, and on teammates, a fixed one (Weapons Specialist's ranged, Terminus Warrant's melee).

A bound `icon` (keystone or aura) shows three options under the Field picker: **Shape** (default [Vanilla] Buff, the square mask), **Fill Color** (default [Vanilla] Adaptive, the keystone or aura ramp) and **Fill Behaviour** (default Adaptive; a teammate's icon is always full, and so is any keystone or aura icon in the Mourningstar). In code, a plain read such as `player_1.talents.keystone.icon` is the bare icon (hexagon, no ramp, full). For the same look as a binding, use `with_options(player_1.talents.keystone, "icon", {})`, with any choices in the table.

```lua
local mask_options = {
    "talent_default_mask",
    "hexagon",
    "circle_frame_horde_mask",
    "ability_mask_battery",
    "square_frame_mask",
    "circular_frame_mask",
    "hex_frame_mask",
    "gradient_radial_invert",
    "blur_straight_02",
    "blur_straight",
    "gradient_horizontal_tapered",
    "drop_shadow_center_fade"
}

local ramp_options = {
    "adaptive",
    "talent_ability",
    "talent_aura",
    "talent_blitz",
    "warp_ramp_03",
    "talent_keystone",
    "rarity_04",
    "purple_ramp_01",
    "warp_ramp_02",
    "fire_01",
    "lasgun_ramp_01",
    "fire_ramp_03",
    "gradient_digital_blood_red",
    "rarity_06",
    "bleedfire_ramp_01",
    "fire_ramp_01",
    "lasgun_ramp_02",
    "fire_ramp_02",
    "gradient_digital_frame_red",
    "gradient_farme_selected_red",
    "gradient_digital_disabled_red",
    "rarity_05",
    "fire_04",
    "fuse_01",
    "yellow_ramp_01",
    "gradient_digital_green",
    "healing_ramp",
    "green_ramp_02",
    "enemy_fire_01",
    "yellow_green_ramp_01",
    "gradient_farme_selected_green",
    "rarity_02",
    "gradient_digital_disabled_green",
    "fuse_02",
    "yellow_white_ramp_01",
    "blue_01",
    "blue_ramp_01",
    "thunder_ramp",
    "blue_ramp_02",
    "plasma_rifle_ramp_02",
    "warp_ramp",
    "warp_ramp_controlled_03",
    "warp_ramp_controlled_01",
    "rarity_03",
    "horde_buff_family_gradient",
    "freeze_ramp_01",
    "talent_default",
    "rarity_01",
    "white_ramp_01",
    "green_ramp_01"
}

local fill_behaviour_options = {
    "adaptive",
    "buff_bar",
    "cooldown",
    "talent_active",
    "stack_timer",
    "stacks",
    "full",
    "none"
}

material = with_options(sources.player_1.talents.keystone, "icon", {
    mask = mask_options[1],
    ramp = ramp_options[1],
    fill_behaviour = fill_behaviour_options[1]
})
```

## Auras

| Field                               | Reads                                                             |
| ----------------------------------- | ----------------------------------------------------------------- |
| `player_1.talents.aura_1..4.<leaf>` | your aura (1), then teammates' in coherency (2-4)                 |
| `player_N.talents.aura_1.<leaf>`    | on a teammate: the aura in their build, `id`, `name`, `icon` only |
| `player_1.talents.<aura_id>.<leaf>` | one aura by name, e.g. `veteran_increased_damage_coherency`       |

Teammates have no `aura_2..4` as their buffs are not readable.

In the Mourningstar no talent buffs run, so `aura_1` is your build's aura read off your profile (as for a teammate), `aura_2..4` are empty and **On You?** reads false.

Every class starts with a base aura (e.g. The Quickening for Psyker), which counts as equipped until you pick an aura in the talent tree.

In the Field dropdown `aura_1` is **Aura** and `aura_2..4` are **Coherency Aura 1..3**. `aura_1` is always your own aura while it is on you. The rest are in the order they reached you. If yours drops (you die, or a teammate's stronger version of it replaces it), the rest move up.

Two players with the same aura give you one buff, so it takes one slot.

Aura leaves: `id`, `name`, `icon`, `equipped` (named auras only), `is_active`, `is_on_cooldown`, `cooldown_seconds`, `cooldown_progress_percent`, `adaptive_progress_percent`.

- `equipped` is "in your build". A teammate's aura on you reads `is_active` true and `equipped` false. The slots have no `equipped`: they list what is on you.
- `is_active` (**On You?** in the Field dropdown) is "on you now", whoever gave it. On `aura_2..4` it is true whenever the slot holds an aura, so it doubles as "is this slot filled?".
- The cooldown leaves are for Survivalist only (its ammo proc). Its `is_active` stays true between kills, while you are in coherency.
