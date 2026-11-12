Sources: `player_1`, `player_2`, `player_3`, `player_4`, `player_spectated`

## Name

### Name
`ability.name` · `string` · `string | nil`

Natively localized Ability name, e.g. Shroudfield

### Name (Short)
`ability.name_simple` · `string` · `string | nil`

HUD Studio Ability name short-hand, e.g. Shroudfield -> *Stealth*

## Icon

### Ability Icon
`ability.icon` · `material` · `string | nil`

Ability Icon Face; use with_options

Shapes: 
- [Vanilla] Adapts To Class (Skitarii battery; rest are hexagon)
- .. the rest are custom shapes (masks) - **see below for full list**

Fill Color: 
- [Vanilla] Adapts To Class (Skitarii blue; rest are Red)
- .. the rest are custom colors (ramps) - **see below for full list**

Fill Behaviours: 
- [Vanilla] Cooldown & Active (fills up to your next charge, drains while in active state)
- Empty Until a Charge is Ready
- Active Duration Left 
- Always Full or Always Empty


```lua
local mask_options = {
    "adaptive",
    "hexagon",
    "talent_default_mask",
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
    "cooldown",
    "ready_only",
    "ability_active",
    "full",
    "none"
}

with_options(sources.player_1.ability, "icon", {
    mask = mask_options[1],
    ramp = ramp_options[1],
    fill_behaviour = fill_behaviour_options[1]
})
```

### Ability Icon Frame
`ability.icon_frame` · `material` · `string | nil`

Ability Icon Frame; use with_options

Shapes:
- [Vanilla] Adapts To Class (Skitarii battery; rest are hexagon)
- Hexagon
- Skitarii Battery


```lua
local shape_options = {
    "adaptive",
    "hexagon",
    "battery"
}

with_options(sources.player_1.ability, "icon_frame", {
    shape = shape_options[1]
})
```

### Ability Icon Shine
`ability.icon_glow` · `material` · `string | nil`

Ability Icon Glow; use has_options

_Hidden while the ability is on cooldown._

Shapes:
- [Vanilla] Adapts To Class (Skitarii battery; rest are hexagon)
- Hexagon
- Skitarii Battery


```lua
local shape_options = {
    "adaptive",
    "hexagon",
    "battery"
}

with_options(sources.player_1.ability, "icon_glow", {
    shape = shape_options[1]
})
```

## Status

### Active Duration Left [%]
`ability.active_progress_percent` · `number` · `0 .. 100` · **local player only**

% of Ability `is_active` duration remaining

Applies to abilities that hold back the cooldown (e.g. Rampage) or ones that apply a temporary stance buff (e.g. Executioner's Stance)

### Active Seconds Left
`ability.active_seconds` · `number` · `0.0 .. n` · **local player only**

Seconds of Ability `is_active` duration remaining

Applies to abilities that hold back the cooldown (e.g. Rampage) or ones that apply a temporary stance buff (e.g. Executioner's Stance)

### Is Active?
`ability.is_active` · `boolean` · `true | false`

Ability is running/active?

Applies to abilities that hold back the cooldown (e.g. Rampage) or ones that apply a temporary stance buff (e.g. Executioner's Stance)

### Is Ready?
`ability.is_ready` · `boolean` · `true | false`

At least one Ability charge ready?

### Progress To Max Charges [%]
`ability.progress_percent_to_max_charges` · `number` · `0 .. 100`

% progress to all Ability charges

### Progress To Next Charge [%]
`ability.progress_percent_to_next_charge` · `number` · `0 .. 100`

% progress to next Ability charge

### Seconds To Next Charge
`ability.cooldown_seconds_to_next_charge` · `number` · `0.0 .. n`

Seconds until next Ability charge

## Charges

### Charges
`ability.charges` · `integer` · `1 .. n`

Number of current Ability charges

### Charges Max
`ability.max_charges` · `integer` · `1 .. n`

Number of max Ability charges

## ID

### Group ID
`ability.group` · `string` · `string | nil` · id from `ability_group`

Ability Group ID; same for talent's base and improved variants

### ID
`ability.id` · `string` · `string | nil` · id from `ability`

Ability ID, e.g. veteran_combat_ability_stealth
