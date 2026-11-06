A signal is something that just happened: you landed a crit, took a hit, killed an enemy. It is true once each time it happens, for a single update, then goes false.

A data source says what is true now. A signal says what just happened. Use one for hit markers, kill flashes, damage reactions and sounds.

Signals cover **you only**. In the picker: mode `Signals`, source `Player 1`, then the signal.

## What's in them

| Group          | Fires on                                      |
| -------------- | --------------------------------------------- |
| `Attack`       | swings, shots, pushes, reloads, vents         |
| `Hit`          | your hits landing: crits, DoTs, explosions    |
| `Kill`         | your kills: elites, specials, weakspots       |
| `Damage Taken` | hits on you: melee, ranged, health, toughness |
| `Defence`      | blocked hits, dodged melee attacks            |
| `Ability`      | your ability or blitz being used              |
| `Status`       | being downed, disabled, freed, dying          |

The full list is in each group's _Reference_ page.

## Using them

**[Events](../ui/events.md)** fire each time the signal does.

**[Visibility](../reference/visibility.md)** needs `Linger`. A signal on its own shows the element for one update, which looks like nothing happened. Set `Linger` to hold it on screen.

Leave `Delay` at 0 on anything a signal shows. A signal is never true long enough for a `Delay` to pass, and the element stays hidden.

**Code** reads a signal through `anim`, to play something over time:

```lua
-- Font size field: pop on a crit, then settle
local crit = signals.hit.critical_hit
local seconds = anim.play(state, "pop", crit)
local pop = seconds >= 0 and 1 - anim.window(seconds, 0, 0.3, "out_quad") or 0
font_size = 22 + (8 * pop)
```
