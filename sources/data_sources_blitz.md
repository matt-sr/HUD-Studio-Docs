Sources: `player_1`, `player_2`, `player_3`, `player_4`, `player_spectated`

### Name
`blitz.name` · string · **string | nil**

Localized blitz name

e.g. Frag Bomb

## Icon

### Color
`blitz.color` · argb · **{ a, r, g, b }**

Vanilla Blitz icon tint by charges left

Gray for no-charge (Brain Rupture); red at empty; orange at low; else white

### Icon
`blitz.icon` · material · **string | nil**

Blitz icon

### Icon (Small)
`blitz.icon_small` · material · **string | nil**

Small Blitz icon

As on the vanilla team panel

## Charges

### Count
`blitz.count` · integer · **0 .. n**

Current Blitz charges

### Count Max
`blitz.max_count` · integer · **0 .. n**

Maximum Blitz charges

### Count Percent [%%]
`blitz.count_percent` · number · **0 .. 100**

% of max Blitz charges held

### Is Ready?
`blitz.is_ready` · boolean · **true | false**

Any Blitz charges available?

### Progress To Max Charges [%%]
`blitz.progress_percent_to_max_charges` · number · **0 .. 100**

% progress to all Blitz charges

### Progress To Next Charge [%%]
`blitz.progress_percent_to_next_charge` · number · **0 .. 100**

% progress to next Blitz charge

### Refills by itself?
`blitz.is_refilling` · boolean · **true | false**

Refills by itself?

Assail refills blades over time; Immolation Grenades do not

### Seconds To Next Charge
`blitz.cooldown_seconds_to_next_charge` · number · **0.0 .. n**

Seconds until next Blitz charge

### Uses Charges?
`blitz.uses_charges` · boolean · **true | false**

Blitz uses charges?

Brain Rupture does not; grenades do

## ID

### ID
`blitz.id` · string · **string | nil** · id from `ability`

Internal Blitz ID

e.g. ogryn_grenade_bomb

## State

### Active Duration Left [%%]
`blitz.active_progress_percent` · number · **0 .. 100** · **local player only**

% of active duration remaining

0 unless the blitz names a tracking buff

### Active Seconds Left
`blitz.active_seconds` · number · **0.0 .. n** · **local player only**

Seconds remaining on active Blitz

0 unless the blitz names a tracking buff

### In Hand?
`blitz.is_equipped` · boolean · **true | false**

Currently in hand?

### Is Active?
`blitz.is_active` · boolean · **true | false**

Active, holding back its cooldown?

e.g. the Servo Skull Order
