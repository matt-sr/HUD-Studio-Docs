Fade In and Fade Out blend a block or node in and out instead of cutting it. They sit on the _Timing_ card in the Visibility section, with the easing on the card's title bar.

| Setting  | Does                                            |
| -------- | ----------------------------------------------- |
| Fade In  | seconds to go from hidden to fully shown        |
| Fade Out | seconds to go from fully shown to hidden        |
| Easing   | `Linear`, or `Ease In-Out` (slow start and end) |

Each is up to 2 seconds. 0 snaps.

## How it moves

- The time is for a **full** fade. A fade that turns around halfway takes half as long to go back.
- Easing only shapes the visibility fade, not opacity changes.
- A block's first answer after loading snaps, so blocks don't fade in when the game starts or a document loads. A node with Fade In set does fade in the first time its block draws.

## What fades

| Change                             | Fades             |
| ---------------------------------- | ----------------- |
| Visibility rule turns true / false | yes               |
| Eye switched on / off              | yes               |
| Gamemode / class filter            | yes               |
| A group's eye                      | no, it cuts       |
| Selected or hovered in the editor  | no, shown at full |

## With Linger and Delay

Linger and Delay decide when the fade starts:

- Delay runs out, then Fade In.
- Linger runs out, then Fade Out.

See [Linger & Delay](linger_delay.md).

## Opacity

A block's or node's [Opacity](../reference/opacity.md) changes at the same speeds: rising uses Fade In, falling uses Fade Out. With both at 0 it snaps.

The fade and the opacity multiply. A block at 0.5 opacity, halfway through fading in, draws at 0.25.

A node is multiplied by its block too. A node at 0.5 in a block at 0.5 draws at 0.25.

## Scripts while fading

A block or node fading out still draws, so its node scripts keep running until it reaches 0. A node's other fields stop only once it is fully faded out.

The block script keeps running through a fade-out caused by the block's rules. It stops at once when the fade-out comes from the eye or a filter.

## Fading in code

Fade In and Fade Out only follow visibility. To fade on anything else, ease the Opacity field yourself:

```lua
-- a node's Opacity field: dim to 30% while not attacking
local is_attacking = my.state.attacking
local target_opacity = is_attacking and 1 or 0.3

-- speed 4: higher is faster
state.opacity = anim.approach(state.opacity, target_opacity, 4)
opacity = state.opacity
```

Leave Fade In and Fade Out at 0 when a script eases the opacity itself, or the two stack and the change lags.

To fade in once each time a node appears:

```lua
-- a node's Opacity field: fade in over 0.5 seconds on each appearance
local seconds_shown = anim.play(state, "appear", became_visible)
local progress = anim.window(seconds_shown, 0, 0.5, "in_out")
opacity = progress
```

`anim.play` returns -1 before it has started; `window` reads that as 0.

## Good to know

- Fades cost almost nothing. A block with no code still ticks quickly while it is fading.
- Timing copies with the card's right-click menu, and pastes between blocks and nodes.
