Sources: `subtitles`

## Lines Playing
`count` · `integer` · `0 .. n`

Audible subtitled lines playing

May exceed the 2 exposed

## Main Line

### Active?
`line_1.active` · `boolean` · `true | false`

Line playing in this slot?

### Speaker
`line_1.speaker` · `string` · `string | nil`

Speaker display name

Player name or character; "" if speakerless

### Speaker Is Player?
`line_1.speaker_is_player` · `boolean` · `true | false`

Speaker is a human player?

### Speaker Player Slot
`line_1.speaker_slot` · `integer` · `0 .. 4`

Speaking player's party slot

Bots too; 0 for an NPC

### Text
`line_1.text` · `string` · `string | nil`

Localized line

"" while nothing plays

## Secondary Line

### Active?
`line_2.active` · `boolean` · `true | false`

Line playing in this slot?

### Speaker
`line_2.speaker` · `string` · `string | nil`

Speaker display name

Player name or character; "" if speakerless

### Speaker Is Player?
`line_2.speaker_is_player` · `boolean` · `true | false`

Speaker is a human player?

### Speaker Player Slot
`line_2.speaker_slot` · `integer` · `0 .. 4`

Speaking player's party slot

Bots too; 0 for an NPC

### Text
`line_2.text` · `string` · `string | nil`

Localized line

"" while nothing plays
