## approach
`anim.approach(current: number, target: number, speed: number?): number`

ease `current` toward `target` and return the new value

| Param | Type | Notes |
|---|---|---|
| `current` | `number` |  |
| `target` | `number` |  |
| `speed` | `number?` | default 8 |

- Returns `number`

## approach_array
`anim.approach_array(current: number[], target: number[], speed: number?): number[]`

ease every component of `current` toward `target`, in place

| Param | Type | Notes |
|---|---|---|
| `current` | `number[]` | your own table -- written in place |
| `target` | `number[]` |  |
| `speed` | `number?` | default 8 |

- Returns `number[] current`

## approach_xy
`anim.approach_xy(current_xy: number[], target_xy: number[], speed: number?): number[]`

ease `current_xy` toward `target_xy`; expects { x, y }

| Param | Type | Notes |
|---|---|---|
| `current_xy` | `number[]` |  |
| `target_xy` | `number[]` |  |
| `speed` | `number?` | default 8 |

- Returns `number[]`

## approach_rgba
`anim.approach_rgba(current_rgba: number[], target_rgba: number[], speed: number?): number[]`

ease a colour toward another; expects { a, r, g, b }

| Param | Type | Notes |
|---|---|---|
| `current_rgba` | `number[]` |  |
| `target_rgba` | `number[]` |  |
| `speed` | `number?` | default 8 |

- Returns `number[]`

## since
`anim.since(state: table, key: string, value: any): number`

seconds since `value` last changed under `key`; 0 on the update it changes

| Param | Type | Notes |
|---|---|---|
| `state` | `table` | your binding's scratch (the `state` in scope) |
| `key` | `string` | a name unique within this body |
| `value` | `any` |  |

- Returns `number seconds`

## changed
`anim.changed(state: table, key: string, value: any): boolean`

true only on the update `value` differs from the previous update's

| Param | Type | Notes |
|---|---|---|
| `state` | `table` |  |
| `key` | `string` |  |
| `value` | `any` |  |

- Returns `boolean`

## increased
`anim.increased(state: table, key: string, value: any): boolean`

true only on the update `value` is higher than the previous update's (numbers)

| Param | Type | Notes |
|---|---|---|
| `state` | `table` |  |
| `key` | `string` |  |
| `value` | `any` |  |

- Returns `boolean`

## decreased
`anim.decreased(state: table, key: string, value: any): boolean`

true only on the update `value` is lower than the previous update's (numbers)

| Param | Type | Notes |
|---|---|---|
| `state` | `table` |  |
| `key` | `string` |  |
| `value` | `any` |  |

- Returns `boolean`

## ease
`anim.ease(k: number, name: string?): number`

shape a 0..1 progress: linear | in_quad | out_quad | in_out | out_back

| Param | Type | Notes |
|---|---|---|
| `k` | `number` |  |
| `name` | `string?` | linear (default) / in_quad / out_quad / in_out / out_back |

- Returns `number`

## remap
`anim.remap(v: number, in_lo: number, in_hi: number, out_lo: number, out_hi: number, clamp: boolean?): number`

rescale v from one range to another

| Param | Type | Notes |
|---|---|---|
| `v` | `number` |  |
| `in_lo` | `number` |  |
| `in_hi` | `number` |  |
| `out_lo` | `number` |  |
| `out_hi` | `number` |  |
| `clamp` | `boolean?` | true == hold the output inside out_lo..out_hi |

- Returns `number`

## osc
`anim.osc(period: number, lo: number?, hi: number?, phase: number?): number`

sine oscillation over `period` seconds, in lo..hi (default 0..1)

| Param | Type | Notes |
|---|---|---|
| `period` | `number` | seconds for one full cycle |
| `lo` | `number?` | default 0 |
| `hi` | `number?` | default 1 |
| `phase` | `number?` | 0..1, default 0 |

- Returns `number`

## mix
`anim.mix(a: table, b: table, k: number, out: table?): table`

blend two { a, r, g, b } / { x, y } arrays; pass `out` to reuse a table

| Param | Type | Notes |
|---|---|---|
| `a` | `table` |  |
| `b` | `table` |  |
| `k` | `number` |  |
| `out` | `table?` |  |

- Returns `table`

## every
`anim.every(state: table, key: string, period: number): boolean`

true on one update per `period` seconds; a repeating tick, no maths on t

| Param | Type | Notes |
|---|---|---|
| `state` | `table` |  |
| `key` | `string` |  |
| `period` | `number` | seconds between ticks |

- Returns `boolean`

## shake
`anim.shake(amp : number, out: table?): number[] | number, number`

smooth sine shake for amplitude 'amp', reuses 'out' if passed

| Param | Type | Notes |
|---|---|---|
| `amp` | `number` |  |
| `out` | `table?` |  |

- Returns `number, number | table`

## play
`anim.play(state: table, key: string, trigger: any, sequence_length: (number|(string|number)[])?): number`

seconds since `trigger` last turned on; -1 if it never has. Pass a length (seconds or a step list) to ignore re-triggers until it has run

| Param | Type | Notes |
|---|---|---|
| `state` | `table` | your binding's scratch (the `state` in scope) |
| `key` | `string` | a name unique within this body |
| `trigger` | `any` | starts the clock each time it turns truthy |
| `sequence_length` | `(number|(string|number)[])?` | ignore re-triggers until this has run |

- Returns `number seconds_elapsed`: -1 when not started

## stop
`anim.stop(state: table, key: string)`

stop a `play` clock: it reads -1 until its trigger turns on again

| Param | Type | Notes |
|---|---|---|
| `state` | `table` |  |
| `key` | `string` |  |

## steps
`anim.steps(seconds_elapsed: number, step_list: (string|number)[], loop: boolean?): string?, number`

which step of { name, seconds, ... } is running, and how far through it (0..1)

| Param | Type | Notes |
|---|---|---|
| `seconds_elapsed` | `number` |  |
| `step_list` | `(string|number)[]` | { name, seconds, name, seconds, ... } |
| `loop` | `boolean?` |  |

- Returns `string? current_step_name`
- Returns `number step_progress`: 0..1 through the current step

## window
`anim.window(seconds_elapsed: number, slice_start_seconds: number, slice_duration_seconds: number, ease_name: string?): number`

progress (0..1) through one slice of time, eased

| Param | Type | Notes |
|---|---|---|
| `seconds_elapsed` | `number` |  |
| `slice_start_seconds` | `number` |  |
| `slice_duration_seconds` | `number` |  |
| `ease_name` | `string?` | see `ease`; default linear |

- Returns `number slice_progress`

