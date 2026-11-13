Sources: `player_1`, `player_spectated`

## Identity

### ID
`buffs.id` · `string` · `string | nil` · **local player only**

The Buff ID this reads

Reads the buff named by **Buff ID**. Pick one with the Search button; a `*` matches any text, so one ID covers a blessing on any weapon. Reads empty while the buff isn't on you.

```lua
with_options(sources.player_1.buffs, "id", {
    buff_id = ""
})
```

```lua
-- Code mode: name the buff with with_options
return with_options(player_1.buffs, "stacks", { buff_id = "veteran_snipers_focus_stat_buff" })
```

### Name
`buffs.name` · `string` · `string | nil` · **local player only**

A blessing's or talent's in-game name, else the Buff ID tidied for display

```lua
with_options(sources.player_1.buffs, "name", {
    buff_id = ""
})
```

### Icon
`buffs.icon` · `material` · `string | nil` · **local player only**

The buff's buff bar icon

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

with_options(sources.player_1.buffs, "icon", {
    buff_id = "",
    mask = mask_options[1],
    ramp = ramp_options[1],
    fill_behaviour = fill_behaviour_options[1]
})
```

## Status

### Is Active?
`buffs.is_active` · `boolean` · `true | false` · **local player only**

On you now? A proc: its effect is running

```lua
with_options(sources.player_1.buffs, "is_active", {
    buff_id = ""
})
```

### Active Seconds Left
`buffs.active_seconds` · `number` · `0.0 .. n` · **local player only**

Seconds left on the buff

```lua
with_options(sources.player_1.buffs, "active_seconds", {
    buff_id = ""
})
```

### Active Duration Left [%]
`buffs.active_progress_percent` · `number` · `0 .. 100` · **local player only**

Time left, 100 to 0

```lua
with_options(sources.player_1.buffs, "active_progress_percent", {
    buff_id = ""
})
```

### Buff Bar Fill [%]
`buffs.buff_bar_progress_percent` · `number` · `0 .. 100` · **local player only**

The vanilla buff bar's fill for it, 0 to 100

```lua
with_options(sources.player_1.buffs, "buff_bar_progress_percent", {
    buff_id = ""
})
```

### Adaptive Fill [%]
`buffs.adaptive_progress_percent` · `number` · `0 .. 100` · **local player only**

Cooldown, else time left, else stack timer, else a keystone's build-up stacks %; 0 idle, 100 passive

```lua
with_options(sources.player_1.buffs, "adaptive_progress_percent", {
    buff_id = ""
})
```

## Stacks

### Stacks
`buffs.stacks` · `integer` · `0 .. n` · **local player only**

Current stacks

```lua
with_options(sources.player_1.buffs, "stacks", {
    buff_id = ""
})
```

### Max Stacks
`buffs.max_stacks` · `integer` · `0 .. n` · **local player only**

Stack cap

```lua
with_options(sources.player_1.buffs, "max_stacks", {
    buff_id = ""
})
```

### Stacks [%]
`buffs.stacks_percent` · `number` · `0 .. 100` · **local player only**

Stacks as % of the cap

```lua
with_options(sources.player_1.buffs, "stacks_percent", {
    buff_id = ""
})
```

### At Max Stacks?
`buffs.at_max_stacks` · `boolean` · `true | false` · **local player only**

At the stack cap?

```lua
with_options(sources.player_1.buffs, "at_max_stacks", {
    buff_id = ""
})
```

### Seconds To Stack Drop
`buffs.stack_seconds` · `number` · `0.0 .. n` · **local player only**

Seconds until the next stack drops

```lua
with_options(sources.player_1.buffs, "stack_seconds", {
    buff_id = ""
})
```

### Stack Time Left [%]
`buffs.stack_progress_percent` · `number` · `0 .. 100` · **local player only**

Time left until the next stack drops, 100 to 0

```lua
with_options(sources.player_1.buffs, "stack_progress_percent", {
    buff_id = ""
})
```

### Seconds To 0 Stacks
`buffs.zero_stacks_seconds` · `number` · `0.0 .. n` · **local player only**

Seconds until every stack has dropped

```lua
with_options(sources.player_1.buffs, "zero_stacks_seconds", {
    buff_id = ""
})
```

## Cooldown

### On Cooldown?
`buffs.is_on_cooldown` · `boolean` · `true | false` · **local player only**

A proc is cooling down?

```lua
with_options(sources.player_1.buffs, "is_on_cooldown", {
    buff_id = ""
})
```

### Cooldown Seconds
`buffs.cooldown_seconds` · `number` · `0.0 .. n` · **local player only**

Seconds until the proc is ready

```lua
with_options(sources.player_1.buffs, "cooldown_seconds", {
    buff_id = ""
})
```

### Cooldown Progress [%]
`buffs.cooldown_progress_percent` · `number` · `0 .. 100` · **local player only**

Proc cooldown progress, 0 to 100

```lua
with_options(sources.player_1.buffs, "cooldown_progress_percent", {
    buff_id = ""
})
```
