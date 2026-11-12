Sources: `player_1`, `player_2`, `player_3`, `player_4`, `player_spectated`

## Heavy Charge

### Charging Heavy?
`combo.heavy_is_charging` · `boolean` · `true | false`

Charged attack is a heavy now?

### Charging Special Heavy?
`combo.heavy_is_special` · `boolean` · `true | false`

Charged heavy attack is weapon special?

### Heavy Progress [%] (To Hold Limit)
`combo.progress_percent_to_heavy_max` · `number` · `0 .. 100`

% progress to charged attack hold-limit

### Heavy Progress [%] (To Swing-Ready)
`combo.progress_percent_to_heavy_ready` · `number` · `0 .. 100`

% progress to ready heavy attack

### Heavy Ready?
`combo.heavy_is_ready` · `boolean` · `true | false`

Releasing now gives a heavy attack?

### Heavy Secs. Remaining (To Hold Limit)
`combo.heavy_max_time_remaining_seconds` · `number` · `0.0 .. n`

Seconds until charged attack at hold-limit

### Heavy Secs. Remaining (To Swing-Ready)
`combo.heavy_ready_time_remaining_seconds` · `number` · `0.0 .. n`

Seconds until heavy attack ready

### Heavy Total Seconds (To Hold Limit)
`combo.heavy_max_total_time` · `number` · `0.0 .. n`

Total seconds until charged attack hold-limit

### Heavy Total Seconds (To Swing-Ready)
`combo.heavy_ready_total_time` · `number` · `0.0 .. n`

Duration required for charged attack to be a heavy

## Heavy Charge Stages

### Heavy Charge Stage
`combo.heavy_stage` · `integer` · `0 .. n`

Current heavy attack stage

### Heavy Charge Stages [Max]
`combo.heavy_stage_max` · `integer` · `0 .. n`

How many heavy attack stages does the weapon have?

### Heavy Progress [%] (To Next Stage)
`combo.progress_percent_to_next_heavy_stage` · `number` · `0 .. 100`

% progress to next heavy attack stage

100 at the last one; 0 when not charging

### Heavy Secs. Remaining (To Next Stage)
`combo.heavy_stage_time_remaining_seconds` · `number` · `0.0 .. n`

Seconds until next heavy attack stage

0 when not charged; 0 when at the last one

## Swing

### Swing Progress [%] (To Next Attack)
`combo.progress_percent_to_swing_finish` · `number` · `0 .. 100`

% progress until next swing can start

0 when not swinging

### Swing Secs. Remaining (To Next Attack)
`combo.swing_time_remaining_seconds` · `number` · `0.0 .. n`

Seconds remaining until next swing can start

0 when not swinging

### Swing Total Seconds (To Next Attack)
`combo.swing_total_time` · `number` · `0.0 .. n`

Total seconds until next swing can start

Well before its animation ends; 0 when not swinging

### Swinging?
`combo.is_swinging` · `boolean` · `true | false`

Is any swing in progress?
