A progress bar fills by `Current / Max`, clamped to 0..1. Health, stamina, ammo, ability charge: anything with a value and a ceiling.

Bind Current and Max to a data source to make it live.

## Shapes

| Shape    | Draws                                                | Cost                             |
| -------- | ---------------------------------------------------- | -------------------------------- |
| Straight | plain rectangles, filling along one axis             | the cheapest                     |
| Curved   | an arc or semicircle, through the game's ring shader | every cell goes through a shader |
| Ring     | a ring                                               | every cell goes through a shader |

_Orientation_ picks which way the bar fills. Each shape has its own set, and switching shape resets it to the new shape's first option.

- Straight: _Left to right_, _Right to left_, _Top to bottom_, _Bottom to top_, and two _Center outwards_ fills.
- Curved: four quarter-arcs and four semicircles, each with a _Reversed Fill_ twin.
- Ring: four starting sides, each with a _Reversed Fill_ twin.

## Fields

| Field                        | What it does                                                  | Shapes           |
| ---------------------------- | ------------------------------------------------------------- | ---------------- |
| Current, Max                 | the fill is Current / Max. Max 0 reads empty                  | all              |
| Size                         | width and height, in design px                                | all              |
| Rotation                     | degrees clockwise, -360 .. 360                                | all              |
| Color                        | the fill                                                      | all              |
| Background                   | the track behind the fill                                     | all              |
| Segments                     | split the bar into cells, 1 .. 200                            | all              |
| Segment gap                  | design px between cells. Default 3                            | all              |
| Ghost trail                  | colour of the trail left where the fill dropped               | all              |
| Fill material                | an image the fill is drawn with                               | Straight, Curved |
| Fill fit                     | _Reveal_ or _Stretch_ the fill material                       | Straight         |
| Background material          | an image the track is drawn with                              | Straight         |
| Fill shadow                  | a glow around the fill or ghost trail (if same color as fill) | Straight         |
| Outline                      | a line around the fill                                        | Curved           |
| Thickness, Outline thickness | the arc's stroke, as a fraction of the ring                   | Curved           |
| Fill texture                 | a pattern inside the fill                                     | Curved           |
| Full Color Range             | redraw the arc so dark, cold colours show                     | Curved           |

Current and Max take one decimal, so a timer can fill over half a second.

## Colour and thresholds

A bar's Color is usually in `Thresholds` mode. The [Threshold Designer](../ui/threshold_designer.md) tests the bar's own Current / Max, so you set bands like "red under 30%" without binding anything twice.

In `Code` mode, Color can return a list instead of one colour. The cells are painted in fill order, and a cell without a valid entry keeps the static colour.

```lua
-- Color field, 3 segments: two red cells, then green
-- setup runs once and writes to `state`
setup({ segment_colors = { { 255, 220, 40, 40 }, { 255, 220, 40, 40 }, { 255, 60, 220, 60 } } })
color = state.segment_colors
```

## Segments

Each cell is drawn on its own: background, then fill. Cost grows with the count, much faster on a Curved bar with Full Color Range.

A _Center outwards_ Straight bar counts Segments per side, so it draws twice the cells.

## Fill materials

A Straight bar's Fill material and Background material come from a grid of game materials, or your own picture via `Image`. Each has a Flip beside it.

- **Reveal** uncovers the material as the bar fills, so the pattern stays put.
- **Stretch** squeezes and stretches the whole material within the filled part.

Counter-intuitively, certain materials behave in opposite ways with Reveal or Stretch. Use the field control's preview to decide which works better.

A textured fill may be see-through, so the whole track is drawn under it. A Solid fill skips the part of the track it covers.

## Ghost trail

Set a _Ghost trail_ colour and a drop leaves a trail behind: it holds for _Ghost delay_ seconds (default 0.3), then drains down to the fill at _Ghost speed_ (default 4, higher is faster). Gains snap the trail up at once.

Unset draws no trail. A bar hidden for more than a quarter second starts its trail at the fill, so it never slides in from an old value.

A ghost trail with the same color as the fill, a 0 delay and high speed (10-14) can create a smoothly-decreasing bar. It will also be considered the `filled` part when using `Fill Shadow`.

## Curved colours

The curved shader blends additively, so dark, blue, green or see-through colours wash out. _Full Color Range_ fixes this by drawing each cell several times, up to 16 for the darkest colours. Bright, warm colours need none.

Leave it off unless a colour looks wrong. _It can eat performance insanely quickly_, especially with more than one segment.

## Scripting

Current, Max, every colour, Segments, Segment gap, Orientation, Rotation, Size and the two materials take a `Code` mode. The rest are `Static` only. See [Node Scripts](../scripting/node_scripts.md) for the rules.

```lua
-- Current field (Max 5): count down 5 seconds after the ability is used
local used = anim.decreased(state, "charges", my.ability.charges)
local seconds = anim.play(state, "window", used)
current = seconds >= 0 and math.max(5 - seconds, 0) or 0
```

```lua
-- Segments field: one cell per grenade, with Current and Max bound to
-- blitz.count and blitz.max_count
segments = my.blitz.max_count
```

A Size in `Code` mode gets an anchor dropdown: the point of the bar that stays put while your code changes the size.

## Following the fill

Another node can read where a **Straight** bar's fill stops. `fill_edge` answers two numbers, in the same space as node offsets.

```lua
-- Position field on a marker: pin it to the end of the fill
local bar = block.get_node_by_id("bar")
local edge_x, edge_y = bar.get_value("fill_edge")
local my_x, my_y = node.get_value("offset")
shift = { edge_x - my_x, edge_y - my_y }
```

- The point sits midway across the bar's thickness.
- `ghost_edge` does the same for the end of the ghost trail. It is nil with no ghost colour.
- Curved and Ring bars answer nil.
- Keep the follower **above** the bar in the Blocks tree, on the same update rate or faster. Otherwise it trails the bar by an update.
