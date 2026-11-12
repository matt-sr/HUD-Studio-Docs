Sources: `player_1`, `player_2`, `player_3`, `player_4`, `player_spectated`

## Icon

### Icon
`stimms.icon` · `material` · `string | nil`

Held stimm icon

```lua
local variant_options = {
    "detailed",
    "simple"
}

with_options(sources.player_1.stimms, "icon", {
    variant = variant_options[1]
})
```

## Status

### Active % Remaining
`stimms.active_percent_remaining` · `number` · `0.0 .. n` · **local player only**

% stim duration remaining; 100 = full duration

### Active Secs. Remaining
`stimms.active_seconds_remaining` · `number` · `0.0 .. n` · **local player only**

stim duration remaining

### Active?
`stimms.active` · `boolean` · `true | false` · **local player only**

whether an injected stim is currently active

### Held?
`stimms.held` · `boolean` · `true | false`

Any stimm held right now?

### Stimm In Hand?
`stimms.stimm_is_equipped` · `boolean` · `true | false`

Is the carried stim in hand?

## ID

### Active ID
`stimms.active_id` · `string` · `string | nil` · id from `stimm` · **local player only**

id of the injected stim currently active, in the same ids as the held stimm's

### ID
`stimms.id` · `string` · `string | nil` · id from `stimm`

id of the held stimm

## Hive Scum

### Held Color
`stimms.held_color` · `argb` · `{ a, r, g, b }`

Vanilla tint for held stimm

### [Hive Scum] Charges
`stimms.hive_scum_charges` · `integer` · `0 .. n`

Hive Scum stimm charges

### [Hive Scum] Charges Max
`stimms.hive_scum_max_charges` · `integer` · `0 .. n`

Max number of Hive Scum stimm charges

### [Hive Scum] Cooldown Progress [%] 
`stimms.hive_scum_progress_percent_to_next_charge` · `number` · `0.0 .. n`

% progress to next Hive Scum stimm charge

### [Hive Scum] Cooldown Seconds
`stimms.hive_scum_cooldown_seconds_to_next_charge` · `number` · `0.0 .. n`

Seconds until next Hive Scum stimm charge
