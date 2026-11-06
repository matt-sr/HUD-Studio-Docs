Sources: `player_1`, `player_2`, `player_3`, `player_4`, `player_spectated`

## Name

### Name
`ability.name` · string · **string | nil**

Natively localized Ability name, e.g. Shroudfield

### Name (Short)
`ability.name_simple` · string · **string | nil**

HUD Studio Ability name short-hand, e.g. Shroudfield -> *Stealth*

## Icon

### Ability Icon
`ability.icon` · material · **string | nil**

Dynamic icon; vanilla appearance

### Ability Icon (Gray til Charge)
`ability.icon_gray_til_charge` · material · **string | nil**

Dynamic icon; stays gray until charge is ready

### Ability Icon (Gray til Charge) - Hexagon
`ability.icon_hexagon_gray_til_charge` · material · **string | nil**

Dynamic icon; forces hexagon shape; stays gray until charge is ready

### Ability Icon - Hexagon
`ability.icon_hexagon` · material · **string | nil**

Dynamic icon; forces hexagon shape

### Ability Icon Frame
`ability.icon_frame` · material · **string | nil**

Icon frame; vanilla appearance

### Ability Icon Frame - Hexagon
`ability.icon_frame_hexagon` · material · **string | nil**

Icon frame; forces hexagon shape

### Ability Icon Shine
`ability.icon_frame_glow` · material · **string | nil**

Dynamic shine/glow; vanilla appearance

### Ability Icon Shine - Hexagon
`ability.icon_frame_glow_hexagon` · material · **string | nil**

Dynamic shine/glow; forces hexagon shape

## Status

### Active Duration Left [%%]
`ability.active_progress_percent` · number · **0 .. 100** · **local player only**

% of Ability `is_active` duration remaining

Applies to abilities that hold back the cooldown (e.g. Rampage) or ones that apply a temporary stance buff (e.g. Executioner's Stance)

### Active Seconds Left
`ability.active_seconds` · number · **0.0 .. n** · **local player only**

Seconds of Ability `is_active` duration remaining

Applies to abilities that hold back the cooldown (e.g. Rampage) or ones that apply a temporary stance buff (e.g. Executioner's Stance)

### Is Active?
`ability.is_active` · boolean · **true | false**

Ability is running/active?

Applies to abilities that hold back the cooldown (e.g. Rampage) or ones that apply a temporary stance buff (e.g. Executioner's Stance)

### Is Ready?
`ability.is_ready` · boolean · **true | false**

At least one Ability charge ready?

### Progress To Max Charges [%%]
`ability.progress_percent_to_max_charges` · number · **0 .. 100**

% progress to all Ability charges

### Progress To Next Charge [%%]
`ability.progress_percent_to_next_charge` · number · **0 .. 100**

% progress to next Ability charge

### Seconds To Next Charge
`ability.cooldown_seconds_to_next_charge` · number · **0.0 .. n**

Seconds until next Ability charge

## Charges

### Charges
`ability.charges` · integer · **1 .. n**

Number of current Ability charges

### Charges Max
`ability.max_charges` · integer · **1 .. n**

Number of max Ability charges

## ID

### Group ID
`ability.group` · string · **string | nil** · id from `ability_group`

Ability Group ID; same for talent's base and improved variants

### ID
`ability.id` · string · **string | nil** · id from `ability`

Ability ID, e.g. veteran_combat_ability_stealth
