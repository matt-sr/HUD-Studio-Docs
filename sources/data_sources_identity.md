Sources: `player_1`, `player_2`, `player_3`, `player_4`, `player_spectated`

### Class
`identity.archetype` · `string` · `string | nil`

Localized character class

e.g. Veteran|Skitarii|Arbites|Hives Cum

### Class Icon (Text)
`identity.text_icon` · `string` · `string | nil`

Character class unicode glyph (text icon)

### ID
`identity.id` · `string` · `string | nil` · id from `archetype`

Character class ID

e.g. veteran|cryptic|adamant|broker

### Player Slot
`identity.slot` · `integer` · `0 .. n`

Party slot in a match (_not_ HUD Studio's player number)

### Player Slot Color
`identity.slot_color` · `argb` · `{ a, r, g, b }`

Party slot color in a match

This is what's used to tint killfeed entries, overhead markers, etc.
