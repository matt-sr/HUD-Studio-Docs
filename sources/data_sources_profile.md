Sources: `player_1`, `player_2`, `player_3`, `player_4`, `player_spectated`

### Insignia
`profile.insignia` · `material` · `string | nil`

Player insignia

### Portrait
`profile.portrait` · `material` · `string | nil`

Player portrait; frame + head shot

Part(s):
- Frame + Head
- Frame Only
- Head Only

Tint When Dead (grey out while dead or disabled):
- Yes
- No				


```lua
local part_options = {
    "full",
    "head",
    "frame"
}

local tint_when_dead_options = {
    "yes",
    "no"
}

with_options(sources.player_1.profile, "portrait", {
    part = part_options[1],
    tint_when_dead = tint_when_dead_options[1]
})
```

## Name

### Account Name
`profile.account_name` · `string` · `string | nil`

Platform account name

e.g. Steam persona, Xbox gamertag; nil for a bot

### Name
`profile.name` · `string` · `string | nil`

Character name

### Platform Icon
`profile.platform_icon` · `string` · `string | nil`

Platform icon glyph

Steam, Xbox, PlayStation or the cross-network one; nil for a bot

## Levels

### Havoc Rank
`profile.havoc_rank` · `integer` · `0 .. 40`

Highest Havoc rank in current cadence

### Level
`profile.level` · `integer` · `0 .. 30 | nil`

Character level, clamped at level cap

### Levels Past Cap
`profile.extra_levels` · `integer` · `0 .. n`

Levels earned past the level cap

### Prestige
`profile.prestige` · `integer` · `0 .. n`

Times total XP covers the entire level track

### Total Level
`profile.total_level` · `integer` · `0 .. n`

Character level including levels past the cap

## Title

### Title
`profile.title` · `string` · `string | nil`

Equipped character title

nil when none

### Title Color
`profile.title_color` · `argb` · `{ a, r, g, b }`

Title's rarity color

The desaturated variant the game tints titles with; nil for no title or a title with no rarity

## Location

### Location (Gamemode)
`profile.location` · `string` · `string | nil`

Where the player is, as the game names it

e.g. Mourningstar, mission, Psykhanium; a party member elsewhere reports their own

## Mods

### [Mod] 'State Your Name' Name
`profile.syn_display_name` · `string` · `string | nil`

Character name with State Your Name's formatting

### [Mod] 'True Level' Name
`profile.tl_display_name` · `string` · `string | nil`

Character name with True Level's level suffix
