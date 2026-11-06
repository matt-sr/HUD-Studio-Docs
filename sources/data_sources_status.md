Sources: `player_1`, `player_2`, `player_3`, `player_4`, `player_spectated`

## Vitals

### Corruption
`status.corruption` · number · **0.0 .. n**

Amount of current corruption damage

### Corruption [%%]
`status.corruption_percent` · number · **0 .. 100**

% of current corruption damage relative to max health

### Has Golden Toughness?
`status.has_golden_toughness` · boolean · **true | false**

Is golden toughness active?

### Health
`status.health` · number · **0.0 .. n**

Current health

### Health Max
`status.health_max` · number · **0.0 .. n**

Maximum health

### Health [%%]
`status.health_percent` · number · **0 .. 100**

% of current health

### Stamina
`status.stamina` · number · **0.0 .. n**

Current stamina

### Stamina Max
`status.stamina_max` · number · **0.0 .. n**

Maximum stamina

### Stamina [%%]
`status.stamina_percent` · number · **0 .. 100**

% of maximum stamina

### Toughness
`status.toughness` · number · **0.0 .. n**

Current toughness, gold and blue combined

### Toughness (Blue)
`status.toughness_regular` · number · **0.0 .. n**

Current blue toughness

### Toughness (Golden)
`status.toughness_gold` · number · **0.0 .. n**

Current golden toughness

### Toughness Broken?
`status.toughness_broken` · boolean · **true | false**

Is toughness broken (at 0)?

### Toughness Color
`status.toughness_color` · argb · **{ a, r, g, b }**

Vanilla toughness bar color

Gold while golden toughness is active; otherwise blue

### Toughness Max (Blue)
`status.toughness_regular_max` · number · **0.0 .. n**

Maximum blue toughness

### Toughness [%%]
`status.toughness_percent` · number · **0..100 (+n at gold toughness)**

Total toughness as % of maximum blue

### Toughness [%%] (Blue)
`status.toughness_regular_percent` · number · **0 .. 100**

% of maximum blue toughness

### Wounds
`status.wounds` · integer · **0 .. n**

Current health segments

### Wounds Max
`status.wounds_max` · integer · **0 .. n**

Maximum health segments

## Combat

### Crit Chance [%%]
`status.crit_chance_percent` · number · **0 .. 100** · **local player only**

% critical strike chance of wielded weapon

## Movement

### Dodge Refresh [%%]
`status.dodge_refresh_percent` · number · **0 .. 100**

% progress of consecutive-dodge reset timer

0 while still dodging; 100 once dodges have refreshed

### Dodge Refresh [s]
`status.dodge_refresh_seconds` · number · **0.0 .. n**

Seconds until consecutive dodges reset

0 while still dodging; 0 once refreshed

### Dodges
`status.dodges` · integer · **-n..n**

Efficient dodges remaining

Negative past the cap

### Dodges (Clamped to 0)
`status.dodges_clamped` · integer · **0 .. n**

Efficient dodges remaining, clamped to 0

### Dodges Max
`status.dodges_max` · integer · **0 .. n**

Maximum efficient dodges

## Psyker

### Peril Lockout?
`status.peril_quell_lockout` · boolean · **true | false** · **local player only**

At peril lockout? (About to explode)

### Peril [%%]
`status.peril_percent` · number · **0 .. 100**

% of current peril
