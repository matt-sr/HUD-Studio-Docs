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

Options:

Shapes: [Vanilla] Adapts To Class (Skitarii battery; rest are hexagon); rest are custom masks.

Fill Color: [Vanilla] Adapts To Class (Skitarii blue; rest are Red); rest are custom colors.

Fill Behaviours: 
- [Vanilla] Cooldown & Active (fills up to your next charge, drains while in active state)
- Empty Until a Charge is Ready
- Active Duration Left 
- Always Full or Always Empty


### Ability Icon Frame
`ability.icon_frame` · material · **string | nil**

Icon frame; vanilla appearance

Shape: [Vanilla] Adapts To Class; Hexagon for all but Skitarii; Hexagon; Skitarii Battery

### Ability Icon Shine
`ability.icon_glow` · material · **string | nil**

Dynamic shine/glow; vanilla appearance

Shape: [Vanilla] Adapts To Class: Hexagon for all but Skitarii; Hexagon; Skitarii Battery. Hidden while the ability is on cooldown.

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
